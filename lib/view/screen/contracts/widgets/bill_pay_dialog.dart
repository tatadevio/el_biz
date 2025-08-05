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

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        final fileBytes = await file.length();
        setState(() {
          xFile = image;
          fileSize = _formatFileSize(fileBytes);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: $e')),
      );
    }
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorResources.blue.withOpacity(0.1),
                    // borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: ColorResources.blue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: textMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorResources.titleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractsBloc, ContractsState>(
      builder: (context, state) {
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
                  child: state.isAddingPayment
                      ? CustomButtonLoader(width: Get.width, height: 44)
                      : CustomButton(
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
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Handle bar
                                        Container(
                                          width: 40,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        // Title
                                        Text(
                                          'select_file_type'.tr,
                                          style: h16.copyWith(
                                            color: ColorResources.titleColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: const Icon(Icons.camera_alt),
                                          title: Text('camera'.tr),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            _pickImage(ImageSource.camera);
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading:
                                              const Icon(Icons.photo_library),
                                          title: Text('gallery'.tr),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            _pickImage(ImageSource.gallery);
                                          },
                                        ),
                                        const SizedBox(height: 12),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading:
                                              const Icon(Icons.picture_as_pdf),
                                          title: Text('pdf'.tr),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            _pickPDF();
                                          },
                                        ),

                                        const SizedBox(height: 20),

                                        // Cancel button
                                        CustomButton(
                                          width: Get.width,
                                          title: 'cancel'.tr,
                                          height: 44,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          title: xFile == null ? 'upload'.tr : 'send'.tr),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
