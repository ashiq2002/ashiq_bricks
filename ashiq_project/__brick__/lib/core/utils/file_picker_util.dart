import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerUtil {

  // Function to pick a file with error handling
  static Future<PlatformFile?> pickFile({List<String>? allowedExtensions, FileType type = FileType.any}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: type,
          allowedExtensions: allowedExtensions
      );

      if (result != null) {
        return result.files.first;
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the file picking process
      print('Error picking file: $e');
      return null;
    }
  }

  // Method to pick image from gallery or camera and convert to PlatformFile
  static Future<XFile?> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      return pickedFile;

    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
