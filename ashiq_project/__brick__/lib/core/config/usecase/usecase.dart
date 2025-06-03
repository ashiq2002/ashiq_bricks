import 'package:fpdart/fpdart.dart';
import 'package:{{feature_name.snakeCase()}}/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}