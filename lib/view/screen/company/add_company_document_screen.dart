import 'dart:io';

import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/company/widgets/custom_add_company_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../../base/custom_button.dart';
import 'widgets/company_document_tile.dart' show CompanyDocumentTile;
import 'widgets/company_other_documents_tile.dart';

class AddCompanyDocumentScreen extends StatelessWidget {
  final bool isEdit;
  const AddCompanyDocumentScreen({super.key, required this.isEdit});

  void _submitForm(BuildContext context) {
    final companyData = context.read<CompanyBloc>().state.addCompanyModel;

    final detailState = context.read<CompanyDetailBloc>().state;

    if (companyData.certificateDocument != null ||
        (isEdit &&
            (companyData.certificateDocument != null ||
                (detailState.companyDocuments != null &&
                    detailState.companyDocuments!.isNotEmpty)))) {
      if (isEdit) {
        final companyDetail =
            context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;
        context.read<CompanyBloc>().add(UpdateCompany(
            addCompanyModel: companyData,
            companyId: companyDetail.id.toString(),
            context: context));
        print(companyData.categories);
      } else {
        context.read<CompanyBloc>().add(AddNewCompany(companyData, context));
      }
      // context.read<CompanyBloc>().add(ClearAddCompanyModel());
    } else {
      showShortToast('add_certificate'.tr);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(title: ""),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'certificate_of_state_registration_of_a_legal_entity'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'upload_your_certificate_document'.tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CompanyDocumentTile(
                    isEdit: isEdit,
                    state: state, // your AddCompanyModel state
                  ),

                  // BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
                  //     builder: (context, detailState) {
                  //       if(isEdit) {

                  //       }
                  //           // Find the certificate document
                  //   DocumentItem? certificate = detailState.companyDocuments!
                  //       .firstWhere((document) =>
                  //           document.documentType == 'certificate');

                  //   // Get the list without the certificate
                  //   List<DocumentItem> otherDocuments = detailState
                  //       .companyDocuments!
                  //       .where((document) => document != certificate)
                  //       .toList();
                  //     return ListTile(
                  //       onTap: () {
                  //         Get.dialog(CustomDialog(
                  //             widget: SimpleDialog(
                  //           backgroundColor: Colors.white,
                  //           title: Row(
                  //             children: [
                  //               Expanded(child: Text('select_image'.tr)),
                  //               IconButton(
                  //                 onPressed: () {
                  //                   Get.back();
                  //                 },
                  //                 icon: const Icon(Icons.close),
                  //               ),
                  //             ],
                  //           ),
                  //           children: [
                  //             ListTile(
                  //               onTap: () {
                  //                 Get.back();
                  //                 context.read<CompanyBloc>().add(
                  //                     SelectCompanyDocument(
                  //                         imageSource: ImageSource.camera));
                  //               },
                  //               leading: const Icon(Icons.camera),
                  //               title: Text('camera'.tr),
                  //             ),
                  //             ListTile(
                  //               onTap: () {
                  //                 Get.back();
                  //                 context.read<CompanyBloc>().add(
                  //                     SelectCompanyDocument(
                  //                         imageSource: ImageSource.gallery));
                  //               },
                  //               leading: const Icon(Icons.image),
                  //               title: Text('gallery'.tr),
                  //             ),
                  //             ListTile(
                  //               onTap: () {
                  //                 Get.back();
                  //                 context.read<CompanyBloc>().add(
                  //                     SelectCompanyDocument(imageSource: null));
                  //               },
                  //               leading: const Icon(Icons.image),
                  //               title: Text('pdf'.tr),
                  //             ),
                  //           ],
                  //         )));
                  //       },
                  //       contentPadding: const EdgeInsets.all(0),
                  //       leading: (isEdit &&
                  //               state.addCompanyModel.certificateDocument == null)
                  //           ? BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
                  //               builder: (context, detailState) {
                  //                 if (detailState.companyDocuments == null) {
                  //                   return SizedBox();
                  //                 }

                  //                 return Container(
                  //                   height: 40,
                  //                   width: 40,
                  //                   child: certificate.name!.endsWith('.pdf')
                  //                       ? Icon(Icons.picture_as_pdf)
                  //                       : CustomImage(
                  //                           image: certificate.filePath ?? '',
                  //                           height: 40,
                  //                           width: 40,
                  //                           radius: 40,
                  //                         ),
                  //                 );
                  //               },
                  //             )
                  //           : Container(
                  //               height: 40,
                  //               width: 40,
                  //               decoration: BoxDecoration(
                  //                   color: ColorResources.backgroundColor,
                  //                   border: Border.all(
                  //                     width: state.addCompanyModel
                  //                                 .certificateDocument !=
                  //                             null
                  //                         ? 1
                  //                         : 6,
                  //                     color: ColorResources.lightBlue,
                  //                   ),
                  //                   shape: BoxShape.circle),
                  //               alignment: Alignment.center,
                  //               child: state.addCompanyModel.certificateDocument !=
                  //                       null
                  //                   ? state.addCompanyModel.certificateDocument!
                  //                           .path
                  //                           .endsWith('.pdf')
                  //                       ? Icon(Icons.picture_as_pdf)
                  //                       : ClipRRect(
                  //                           borderRadius: BorderRadius.circular(40),
                  //                           child: Image.file(
                  //                             File(state.addCompanyModel
                  //                                 .certificateDocument!.path),
                  //                             height: 40,
                  //                             width: 40,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         )
                  //                   : SvgPicture.asset(Images.svgDownload),
                  //             ),
                  //       title: Text(
                  //         state.addCompanyModel.certificateDocument != null
                  //             ? state.addCompanyModel.certificateDocument!.name
                  //             : 'upload_document'.tr,
                  //         style: body14.copyWith(color: ColorResources.gray),
                  //       ),
                  //       subtitle: Text(
                  //         state.addCompanyModel.certificateDocument != null
                  //             ? getFileSize(File(
                  //                 state.addCompanyModel.certificateDocument!.path))
                  //             : 'SVG, PNG, JPG',
                  //         style: textXS.copyWith(color: ColorResources.gray),
                  //       ),
                  //     );
                  //   }
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'other_documents_and_certificates'.tr,
                    style: h16.copyWith(color: ColorResources.darkGray),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'you_can_only_upload_up_to_10_documents'.tr,
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  // if (state.addCompanyModel.otherDocuments != null &&
                  //     state.addCompanyModel.otherDocuments!.isNotEmpty) ...[
                  //   const SizedBox(
                  //     height: 10,
                  //   ),
                  //   Wrap(
                  //     children: state.addCompanyModel.otherDocuments!
                  //         .asMap()
                  //         .entries
                  //         .map((entry) {
                  //       int index = entry.key;
                  //       XFile document = entry.value;
                  //       final isPdf = document.path.endsWith('.pdf');
                  //       return Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: ListTile(
                  //           dense: true,
                  //           contentPadding: const EdgeInsets.all(0),
                  //           leading: Container(
                  //             height: 40,
                  //             width: 40,
                  //             child: isPdf
                  //                 ? Icon(Icons.picture_as_pdf)
                  //                 : ClipRRect(
                  //                     borderRadius: BorderRadius.circular(40),
                  //                     child: Image.file(
                  //                       File(document.path),
                  //                       height: 40,
                  //                       width: 40,
                  //                       fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //           ),
                  //           title: Text(
                  //             document.name,
                  //             style: textStyle14Inter.copyWith(
                  //                 fontWeight: FontWeight.w700),
                  //           ),
                  //           subtitle: Text(getFileSize(File(document.path))),
                  //           trailing: GestureDetector(
                  //             onTap: () {
                  //               // Remove the selected image from the list
                  //               context
                  //                   .read<CompanyBloc>()
                  //                   .add(RemoveCompanyOtherDocument(index));
                  //             },
                  //             child: Icon(
                  //               Icons.delete,
                  //               color: Colors.red,
                  //               size: 20,
                  //             ),

                  //           ),
                  //         ),

                  //       );
                  //     }).toList(),
                  //   ),
                  // ],
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     Get.dialog(CustomDialog(
                  //         widget: SimpleDialog(
                  //       backgroundColor: Colors.white,
                  //       title: Row(
                  //         children: [
                  //           Expanded(child: Text('select_image'.tr)),
                  //           IconButton(
                  //             onPressed: () {
                  //               Get.back();
                  //             },
                  //             icon: const Icon(Icons.close),
                  //           ),
                  //         ],
                  //       ),
                  //       children: [
                  //         ListTile(
                  //           onTap: () {
                  //             Get.back();
                  //             context.read<CompanyBloc>().add(
                  //                 SelectCompanyOtherDocuments(
                  //                     imageSource: ImageSource.camera));
                  //           },
                  //           leading: const Icon(Icons.camera),
                  //           title: Text('camera'.tr),
                  //         ),
                  //         ListTile(
                  //           onTap: () {
                  //             Get.back();
                  //             context.read<CompanyBloc>().add(
                  //                 SelectCompanyOtherDocuments(
                  //                     imageSource: ImageSource.gallery));
                  //           },
                  //           leading: const Icon(Icons.image),
                  //           title: Text('gallery'.tr),
                  //         ),
                  //         ListTile(
                  //           onTap: () {
                  //             Get.back();
                  //             context.read<CompanyBloc>().add(
                  //                 SelectCompanyOtherDocuments(
                  //                     imageSource: null));
                  //           },
                  //           leading: const Icon(Icons.picture_as_pdf),
                  //           title: Text('pdf'.tr),
                  //         ),
                  //       ],
                  //     )));
                  //   },
                  //   contentPadding: const EdgeInsets.all(0),
                  //   leading: Container(
                  //     height: 40,
                  //     width: 40,
                  //     decoration: BoxDecoration(
                  //         color: ColorResources.backgroundColor,
                  //         border: Border.all(
                  //           width: 6,
                  //           color: ColorResources.lightBlue,
                  //         ),
                  //         shape: BoxShape.circle),
                  //     alignment: Alignment.center,
                  //     child: SvgPicture.asset(Images.svgDownload),
                  //   ),
                  //   title: Text(
                  //     'upload_document'.tr,
                  //     style: body14.copyWith(color: ColorResources.gray),
                  //   ),
                  //   subtitle: Text(
                  //     'SVG, PNG, JPG',
                  //     style: textXS.copyWith(color: ColorResources.gray),
                  //   ),
                  // ),
                  CompanyOtherDocumentsTile(isEdit: isEdit, state: state),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child:
            BlocBuilder<CompanyBloc, CompanyState>(builder: (context, state) {
          if (state.isLoading) {
            return CustomButtonLoader(width: Get.width, height: 44);
          }
          return CustomButton(
              width: Get.width,
              height: 44,
              onTap: () {
                _submitForm(context);
              },
              title: 'continue'.tr);
        }),
      ),
    );
  }
}
