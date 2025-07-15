part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  // Internet Checker
  serviceLocator.registerLazySingleton(() => InternetConnection());

  /// Core
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  /// Api Client (Singleton with Toast access etc.)
  serviceLocator.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: ApiEndpoint.baseUrl,
      onLogout: () {
        // Clean up on logout
        HiveService.to.clearAllData();
        AppRoute.router.goNamed(RoutePath.loginPage);
      },
    ),
  );
}

void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteSourceImpl(apiClient: serviceLocator()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        connectionChecker: serviceLocator(),
        remoteSource: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthUseCase(authRepository: serviceLocator()),
    );
}
