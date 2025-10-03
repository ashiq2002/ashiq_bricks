import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'core/di/init_dependencies.dart';
import 'core/utils/permission_utils.dart';
import 'package:easy_localization/easy_localization.dart';


// Initialize any global settings or configurations here
class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    ///initialize easy localization
    await EasyLocalization.ensureInitialized();

    /// Important: init GetIt first, then inject with GetX
    await initDependencies();

    ///request permission
    await requestPermissions();

    /// For example, setting up HTTP overrides for self-signed certificates
    HttpOverrides.global = MyHttpOverrides();
    
    ///flutter error handling 
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(
            details.exception, details.stack ?? StackTrace.empty);
      }
    };
  }
  static void dispose() {
    /// Clean up resources if needed
    HttpOverrides.global = null; // Reset to default overrides
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}