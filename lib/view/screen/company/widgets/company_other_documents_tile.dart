import 'dart:io';

import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../bloc/company/company_bloc.dart';
import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_dialog.dart';

class CompanyOtherDocumentsTile extends StatelessWidget {
  final bool isEdit;
  final CompanyState state;

  const CompanyOtherDocumentsTile({
    super.key,
    required this.isEdit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
      builder: (context, detailState) {
        final remoteOtherDocs = detailState.companyDocuments
                ?.where((doc) => doc.documentType == 'other')
                .toList() ??
            [];

        final localOtherDocs = state.addCompanyModel.otherDocuments ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((remoteOtherDocs.isNotEmpty || localOtherDocs.isNotEmpty)) ...[
              const SizedBox(height: 10),
              Wrap(
                runSpacing: 4,
                children: [
                  // Remote documents
                  if (isEdit)
                    for (var doc in remoteOtherDocs)
                      _buildOtherDocumentTile(
                        title: doc.name ?? '',
                        path: doc.filePath,
                        isRemote: true,
                        remoteSize: doc.size ?? '',
                        onDelete: () {
                          Get.dialog(CustomDialog(
                              widget: AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: deleteDocument(
                                      context, doc.id.toString()))));
                          // Uncomment if needed:
                          // context.read<CompanyDetailBloc>().add(RemoveRemoteOtherDocument(doc.id!));
                        },
                      ),

                  // Local documents
                  for (int i = 0; i < localOtherDocs.length; i++)
                    _buildOtherDocumentTile(
                      title: localOtherDocs[i].name,
                      path: localOtherDocs[i].path,
                      isRemote: false,
                      onDelete: () {
                        context
                            .read<CompanyBloc>()
                            .add(RemoveCompanyOtherDocument(i));
                      },
                    ),
                ],
              ),
              const SizedBox(height: 10),
            ],

            // Upload document tile (always visible)
            ListTile(
              onTap: () {
                Get.dialog(
                  CustomDialog(
                    widget: SimpleDialog(
                      backgroundColor: Colors.white,
                      title: Row(
                        children: [
                          Expanded(child: Text('select_image'.tr)),
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      children: [
                        ListTile(
                          onTap: () {
                            Get.back();
                            context.read<CompanyBloc>().add(
                                  SelectCompanyOtherDocuments(
                                      imageSource: ImageSource.camera),
                                );
                          },
                          leading: const Icon(Icons.camera),
                          title: Text('camera'.tr),
                        ),
                        ListTile(
                          onTap: () {
                            Get.back();
                            context.read<CompanyBloc>().add(
                                  SelectCompanyOtherDocuments(
                                      imageSource: ImageSource.gallery),
                                );
                          },
                          leading: const Icon(Icons.image),
                          title: Text('gallery'.tr),
                        ),
                        ListTile(
                          onTap: () {
                            Get.back();
                            context.read<CompanyBloc>().add(
                                  SelectCompanyOtherDocuments(
                                      imageSource: null),
                                );
                          },
                          leading: const Icon(Icons.picture_as_pdf),
                          title: Text('pdf'.tr),
                        ),
                      ],
                    ),
                  ),
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorResources.backgroundColor,
                  border: Border.all(width: 6, color: ColorResources.lightBlue),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(Images.svgDownload),
              ),
              title: Text(
                'upload_document'.tr,
                style: body14.copyWith(color: ColorResources.gray),
              ),
              subtitle: Text(
                'SVG, PNG, JPG',
                style: textXS.copyWith(color: ColorResources.gray),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOtherDocumentTile({
    required String title,
    required String? path,
    required bool isRemote,
    required VoidCallback onDelete,
    String remoteSize = '',
  }) {
    final isPdf = path?.toLowerCase().endsWith('.pdf') ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 40,
          width: 40,
          child: isPdf
              ? const Icon(Icons.picture_as_pdf)
              : isRemote
                  ? CustomImage(
                      image: path ?? '', height: 40, width: 40, radius: 40)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.file(
                        File(path!),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
        title: Text(
          title,
          style: textStyle14Inter.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: !isPdf && !isRemote && path != null
            ? Text(
                _getFileSize(File(path)),
                style: textXS.copyWith(color: ColorResources.gray),
              )
            : remoteSize == ''
                ? null
                : Text(
                    _getSizeFromBytes(remoteSize),
                    style: textXS.copyWith(color: ColorResources.gray),
                  ),
        trailing: GestureDetector(
          onTap: onDelete,
          child: const Icon(Icons.delete, color: Colors.red, size: 20),
        ),
      ),
    );
  }

  String _getFileSize(File file) {
    try {
      final bytes = file.lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } catch (e) {
      return '';
    }
  }

  String _getSizeFromBytes(String byteSize) {
    int bytes = int.parse(byteSize);
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
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
