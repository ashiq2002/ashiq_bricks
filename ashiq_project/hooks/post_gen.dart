import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  final file = File('required_dependencies.yml');
  if (!file.existsSync()) {
    context.logger.err('required_dependencies.yml not found!');
    return;
  }

  final yamlContent = file.readAsStringSync();
  final doc = loadYaml(yamlContent);


  // Normal dependencies
  final deps = (doc['dep'] as YamlList?)?.map((e) => e.toString()).toList() ?? [];
  if (deps.isNotEmpty) {
    final depsStr = deps.join(' '); // join by space
    context.logger.info('Adding dependencies: $depsStr');
    Process.runSync('flutter', ['pub', 'add', ...deps], runInShell: true);
  }

  // Dev dependencies
  final devDeps = (doc['dev'] as YamlList?)?.map((e) => e.toString()).toList() ?? [];
  if (devDeps.isNotEmpty) {
    final devDepsStr = devDeps.join(' ');
    context.logger.info('Adding dev dependencies: $devDepsStr');
    Process.runSync('flutter', ['pub', 'add', '--dev', ...devDeps], runInShell: true);
  }

  context.logger.success('Dependencies installation completed!');
}
