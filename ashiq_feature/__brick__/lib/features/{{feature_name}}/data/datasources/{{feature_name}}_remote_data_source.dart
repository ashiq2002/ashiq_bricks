
import 'package:get/get.dart';
import 'package:{{feature_name.snakeCase()}}/core/error/server_exception.dart';
import 'package:{{feature_name.snakeCase()}}/core/network/api_client.dart';
import 'package:{{feature_name.snakeCase()}}/core/strings/api_endpoint.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/data/models/{{feature_name.snakeCase()}}_response.dart';
import 'package:{{feature_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/domain/usecases/get_{{feature_name.snakeCase()}}_params.dart';

abstract class {{feature_name.pascalCase()}}RemoteDataSource {
    Future<{{feature_name.pascalCase()}}Response?> login(Get{{feature_name.pascalCase()}}Params params);
}

class {{feature_name.pascalCase()}}RemoteSourceImpl implements {{feature_name.pascalCase()}}RemoteSource {
  final ApiClient apiClient;
  {{feature_name.pascalCase()}}RemoteSourceImpl({required this.apiClient});

  @override
  Future<{{feature_name.pascalCase()}}Response?> login(Get{{feature_name.pascalCase()}}Params params) async {
    // TODO: implement login
    try {
      final result = await apiClient.post(
          url: ApiEndpoint.LOGIN,
          body: params.body,
          showResult: true,
          isBasic: true,
          code: 200,
          duration: 30);
      return {{feature_name.pascalCase()}}Response.fromJson(result!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}