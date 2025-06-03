import 'package:get/get.dart';
import '../../domain/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';

class {{feature_name.pascalCase()}}Controller extends GetxController {
  final {{feature_name.pascalCase()}}UseCase? {{feature_name.snakeCase()}}UseCase;
  {{feature_name.pascalCase()}}Controller({this.{{feature_name.snakeCase()}}UseCase});
}