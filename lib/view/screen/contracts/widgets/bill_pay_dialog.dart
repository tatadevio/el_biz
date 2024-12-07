import 'dart:io';

import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_border_button.dart';
import '../../../base/custom_button.dart';

class BillPayDialog extends StatefulWidget {
  const BillPayDialog({super.key});

  @override
  State<BillPayDialog> createState() => _BillPayDialogState();
}

class _BillPayDialogState extends State<BillPayDialog> {
  String? selectedFilePath;
  String? fileSize;

  Future<void> _pickPDF() async {
    try {
      // Pick a single file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'], // Restrict to PDF files
      );

      if (result != null) {
        // Get the file path
        String? path = result.files.single.path;

        if (path != null) {
          final file = File(path);
          final fileBytes = await file.length(); // Get file size in bytes
          setState(() {
            selectedFilePath = path;
            fileSize = _formatFileSize(fileBytes);
          });
        }
      } else {
        // User canceled the picker
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No file selected.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: $e')),
      );
    }
  }

  /// Format file size in KB or MB
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes bytes';
    } else if (bytes < 1048576) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / 1048576).toStringAsFixed(2)} MB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(Images.done),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Пожалуйста прикрепите  квитанцию оплаты',
          style: h16.copyWith(color: ColorResources.titleColor),
        ),
        if (selectedFilePath != null) ...[
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              _pickPDF();
            },
            leading: Icon(Icons.file_copy_sharp),
            title: Text(path.basename(selectedFilePath!)),
            subtitle: Text(fileSize.toString()),
          ),
        ],
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: CustomBorderButton(
                height: 44,
                width: Get.width,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                border: Border.all(width: 1, color: ColorResources.blue),
                borderRadius: BorderRadius.circular(12),
                boxShaow: const [ColorResources.shadow1],
                child: Text(
                  'Отмена',
                  style: textMd.copyWith(color: ColorResources.blue),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    if (selectedFilePath != null) {
                      Get.back();
                    } else {
                      _pickPDF();
                    }
                  },
                  title: selectedFilePath == null ? 'Загрузить' : 'Отправить'),
            ),
          ],
        ),
      ],
    );
  }
}
