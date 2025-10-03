import 'package:get_it/get_it.dart';
import '../../{{feature_name.snakeCase()}}_repository_impl.dart';
import '../../{{feature_name.snakeCase()}}_repository.dart';
import '../usecase/get_{{feature_name.snakeCase()}}_usecase.dart';
{{#use_bloc}}
import '../bloc/{{feature_name.snakeCase()}}_bloc.dart';
{{/use_bloc}}

class {{feature_name.pascalCase()}}Injector {
  /// Initialize {{feature_name.pascalCase()}} feature dependencies
  static Future<void> init() async {
    final sl = GetIt.instance;

    // Repository
    sl.registerLazySingleton<{{feature_name.pascalCase()}}Repository>(
      () => {{feature_name.pascalCase()}}RepositoryImpl(),
    );

    // Usecases
    sl.registerLazySingleton(() => Get{{feature_name.pascalCase()}}Usecase(sl()));

    {{#use_bloc}}
    // Bloc
    sl.registerFactory(() => {{feature_name.pascalCase()}}Bloc(
      get{{feature_name.pascalCase()}}Usecase: sl(),
    ));
    {{/use_bloc}}
  }
}
