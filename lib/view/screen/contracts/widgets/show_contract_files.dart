import 'dart:io';

import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';

import '../../../../bloc/agreement/agreement_bloc.dart';
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
                        downloadFileWithScopedPermission(
                            'https://hrsgmobileapp.s3.eu-north-1.amazonaws.com/Mobile/Clients/1/Claim/125979/IMG-20250701-WA0011.jpg',
                            context);
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
      // Check if it's an image file
      bool isImage = _isImageFile(url);

      // Ask for appropriate permissions
      if (Platform.isAndroid) {
        PermissionStatus status;

        if (isImage) {
          // For images, request media permissions
          status = await Permission.photos.request();
          if (!status.isGranted) {
            status = await Permission.storage.request();
          }
        } else {
          // For other files, request storage permission
          status = await Permission.storage.request();
        }

        // If still not granted, try manageExternalStorage for newer Android versions
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }

        if (!status.isGranted) {
          showShortToast('storage_permission_required'.tr);
          await openAppSettings();
          return;
        }
      }

      // Show loading indicator
      showShortToast('downloading_file'.tr);

      // Make the HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String fileName = url.split('/').last;

        if (isImage) {
          // Save image to device media storage
          await _saveImageToDevice(response.bodyBytes, fileName);
        } else {
          // Save other files to downloads
          await _saveFileToDownloads(response.bodyBytes, fileName);
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

  Future<void> _saveImageToDevice(List<int> imageBytes, String fileName) async {
    try {
      Directory dir;

      if (Platform.isAndroid) {
        // For Android, create app-specific folder in external storage
        dir = await _getOrCreateAppFolderInExternalStorage();
      } else {
        // For iOS, save to app documents directory
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Write the image file
      await file.writeAsBytes(imageBytes);

      debugPrint("Image saved to: $filePath");

      // For Android, trigger media scanner to make image visible in gallery
      if (Platform.isAndroid) {
        await _triggerMediaScanner(filePath);
      }

      // Show success message with location info
      if (Platform.isAndroid) {
        showShortToast('${'file_downloaded_successfully'.tr} (Gallery)');
      } else {
        showShortToast('file_downloaded_successfully'.tr);
      }
    } catch (e) {
      debugPrint("Error saving image: $e");
      // Fallback to downloads if image save fails
      await _saveFileToDownloads(imageBytes, fileName);
    }
  }

  Future<Directory> _getOrCreateAppFolderInExternalStorage() async {
    try {
      // Try to go directly to external storage first
      Directory externalDir = Directory('/storage/emulated/0');

      // Create app-specific folder name
      String appFolderName = 'ProjectName';

      // Create app folder in external storage
      Directory appFolder = Directory('${externalDir.path}/$appFolderName');

      if (!await appFolder.exists()) {
        // Create the app folder
        await appFolder.create(recursive: true);
        debugPrint("Created app folder: ${appFolder.path}");
      }

      return appFolder;
    } catch (e) {
      debugPrint("Error creating app folder in external storage: $e");
      // Fallback to old method with folder checking
      return await _getOrCreateAppFolderWithFallback();
    }
  }

  Future<Directory> _getOrCreateAppFolderWithFallback() async {
    try {
      // Try DCIM first
      Directory targetDir = Directory('/storage/emulated/0/DCIM');
      if (await targetDir.exists()) {
        return await _createAppFolderInDirectory(targetDir);
      }

      // Try Pictures if DCIM doesn't exist
      targetDir = Directory('/storage/emulated/0/Pictures');
      if (await targetDir.exists()) {
        return await _createAppFolderInDirectory(targetDir);
      }

      // Try Downloads if Pictures doesn't exist
      targetDir = Directory('/storage/emulated/0/Download');
      if (await targetDir.exists()) {
        return await _createAppFolderInDirectory(targetDir);
      }

      // Final fallback to app documents directory
      debugPrint("All external directories failed, using app documents");
      return await getApplicationDocumentsDirectory();
    } catch (e) {
      debugPrint("Error in fallback method: $e");
      return await getApplicationDocumentsDirectory();
    }
  }

  Future<Directory> _createAppFolderInDirectory(Directory parentDir) async {
    try {
      String appFolderName = 'ProjectName';
      Directory appFolder = Directory('${parentDir.path}/$appFolderName');

      if (!await appFolder.exists()) {
        await appFolder.create(recursive: true);
        debugPrint("Created app folder: ${appFolder.path}");
      }

      return appFolder;
    } catch (e) {
      debugPrint("Error creating app folder in ${parentDir.path}: $e");
      rethrow;
    }
  }

  Future<void> _triggerMediaScanner(String filePath) async {
    try {
      // Use native Android method channel to trigger media scanner
      const platform = MethodChannel('media_scanner');
      final result =
          await platform.invokeMethod('scanFile', {'path': filePath});
      debugPrint("Media scanner result: $result");
    } catch (e) {
      debugPrint("Media scanner error: $e");
    }
  }

  Future<void> _saveFileToDownloads(
      List<int> fileBytes, String fileName) async {
    try {
      Directory dir;

      if (Platform.isAndroid) {
        // For Android, save to Downloads folder
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          // Fallback to app documents directory
          dir = await getApplicationDocumentsDirectory();
        }
      } else {
        // For iOS and other platforms
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      // Write the file
      await file.writeAsBytes(fileBytes);

      debugPrint("File saved to: $filePath");
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
