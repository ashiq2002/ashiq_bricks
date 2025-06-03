import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/{{feature_name.snakeCase()}}_repository.dart';


class {{feature_name.pascalCase()}}UseCase implements UseCase<{{feature_name.pascalCase()}}Response, Get{{feature_name.pascalCase()}}Params> {
  final {{feature_name.pascalCase()}}Repository? {{feature_name.snakeCase()}}Repository;
  {{feature_name.pascalCase()}}UseCase({this.{{feature_name.snakeCase()}}Repository});
  @override
  Future<Either<Failure, {{feature_name.pascalCase()}}Response>> call(Get{{feature_name.pascalCase()}}Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class Get{{feature_name.pascalCase()}}Params{
  final String? path;
  final Map<String, dynamic>? query;
  final Map<String, dynamic>? body;

  {{feature_name.pascalCase()}}Params({
    this.path,
    this.query,
    this.body,
  });
}