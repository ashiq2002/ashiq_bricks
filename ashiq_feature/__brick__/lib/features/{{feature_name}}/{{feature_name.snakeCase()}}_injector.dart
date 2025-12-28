import '../../core/di/init_dependencies.dart';
import 'data/repositories/{{feature_name.snakeCase()}}_repository_impl.dart';
import 'domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'domain/usecase/{{feature_name.snakeCase()}}_usecase.dart';

{{#use_bloc}}
import 'presentation/bloc/{{feature_name.snakeCase()}}_bloc.dart';
{{/use_bloc}}

class {{feature_name.pascalCase()}}Injector {
  /// Initialize {{feature_name.pascalCase()}} feature dependencies
  static Future<void> init() async {

    // Remote Data Source
    sl.registerLazySingleton<{{feature_name.pascalCase()}}RemoteDataSource>(
      () => {{feature_name.pascalCase()}}RemoteDataSourceImpl(
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
        repository: sl<{{feature_name.pascalCase()}}Repository>(),
      ),
    );

    {{#use_bloc}}
    // Bloc
    sl.registerFactory(
      () => {{feature_name.pascalCase()}}Bloc(
        useCase: sl<{{feature_name.pascalCase()}}UseCase>(),
      ),
    );
    {{/use_bloc}}
  }
}
