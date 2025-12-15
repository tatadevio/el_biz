import 'dart:typed_data';
import 'package:flutter/services.dart';

class ExcelDownloader {
  static const MethodChannel _channel = MethodChannel('excel_downloader');

  static Future<String> saveToPublicDownloads(
      Uint8List bytes, String filename) async {
    final res = await _channel.invokeMethod<String>('saveExcel', {
      'bytes': bytes,
      'filename': filename,
    });
    return res!;
  }
}
