import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final featureName = context.vars['feature_name'] as String;
  final pascalName = featureName
      .split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join();

  final injectorFile = File('lib/di/injector.dart');

  if (!injectorFile.existsSync()) {
    context.logger.err('❌ injector.dart not found!');
    return;
  }

  var content = injectorFile.readAsStringSync();

  // Import
  final importLine =
      "import 'package:your_app/features/${featureName}/${featureName}_injector.dart';";

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

  // Add init call
  final registerLine =
      "  await ${pascalName}Injector.init(injector); // registers $pascalName feature";

  if (!content.contains(registerLine)) {
    content = content.replaceFirst(
      'Future<void> initDependencies() async {',
      'Future<void> initDependencies() async {\n$registerLine\n',
    );
  }

  injectorFile.writeAsStringSync(content);

  context.logger.info('✔ Registered $pascalName in injector.dart');
}
