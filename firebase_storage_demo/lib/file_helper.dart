import 'package:file_picker/file_picker.dart';

class FileHelper {
  static Future<FilePickerResult?> pickFile(
    FileType type, {
    bool isAllowMultiple = false,
    List<String>? allowedExtension,
  }) async {
    final FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: isAllowMultiple,
      allowedExtensions: allowedExtension,
    );
    return file;
  }
}
