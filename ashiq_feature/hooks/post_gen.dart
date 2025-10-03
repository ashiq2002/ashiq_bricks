import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) async {
  final brickName = context.vars['name'] as String? ?? '';
  final featureName = context.vars['feature_name'] as String? ?? '';
  final pascalName = featureName.isNotEmpty
      ? featureName
          .split('_')
          .map((e) => e[0].toUpperCase() + e.substring(1))
          .join()
      : '';

  // -----------------------------
  // Update injector only if feature_name exists
  // -----------------------------
  if (featureName.isNotEmpty) {
    final injectorFile = File('lib/core/di/injector.dart');

    if (!injectorFile.existsSync()) {
      context.logger.err('❌ injector.dart not found!');
      return;
    }

    var content = injectorFile.readAsStringSync();

    // Import line
    final importLine =
        "import '../features/${featureName}/${featureName}_injector.dart';";

    if (!content.contains(importLine)) {
      final regex = RegExp(r'(import .+;\n)+');
      final match = regex.firstMatch(content);
      if (match != null) {
        content = content.replaceRange(
          match.end,
          match.end,
          "$importLine\n",
        );
      }
    }

    // Register line
    final registerLine =
        "  await ${pascalName}Injector.init(); // registers $pascalName feature";

    if (!content.contains(registerLine)) {
      content = content.replaceFirst(
        'Future<void> initDependencies() async {',
        'Future<void> initDependencies() async {\n$registerLine\n',
      );
    }

    injectorFile.writeAsStringSync(content);

    context.logger.info('✔ Registered $pascalName in injector.dart');
  }

  // -----------------------------
  // Only run dependency installer for "ashiq_project"
  // -----------------------------
  if (brickName == 'ashiq_project') {
    final gotDeps = context.logger.prompt(
      '📦 Do you want to install dependencies for this project? (y/n)',
    );

    if (gotDeps.toLowerCase() == 'y') {
      final depsFile = File('required_dependencies.yml');

      if (!depsFile.existsSync()) {
        context.logger.warn('⚠️ No required_dependencies.yml found, skipping...');
        return;
      }

      final yamlContent = loadYaml(depsFile.readAsStringSync());

      if (yamlContent is YamlMap) {
        // Normal dependencies
        if (yamlContent['dep'] != null) {
          for (final dep in yamlContent['dep']) {
            _runCommand('flutter', ['pub', 'add', dep.toString()], context);
          }
        }
        // Dev dependencies
        if (yamlContent['dev'] != null) {
          for (final dep in yamlContent['dev']) {
            _runCommand('flutter', ['pub', 'add', '--dev', dep.toString()], context);
          }
        }
      }

      context.logger.info('✅ Dependencies installed successfully');
    }
  }
}

void _runCommand(String cmd, List<String> args, HookContext context) {
  final result = Process.runSync(cmd, args);
  if (result.exitCode == 0) {
    context.logger.info('✔ ${cmd} ${args.join(" ")}');
  } else {
    context.logger.err('❌ Failed: ${cmd} ${args.join(" ")}\n${result.stderr}');
  }
}
