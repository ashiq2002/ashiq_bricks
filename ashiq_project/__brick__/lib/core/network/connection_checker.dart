import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

import 'package:logger/logger.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImpl(this.internetConnection);

  // @override
  // Future<bool> get isConnected async =>
  //     await internetConnection.hasInternetAccess;

  @override
  Future<bool> get isConnected async => await isInternetAvailable();

  // Future<bool> isInternetAvailable() async {
  //   try {
  //     final socket = await Socket.connect('google.com', 80, timeout: const Duration(seconds: 5));
  //     socket.destroy();
  //     return true;
  //   } catch (_) {
  //     return false;
  //   }
  // }

  Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false; // No network connection at all
    }


    // Try a simple lookup
    try {
      final result = await InternetAddress.lookup('google.com');

      // Logger().d("==================Connectivity Status=====================");
      // Logger().d(result);

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false; // No internet access
    }
  }
}
