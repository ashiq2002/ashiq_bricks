// TODO: Setup dependency injection here
Future<Map<String, Map<String, String>>> injector() async {
  // var apiclient=getIt<ApiClient>();
  // var localDb=getIt<LocalDataGet>();
  // print("calll get x");
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: BASE_URL));

  // Repositor

  ///------------ Controller ------------------>>>

  Get.lazyPut(() => MainController(mainUseCase: serviceLocator()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();

  return _languages;
}