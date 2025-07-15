import 'package:get/get.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../services/hive_service.dart';
import 'init_dependencies.dart';

Future<void> injector() async {

  ///------------ Services ------------------>>>
  await Get.putAsync<HiveService>(()=> HiveService().init());
  await Get.putAsync(() => LocalizationService().init());


  ///------------ Controller ------------------>>>
  Get.lazyPut(() => AuthController(authUseCase: serviceLocator()), fenix: true);

}