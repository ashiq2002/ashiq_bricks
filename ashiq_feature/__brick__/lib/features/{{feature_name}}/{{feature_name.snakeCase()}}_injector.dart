import '../../core/di/injector.dart';
import 'data/repositories/{{feature_name.snakeCase()}}_repository_impl.dart';
import 'domain/repositories/{{feature_name.snakeCase()}}_repository.dart';
import 'domain/usecase/get_{{feature_name.snakeCase()}}_usecase.dart';

{{#use_bloc}}
import 'presentation/bloc/{{feature_name.snakeCase()}}_bloc.dart';
{{/use_bloc}}

class {{feature_name.pascalCase()}}Injector {
  /// Initialize {{feature_name.pascalCase()}} feature dependencies
  static Future<void> init() async {
    // Repository
    sl.registerLazySingleton<{{feature_name.pascalCase()}}Repository>(
      () => {{feature_name.pascalCase()}}RepositoryImpl(
        remoteSource: sl(),
        connectionChecker: sl()
      ),
    );

    // Usecases
    sl.registerLazySingleton(() => {{feature_name.pascalCase()}}Usecase({{feature_name.snakeCase()}}Repository: sl()));

    {{#use_bloc}}
    // Bloc
    sl.registerFactory(() => {{feature_name.pascalCase()}}Bloc(
      {{feature_name.pascalCase()}}Usecase: sl(),
    ));
    {{/use_bloc}}
  }
}
