import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';

enum FileType {
  pdf,
  video,
  image,
  unknown,
}

FileType getFileTypeFromUrl(String? url) {

  if(url == null) return FileType.unknown;

  final extension = p.extension(Uri.parse(url).path).toLowerCase();

  const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
  const videoExtensions = ['.mp4', '.mkv', '.mov', '.avi', '.flv', '.wmv'];
  const pdfExtensions = ['.pdf'];

  debugPrint("Extension: $extension");

  if (pdfExtensions.contains(extension)) {
    return FileType.pdf;
  } else if (imageExtensions.contains(extension)) {
    return FileType.image;
  } else if (videoExtensions.contains(extension)) {
    return FileType.video;
  } else {
    return FileType.unknown;
  }
}
