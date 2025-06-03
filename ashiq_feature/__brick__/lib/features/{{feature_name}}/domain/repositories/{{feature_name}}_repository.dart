import 'package:fpdart/fpdart.dart';
import 'package:{{feature_name.snakeCase()}}/core/error/failures.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/models/{{feature_name.snakeCase()}}_response.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/usecases/get_{{feature_name.snakeCase()}}_params.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, {{feature_name.pascalCase()}}Response>> login(Get{{feature_name.pascalCase()}}Params params);
}
