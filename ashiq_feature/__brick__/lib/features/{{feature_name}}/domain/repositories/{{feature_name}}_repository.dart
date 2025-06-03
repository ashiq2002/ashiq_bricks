import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/{{feature_name.snakeCase()}}_response.dart';
import '../usecase/get_{{feature_name.snakeCase()}}_params.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, {{feature_name.pascalCase()}}Response>> login(Get{{feature_name.pascalCase()}}Params params);
}
