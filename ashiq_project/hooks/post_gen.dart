import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  // Get the path of the current script
  final scriptDir = File.fromUri(Platform.script).parent.path;

  // required_dependencies.yml is in the brick root, so go one level up from hooks
  final file = File('$scriptDir/../required_dependencies.yml');

  if (!file.existsSync()) {
    context.logger.err('required_dependencies.yml not found!');
    return;
  }

  final yamlContent = file.readAsStringSync();
  final doc = loadYaml(yamlContent);

  // Install normal dependencies
  final deps = doc['dep'] as YamlList? ?? [];
  for (var dep in deps) {
    context.logger.info('Adding dependency: $dep');
    Process.runSync('flutter', ['pub', 'add', dep], runInShell: true);
  }

  // Install dev dependencies
  final devDeps = doc['dev'] as YamlList? ?? [];
  for (var dep in devDeps) {
    context.logger.info('Adding dev dependency: $dep');
    Process.runSync('flutter', ['pub', 'add', '--dev', dep], runInShell: true);
  }

  context.logger.success('Dependencies installation completed!');
}
