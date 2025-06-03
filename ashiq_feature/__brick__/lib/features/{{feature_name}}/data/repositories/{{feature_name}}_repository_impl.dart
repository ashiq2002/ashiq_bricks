import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:{{feature_name.snakeCase()}}/core/error/failure.dart';
import 'package:{{feature_name.snakeCase()}}/core/error/server_exception.dart';
import 'package:{{feature_name.snakeCase()}}/core/network/connection_checker.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/models/{{feature_name.snakeCase()}}_response.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/repositories/login_repository.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/usecases/get_login_params.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/datasources/login_remote_data_source.dart';

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
