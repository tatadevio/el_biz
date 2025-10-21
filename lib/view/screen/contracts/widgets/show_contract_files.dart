import 'dart:io';

import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../../bloc/company/company_bloc.dart';
// import '../../../../data/model/base/compnay_document_model.dart';

class ShowContractFiles extends StatelessWidget {
  const ShowContractFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: size.height * 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorResources.lgColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'documents'.tr,
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.back();
                        showShortToast('download_all_documents'.tr);
                        // downloadFileWithScopedPermission(
                        //     'https://hrsgmobileapp.s3.eu-north-1.amazonaws.com/Mobile/Clients/1/Claim/125979/IMG-20250701-WA0011.jpg',
                        //     context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Images.svgDownload,
                            color: ColorResources.blue,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'download_all'.tr,
                            style:
                                button16.copyWith(color: ColorResources.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Expanded(
                //     child: ListView.builder(
                //   // shrinkWrap: true,
                //   // physics: const NeverScrollableScrollPhysics(),
                //   itemCount: state..length,
                //   itemBuilder: (context, index) {
                //     return contractDocument(state.companyDocuments[index]);
                //   },
                // )),
                CustomButton(
                  width: Get.width,
                  height: 48,
                  onTap: () {
                    Get.back();
                  },
                  title: 'agreement_approval'.tr,
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> downloadFileWithScopedPermission(
      String url, BuildContext context) async {
    try {
      // Show loading indicator
      showShortToast('downloading_file'.tr);

      // Make the HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String fileName = url.split('/').last;

        // Check if it's an image file
        bool isImage = _isImageFile(url);

        if (isImage) {
          // Save image without requiring permissions
          await _saveImageToAppDirectory(response.bodyBytes, fileName);
        } else {
          // Save other files to app directory
          await _saveFileToAppDirectory(response.bodyBytes, fileName);
        }

        // Show success message
        showShortToast('file_downloaded_successfully'.tr);
      } else {
        showShortToast('download_failed'.tr);
        debugPrint("Download failed with status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Download error: $e");
      showShortToast('download_error'.tr);
    }
  }

  bool _isImageFile(String url) {
    String extension = url.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  Future<void> _saveImageToAppDirectory(
      List<int> imageBytes, String fileName) async {
    try {
      // Use app's external files directory (no permissions needed)
      Directory? externalDir = await getExternalStorageDirectory();
      Directory dir;

      if (externalDir != null) {
        // Create a Downloads folder in app's external directory
        dir = Directory('${externalDir.path}/Downloads');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
      } else {
        // Fallback to app documents directory
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Write the image file
      await file.writeAsBytes(imageBytes);

      debugPrint("Image saved to: $filePath");

      // Open the file after saving
      await OpenFilex.open(filePath);
    } catch (e) {
      debugPrint("Error saving image: $e");
      // Fallback to documents directory
      await _saveFileToAppDirectory(imageBytes, fileName);
    }
  }

  Future<void> _saveFileToAppDirectory(
      List<int> fileBytes, String fileName) async {
    try {
      // Use app's external files directory (no permissions needed)
      Directory? externalDir = await getExternalStorageDirectory();
      Directory dir;

      if (externalDir != null) {
        // Create a Downloads folder in app's external directory
        dir = Directory('${externalDir.path}/Downloads');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
      } else {
        // Fallback to app documents directory
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Write the file
      await file.writeAsBytes(fileBytes);

      debugPrint("File saved to: $filePath");

      // Open the file after saving
      await OpenFilex.open(filePath);
    } catch (e) {
      debugPrint("Error saving file: $e");
      rethrow;
    }
  }

  // Widget contractDocument(ComapnyDocumentModel document) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           document.documentType == 'image'
  //               ? CustomImage(
  //                   image: document.urlLink, height: 40, width: 40, radius: 0)
  //               : SvgPicture.asset(
  //                   Images.svgFile,
  //                   height: 40,
  //                   width: 40,
  //                 ),
  //           const SizedBox(
  //             width: 10,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   document.title,
  //                   style: h16.copyWith(color: ColorResources.darkGray),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       document.size,
  //                       style: body14.copyWith(color: ColorResources.gray),
  //                     ),
  //                     Text(
  //                       document.date,
  //                       style: body14.copyWith(color: ColorResources.gray),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SvgPicture.asset(
  //             Images.svgDownload,
  //             color: ColorResources.blue,
  //           ),
  //         ],
  //       ),
  //       const Divider(),
  //     ],
  //   );
  // }
}
