import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../../../../helper/download_excel.dart';

Future<String> downloadExcelFile(String url, String filename) async {
  final res = await http.get(Uri.parse(url));
  if (res.statusCode != 200) {
    throw Exception("Failed to download file");
  }

  final Uint8List bytes = res.bodyBytes;

  // Save using native Android/iOS storage APIs
  final savedPath =
      await ExcelDownloader.saveToPublicDownloads(bytes, filename);

  return savedPath;
}

Future<FilePickerResult?> pickExcelOrCsvFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls', 'csv'],
    withData: true, // also gives you Uint8List bytes
  );

  return result; // null if user cancels
}
