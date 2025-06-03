import 'dart:io';

class Global {
  static Future<void> init() async {
    // Initialize any global settings or configurations here
    // For example, setting up HTTP overrides for self-signed certificates
    HttpOverrides.global = MyHttpOverrides();
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