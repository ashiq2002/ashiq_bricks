import 'package:get/get.dart';
import '../../core/di/init_dependencies.dart';
import '../../core/network/connection_checker.dart';
import 'data/datasources/{{feature_name.snakeCase()}}_remote_data_source.dart';
import 'data/repositories/{{feature_name.snakeCase()}}_repository_impl.dart';
import 'domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'domain/usecase/{{feature_name.snakeCase()}}_usecase.dart';
{{#use_bloc}}
import 'presentation/bloc/{{feature_name.snakeCase()}}_bloc.dart';
{{/use_bloc}}
{{#use_getx}}
import 'presentation/controllers/{{feature_name.snakeCase()}}_controller.dart';
{{/use_getx}}

class {{feature_name.pascalCase()}}Injector {
  /// Initialize {{feature_name.pascalCase()}} feature dependencies
  static Future<void> init() async {

    // Remote Data Source
    sl.registerLazySingleton<{{feature_name.pascalCase()}}RemoteDataSource>(
      () => {{feature_name.pascalCase()}}RemoteSourceImpl(
        apiClient: sl(), // Make sure ApiClient is already registered
      ),
    );

    // Repository
    sl.registerLazySingleton<{{feature_name.pascalCase()}}Repository>(
      () => {{feature_name.pascalCase()}}RepositoryImpl(
        remoteSource: sl<{{feature_name.pascalCase()}}RemoteDataSource>(),
        connectionChecker: sl<ConnectionChecker>(),
      ),
    );

    // UseCase
    sl.registerLazySingleton(
      () => {{feature_name.pascalCase()}}UseCase(
        {{feature_name.snakeCase()}}Repository: sl<{{feature_name.pascalCase()}}Repository>(),
      ),
    );

    {{#use_bloc}}
    // Bloc
    sl.registerFactory(
      () => {{feature_name.pascalCase()}}Bloc(
        {{feature_name.snakeCase()}}UseCase: sl<{{feature_name.pascalCase()}}UseCase>(),
      ),
    );
    {{/use_bloc}}

    {{#use_getx}}
    // GetX-controller
    Get.lazyPut<{{feature_name.pascalCase()}}Controller>(
      () => {{feature_name.pascalCase()}}Controller({{feature_name.snakeCase()}}UseCase: sl<{{feature_name.pascalCase()}}UseCase>()),
    );
    {{/use_getx}}
  }
}
