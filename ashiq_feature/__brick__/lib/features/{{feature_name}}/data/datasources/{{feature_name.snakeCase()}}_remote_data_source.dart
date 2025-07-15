
import '../../../../core/error/server_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/config/strings/api_endpoint.dart';
import '../../domain/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
import '../../../../core/common/model/success_response.dart';

abstract class {{feature_name.pascalCase()}}RemoteDataSource {
    Future<SuccessResponse?> login(Get{{feature_name.pascalCase()}}Params params);
}

class {{feature_name.pascalCase()}}RemoteSourceImpl implements {{feature_name.pascalCase()}}RemoteDataSource {
  final ApiClient apiClient;
  {{feature_name.pascalCase()}}RemoteSourceImpl({required this.apiClient});

  @override
  Future<SuccessResponse?> login(Get{{feature_name.pascalCase()}}Params params) async {
    // TODO: implement login
    try {
      final result = await apiClient.post(
          api: ApiEndpoint.login,
          body: params.body
          );
      return SuccessResponse.fromJson(result.data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}