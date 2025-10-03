import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final featureName = context.vars['feature_name'] as String;
  final pascalName = featureName
      .split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join();

  final injectorFile = File('lib/core/di/injector.dart');

  final initDependencies = File('lib/core/di/init_dependencies.dart');

  if (!injectorFile.existsSync()) {
    context.logger.err('❌ injector.dart not found!');
    return;
  }

  if (!initDependencies.existsSync()) {
    context.logger.err('❌ init_dependencies.dart not found!');
    return;
  }

  var content = injectorFile.readAsStringSync();
  var initContent = initDependencies.readAsStringSync();

  // Import
  final importLine = "import '../../features/${featureName}/${featureName}_injector.dart';";

  if (!initContent.contains(importLine)) {
    final regex = RegExp(r'(import .+;\n)+');
    final match = regex.firstMatch(initContent);
    if (match != null) {
      initContent = initContent.replaceRange(
        match.end,
        match.end,
        "$importLine\n",
      );
    }
  }

  // Add init call
  final registerLine =
      "  await ${pascalName}Injector.init(); // registers $pascalName feature";

  if (!content.contains(registerLine)) {
    content = content.replaceFirst(
      '//[FEATURE_INJECTORS]',
      '//[FEATURE_INJECTORS]\n$registerLine\n',
    );
  }

  injectorFile.writeAsStringSync(content);
  initDependencies.writeAsStringSync(initContent);

  context.logger.info('✔ Registered $pascalName in injector.dart');
}
