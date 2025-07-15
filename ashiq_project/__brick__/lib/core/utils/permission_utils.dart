import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  // Camera permission
  final cameraStatus = await Permission.camera.request();

  // Storage/photos permission
  if (Platform.isAndroid) {
    // Android 13+ uses READ_MEDIA_IMAGES
    final photosStatus = await Permission.photos.request();
    final storageStatus = await Permission.storage.request();

    if (photosStatus.isDenied || storageStatus.isDenied || cameraStatus.isDenied) {
      print('One or more permissions were denied');
    }
  } else {
    final photosStatus = await Permission.photos.request();
    if (photosStatus.isDenied || cameraStatus.isDenied) {
      print('Permission denied');
    }
  }
}
