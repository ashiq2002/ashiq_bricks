part of 'init_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// Internet Checker
  sl.registerLazySingleton(() => InternetConnection());

  /// rejister Connection Checker
  sl.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(sl()),
  );

  /// Api Client (Singleton with Toast access etc.)
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: ApiEndpoint.baseUrl,
      onLogout: () {
        // Clean up on logout
        HiveService.to.clearAllData();
        AppRoute.router.goNamed(RoutePath.loginPage);
      },
    ),
  );
 
   ///don't remove this comment 
  //[FEATURE_INJECTORS]
}
