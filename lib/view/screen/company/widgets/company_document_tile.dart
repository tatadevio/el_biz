import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../bloc/company/company_bloc.dart';
import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../data/model/response/company/company_document_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_dialog.dart';
import '../../../base/custom_image.dart';

class CompanyDocumentTile extends StatelessWidget {
  final bool isEdit;
  final CompanyState state;

  const CompanyDocumentTile(
      {super.key, required this.isEdit, required this.state});

  @override
  Widget build(BuildContext context) {
    // Determine if a local certificate document is selected
    final hasLocalDoc = state.addCompanyModel.certificateDocument != null;
    final localDoc = state.addCompanyModel.certificateDocument;

    return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
      builder: (context, detailState) {
        DocumentItem? certificate;
        if (detailState.companyDocuments != null &&
            detailState.companyDocuments!.isNotEmpty) {
          certificate = detailState.companyDocuments!.firstWhere(
            (doc) => doc.documentType == 'certificate',
            // orElse: () => null,
          );
        }

        return ListTile(
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
                              SelectCompanyDocument(
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
                              SelectCompanyDocument(
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
                              SelectCompanyDocument(imageSource: null),
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
          leading: _buildLeading(certificate, hasLocalDoc, localDoc),
          title: _buildTitle(certificate, hasLocalDoc),
          subtitle: _buildSubtitle(certificate, hasLocalDoc, localDoc),
        );
      },
    );
  }

  Widget _buildLeading(
      DocumentItem? certificate, bool hasLocal, dynamic localDoc) {
    if (isEdit && !hasLocal) {
      if (certificate != null) {
        return Container(
          height: 40,
          width: 40,
          child: certificate.name!.endsWith('.pdf')
              ? Icon(Icons.picture_as_pdf)
              : CustomImage(
                  image: certificate.filePath ?? '',
                  height: 40,
                  width: 40,
                  radius: 40,
                ),
        );
      } else {
        return SizedBox(width: 40, height: 40);
      }
    }

    // Show local or placeholder
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorResources.backgroundColor,
        border: Border.all(
          width: hasLocal ? 1 : 6,
          color: ColorResources.lightBlue,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: hasLocal
          ? (localDoc.path.endsWith('.pdf')
              ? Icon(Icons.picture_as_pdf)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.file(
                    File(localDoc.path),
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ))
          : SvgPicture.asset(Images.svgDownload),
    );
  }

  Widget _buildTitle(DocumentItem? certificate, bool hasLocal) {
    String text;
    if (hasLocal) {
      text = state.addCompanyModel.certificateDocument!.name;
    } else if (isEdit && certificate != null) {
      text = certificate.name!;
    } else {
      text = 'upload_document'.tr;
    }
    return Text(text, style: body14.copyWith(color: ColorResources.gray));
  }

  Widget _buildSubtitle(
      DocumentItem? certificate, bool hasLocal, dynamic localDoc) {
    String text;
    if (hasLocal) {
      text = getFileSize(File(localDoc.path));
    } else {
      if (certificate == null || certificate.size == "") {
        text = "";
      } else {
        text = getSizeFromBytes(certificate.size ?? '');
      }
    }

   
    return Text(text, style: textXS.copyWith(color: ColorResources.gray));
  }

  String getFileSize(File file) {
    int bytes = file.lengthSync();
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }

  String getSizeFromBytes(String byteSize) {
    int bytes = int.parse(byteSize);
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
}
