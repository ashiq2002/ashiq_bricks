import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'core/di/injector.dart';
import 'core/utils/permission_utils.dart';

class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize any global settings or configurations here

    /// Important: init GetIt first, then inject with GetX
    await initDependencies();

    ///request permission
    await requestPermissions();

    // For example, setting up HTTP overrides for self-signed certificates
    HttpOverrides.global = MyHttpOverrides();

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
    // Clean up resources if needed
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