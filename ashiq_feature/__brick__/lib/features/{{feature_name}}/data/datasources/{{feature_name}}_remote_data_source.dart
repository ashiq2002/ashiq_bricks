
import '../../../../core/error/server_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/config/strings/api_endpoint.dart';
import '../models/{{feature_name.snakeCase()}}_response.dart';
import '../../domain/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';

abstract class {{feature_name.pascalCase()}}RemoteDataSource {
    Future<{{feature_name.pascalCase()}}Response?> login(Get{{feature_name.pascalCase()}}Params params);
}

class {{feature_name.pascalCase()}}RemoteSourceImpl implements {{feature_name.pascalCase()}}RemoteDataSource {
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