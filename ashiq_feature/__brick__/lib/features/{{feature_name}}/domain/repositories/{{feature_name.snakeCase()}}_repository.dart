import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import '../../../../core/common/models/success_response.dart';

abstract class {{feature_name.pascalCase()}}Repository {
  Future<Either<Failure, SuccessResponse?>> login(Get{{feature_name.pascalCase()}}Params params);
}
