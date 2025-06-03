import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/server_exception.dart';
import '../../../../core/network/connection_checker.dart';
import '../models/{{feature_name.snakeCase()}}_response.dart';
import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import '../../domain/usecase/get_{{feature_name.snakeCase()}}_params.dart';
import '../datasources/login_remote_data_source.dart';

class {{feature_name.pascalCase()}}RepositoryImpl implements {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}RemoteSource remoteSource;
  final ConnectionChecker connectionChecker;

  {{feature_name.pascalCase()}}RepositoryImpl(
      {required this.remoteSource, required this.connectionChecker});

  @override
  Future<Either<Failure, {{feature_name.pascalCase()}}Response>> login(Get{{feature_name.pascalCase()}}Params params) async {
    // TODO: implement login
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("no internet connection!!"));
      } else {
        final data = await remoteSource.login(params);
        if (data!.issuccess == false) {
          return left(Failure(data.message ?? "Failed to login", 0, data.data?.code ?? ""));
        } else {
          return right(data);
        }
      }
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  
}
