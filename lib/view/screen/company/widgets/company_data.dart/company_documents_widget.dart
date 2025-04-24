import 'dart:io';

import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../../helper/calculation_helper.dart';
import 'package:http/http.dart' as http;

class CompanyDocumentsWidget extends StatelessWidget {
  const CompanyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyState) {
      if (companyState.isLoading || companyState.companyDocuments == null) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (companyState.companyDocuments!.isEmpty) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: Text('No Document found'),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: companyState.companyDocuments!.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final document = companyState.companyDocuments![index];
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  document.type?.contains('pdf') ?? false
                      ? SvgPicture.asset(Images.svgFile)
                      : CustomImage(
                          image: '', height: 32, width: 32, radius: 0),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.name ?? '',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        Row(
                          children: [
                            Text(
                              formatBytes(int.parse(document.size ?? '0')),
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              formatDateInRu(document.createdAt.toString()),
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        // openFilex(document.url ?? '');
                        downloadFileWithHttp(
                            document.filePath ?? '', document.name ?? '');
                      },
                      child: SvgPicture.asset(Images.svgDownload)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.dialog(CustomDialog(
                            widget: AlertDialog(
                                backgroundColor: Colors.white,
                                content: deleteDocument(
                                    context, document.id.toString()))));
                      },
                      child: Text(
                        'delete_document'.tr,
                        style: button16.copyWith(color: ColorResources.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Future<void> downloadFileWithHttp(String url, String fileName) async {
    try {
      // Ask permission on Android
      if (Platform.isAndroid) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          print("Storage permission denied");
          return;
        }
      }

      // Get the directory to save the file
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      // Make the HTTP request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        print("Download completed: $filePath");

        // Optional: open the file
        await OpenFilex.open(file.path);
      } else {
        print("Failed to download: ${response.statusCode}");
      }
    } catch (e) {
      print("Download error: $e");
    }
  }

  Widget deleteDocument(BuildContext context, String documentId) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
                color: ColorResources.lightBlue, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: SvgPicture.asset(Images.svgHelpCircle),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${'delete_document'.tr}?',
            style: h16.copyWith(color: ColorResources.titleColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    Get.back();
                  },
                  title: 'cancel'.tr,
                  color: ColorResources.lgColor,
                  textColor: ColorResources.gray,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: CustomButton(
                  width: Get.width,
                  height: 44,
                  onTap: () {
                    Get.back();
                    context
                        .read<CompanyDetailBloc>()
                        .add(DeleteCompanyDocument(documentId));
                  },
                  title: 'delete'.tr,
                  color: ColorResources.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
