import 'package:get_it/get_it.dart';

// [FEATURE_IMPORTS]

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

  // [FEATURE_INJECTORS]
}
