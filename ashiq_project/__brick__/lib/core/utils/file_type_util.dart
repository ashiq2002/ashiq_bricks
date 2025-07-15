import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';

enum FileType {
  pdf,
  video,
  image,
  document,
  excel,
  powerpoint,
  text,
  csv,
  unknown,
}

FileType getFileTypeFromUrl(String? url) {
  if (url == null) return FileType.unknown;

  final extension = p.extension(Uri.parse(url).path).toLowerCase();

  const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
  const videoExtensions = ['.mp4', '.mkv', '.mov', '.avi', '.flv', '.wmv'];
  const pdfExtensions = ['.pdf'];
  const documentExtensions = ['.doc', '.docx'];
  const excelExtensions = ['.xls', '.xlsx'];
  const powerpointExtensions = ['.ppt', '.pptx'];
  const textExtensions = ['.txt'];
  const csvExtensions = ['.csv'];

  debugPrint("Extension: $extension");

  if (pdfExtensions.contains(extension)) {
    return FileType.pdf;
  } else if (imageExtensions.contains(extension)) {
    return FileType.image;
  } else if (videoExtensions.contains(extension)) {
    return FileType.video;
  } else if (documentExtensions.contains(extension)) {
    return FileType.document;
  } else if (excelExtensions.contains(extension)) {
    return FileType.excel;
  } else if (powerpointExtensions.contains(extension)) {
    return FileType.powerpoint;
  } else if (textExtensions.contains(extension)) {
    return FileType.text;
  } else if (csvExtensions.contains(extension)) {
    return FileType.csv;
  } else {
    return FileType.unknown;
  }
}
