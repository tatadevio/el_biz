import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProductImportPage extends StatefulWidget {
  const ProductImportPage({super.key});

  @override
  _ProductImportPageState createState() => _ProductImportPageState();
}

class _ProductImportPageState extends State<ProductImportPage> {
  String? importId;
  int progress = 0;
  String status = 'idle'; // idle, uploading, processing, completed, failed
  Map<String, int> stats = {'successful': 0, 'failed': 0};
  Timer? _pollingTimer;
  bool isLoading = false;
  String apiBase = 'https://your-api.example.com/api/product-imports';

  @override
  void dispose() {
    _cancelPolling();
    super.dispose();
  }

  void _cancelPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> pickAndUploadFile() async {
    // 1. Pick file
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null || result.files.isEmpty) return;

    final filePath = result.files.single.path;
    if (filePath == null) return;

    final file = File(filePath);

    // Example additional fields: company_id, category_id
    final String companyId = '12';
    final String categoryId = '34';

    try {
      setState(() {
        isLoading = true;
        status = 'uploading';
        progress = 0;
        importId = null;
        stats = {'successful': 0, 'failed': 0};
      });

      // 2. Upload (multipart/form-data)
      final uri = Uri.parse('$apiBase/upload');
      final request = http.MultipartRequest('POST', uri)
        ..fields['company_id'] = companyId
        ..fields['category_id'] = categoryId
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamed = await request.send();
      final resp = await http.Response.fromStream(streamed);

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final body = json.decode(resp.body);
        // adjust path depending on your API response
        final id = body['data']?['id']?.toString();
        if (id != null) {
          setState(() {
            importId = id;
            status = 'processing';
          });
          startPolling(id);
        } else {
          throw Exception('Upload succeeded but no import id returned.');
        }
      } else {
        throw Exception(
            'Upload failed: ${resp.statusCode} ${resp.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        status = 'failed';
      });
      _showSnack('Upload error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void startPolling(String id) {
    _cancelPolling(); // ensure no duplicate timers

    // Immediately do one status fetch (optional)
    _fetchStatus(id);

    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchStatus(id);
    });
  }

  Future<void> _fetchStatus(String id) async {
    try {
      final uri = Uri.parse('$apiBase/status/$id');
      final resp = await http.get(uri);

      if (resp.statusCode == 200) {
        final body = json.decode(resp.body);
        // adjust fields per your API
        final data = body['data'] ?? {};

        // Example structure assumption:
        // data['progress']['percentage'], data['status'], data['progress']['successful_rows'], data['progress']['failed_rows']
        final int percentage = (data['progress']?['percentage'] ?? 0).toInt();
        final String newStatus = (data['status'] ?? 'processing').toString();
        final int successCount =
            (data['progress']?['successful_rows'] ?? 0).toInt();
        final int failedCount = (data['progress']?['failed_rows'] ?? 0).toInt();

        setState(() {
          progress = percentage.clamp(0, 100);
          status = newStatus;
          stats = {'successful': successCount, 'failed': failedCount};
        });

        if (newStatus == 'completed' || newStatus == 'failed') {
          _cancelPolling();
          _handleCompletion(data);
        }
      } else {
        // handle transient errors: maybe ignore and wait for next poll
        // but if repeated failures happen, consider stopping the poll
        debugPrint('Status fetch failed: ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching status: $e');
      // optionally implement retry/backoff logic
    }
  }

  void _handleCompletion(dynamic data) {
    final success = stats['successful'] ?? 0;
    // final failed = stats['failed'] ?? 0;

    if (status == 'completed') {
      _showSnack('Import complete — $success products imported.');
    } else {
      _showSnack('Import ended with status: $status');
    }

    // If there are error rows, show button in UI (we already track stats)
    // You can also open a modal showing details from `data` if API returns them
  }

  Future<void> downloadErrorReport() async {
    if (importId == null) return;
    final url = '$apiBase/errors/$importId/download';
    final uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      _showSnack('Cannot open download URL.');
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Import')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Pick & Upload File'),
              onPressed: isLoading ? null : pickAndUploadFile,
            ),
            const SizedBox(height: 20),
            if (status == 'uploading' || status == 'processing') ...[
              Text('Importing Products...'),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: progress / 100),
              const SizedBox(height: 8),
              Text('$progress% Completed'),
            ],
            if (status == 'completed') ...[
              const SizedBox(height: 12),
              const Icon(Icons.check_circle, color: Colors.green, size: 48),
              const SizedBox(height: 8),
              Text('Import Complete! ✅'),
              Text('Successfully added: ${stats['successful']}'),
              if ((stats['failed'] ?? 0) > 0) ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text('Download Error Report'),
                  onPressed: downloadErrorReport,
                ),
                Text('Failed / skipped: ${stats['failed']}'),
              ],
            ],
            if (status == 'failed') ...[
              const SizedBox(height: 12),
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text('Import failed. Check server logs or try again.'),
              if (importId != null)
                ElevatedButton(
                  onPressed: downloadErrorReport,
                  child: const Text('Download Error Report (if available)'),
                ),
            ],
            const Spacer(),
            if (importId != null) Text('Import ID: $importId'),
          ],
        ),
      ),
    );
  }
}
