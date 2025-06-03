part of 'init_dependencies.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // _initMain();

  serviceLocator.registerFactory(() => InternetConnection());

  /// core
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );


  serviceLocator.registerFactory<HiveService>(
    () => HiveService.to.init(),
  );

  ///location
  // serviceLocator.registerFactory<LocationConfig>(
  //   () => LocationConfig(),
  // );

  ///Api client
  serviceLocator.registerFactory<ApiClient>(
    () => ApiClient(),
  );

}

/*void _initMain() {
  serviceLocator
    ..registerFactory<MainRemoteSource>(
      () => MainRemoteSourceImpl(
        apiMethod: serviceLocator(),
      ),
    )

    /// Repository
    ..registerFactory<MainRepository>(
      () => MainRepositoryImpl(
          connectionChecker: serviceLocator(), remoteSource: serviceLocator()),
    )

    /// Usecases
    ..registerFactory(
      () => MainUseCase(
        mainRepository: serviceLocator(),
      ),
    );
}*/

