import 'dart:io';

void run(HookContext context) {
  final featureName = context.vars['feature_name'] as String;
  final pascal = _toPascalCase(featureName);
  final snake = _toSnakeCase(featureName);

  final injectorFile = File('lib/di/injector.dart');
  if (!injectorFile.existsSync()) {
    context.logger.err('injector.dart not found in lib/di/');
    return;
  }

  var content = injectorFile.readAsStringSync();

  // Add import
  final importLine =
      "import 'package:your_app/features/$snake/${snake}_injector.dart';";
  if (!content.contains(importLine)) {
    content = content.replaceFirst('// [FEATURE_IMPORTS]',
        "$importLine\n// [FEATURE_IMPORTS]");
  }

  // Add init call with comment
  final callLine = "await ${pascal}Injector.init();";
  if (!content.contains(callLine)) {
    content = content.replaceFirst('// [FEATURE_INJECTORS]',
        "  /// Register dependencies for $pascal feature\n  $callLine\n  // [FEATURE_INJECTORS]");
  }

  injectorFile.writeAsStringSync(content);
  context.logger.info('✔ Added $pascalInjector to injector.dart');
}

String _toSnakeCase(String input) =>
    input.replaceAllMapped(RegExp(r'[A-Z]'), (m) => "_${m[0]!.toLowerCase()}").replaceFirst('_', '');

String _toPascalCase(String input) =>
    input.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join();
