import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../../bloc/contracts/contracts_bloc.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_border_button.dart';
import '../../../base/custom_button.dart';

class BillPayDialog extends StatefulWidget {
  final String contractId;
  const BillPayDialog({super.key, required this.contractId});

  @override
  State<BillPayDialog> createState() => _BillPayDialogState();
}

class _BillPayDialogState extends State<BillPayDialog> {
  // String? selectedFilePath;
  String? fileSize;
  XFile? xFile;

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        final platformFile = result.files.single;
        final filePath = platformFile.path;

        if (filePath != null) {
          xFile = XFile(filePath);
          final file = File(filePath);
          final fileBytes = await file.length();
          setState(() {
            xFile = xFile;
            fileSize = _formatFileSize(fileBytes);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected.')),
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
          'please_attach_your_payment_receipt'.tr,
          style: h16.copyWith(color: ColorResources.titleColor),
        ),
        if (xFile != null) ...[
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              _pickPDF();
            },
            leading: const Icon(Icons.file_copy_sharp),
            title: Text(path.basename(xFile!.path)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                border: Border.all(width: 1, color: ColorResources.blue),
                borderRadius: BorderRadius.circular(12),
                boxShaow: const [ColorResources.shadow1],
                child: Text(
                  'cancel'.tr,
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
                    if (xFile != null) {
                      // Get.back();

                      context.read<ContractsBloc>().add(AddPaymentData(
                            contractId: widget.contractId,
                            note: '',
                            image: xFile!,
                          ));
                    } else {
                      _pickPDF();
                    }
                  },
                  title: xFile == null ? 'upload'.tr : 'send'.tr),
            ),
          ],
        ),
      ],
    );
  }
}
