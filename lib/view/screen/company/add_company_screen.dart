import 'dart:io';

import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_textfield.dart';
import 'package:el_biz/view/screen/company/company_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base/custom_dialog.dart';
import 'widgets/custom_add_company_appbar.dart';

class AddCompanyScreen extends StatefulWidget {
  final bool isEdit;
  const AddCompanyScreen({super.key, this.isEdit = false});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController legalNameController = TextEditingController();
  final TextEditingController okpoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      loadCompanyData();
    }
  }

  void loadCompanyData() {
    final companyData =
        context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;
    legalNameController.text = companyData.name ?? '';
    okpoController.text = companyData.okpo ?? '';
    // context.read<CategoryBloc>().add(GetCategory(currentPage: 1));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // final companyData = context.read<CompanyBloc>().state;
      // if ((widget.isEdit ||
      //     (companyData.addCompanyModel.companyLogo != null &&
      //         companyData.addCompanyModel.companyBanner != null))) {
      context.read<CompanyBloc>().state.addCompanyModel.companyName =
          legalNameController.text;
      context.read<CompanyBloc>().state.addCompanyModel.companyNumber =
          okpoController.text;
      Get.to(() => CompanyDescriptionScreen(
            isEdit: widget.isEdit,
          ));
      // } else {
      //   showShortToast('logo_and_banner_is_requried'.tr);
      // }
    } else {
      // validation issue...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAddCompanyAppbar(
          title: widget.isEdit ? "edit_company".tr : "register_company".tr),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'company_registration'.tr,
                      style: h24.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'please_take_a_few_minutes_to_fill_out_your_company_profile_correctly'
                          .tr,
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'ИНН НП: ',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        Text(
                          widget.isEdit
                              ? context
                                      .read<CompanyDetailBloc>()
                                      .state
                                      .companyDetailModel!
                                      .data!
                                      .tinNumber ??
                                  ""
                              : state.addCompanyModel.tinNumber ?? '',
                          style: body14,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'company_brand_name'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField1(
                      controller: legalNameController,
                      hintColor: '${"legal_name".tr}: ОсОО исхаков',
                      inputType: TextInputType.name,
                      lableText: 'ОсОО исхаков',
                      leading: '',
                      readOnly: false,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   'optional_field'.tr,
                    //   style: body12.copyWith(color: ColorResources.green),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField1(
                      controller: okpoController,
                      hintColor: 'ОКПО',
                      inputType: TextInputType.name,
                      lableText: 'ОКПО',
                      leading: '',
                      readOnly: false,
                      // validator: null,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'required_field'.tr;
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   'optional_field'.tr,
                    //   style: body12.copyWith(color: ColorResources.green),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'company_organization_logo'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // context.read<CompanyBloc>().add(SelectCompanyLogo());
                        Get.dialog(CustomDialog(
                            widget: SimpleDialog(
                          backgroundColor: Colors.white,
                          title: Row(
                            children: [
                              Expanded(child: Text('select_image'.tr)),
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              onTap: () {
                                Get.back();
                                context.read<CompanyBloc>().add(
                                    SelectCompanyLogo(
                                        imageSource: ImageSource.camera));
                              },
                              leading: const Icon(Icons.camera),
                              title: Text('camera'.tr),
                            ),
                            ListTile(
                              onTap: () {
                                Get.back();
                                context.read<CompanyBloc>().add(
                                    SelectCompanyLogo(
                                        imageSource: ImageSource.gallery));
                              },
                              leading: const Icon(Icons.image),
                              title: Text('gallery'.tr),
                            ),
                          ],
                        )));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: ColorResources.lgColor,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: state.addCompanyModel.companyLogo == null
                                ? widget.isEdit
                                    ? CustomImage(
                                        image: context
                                                .read<CompanyDetailBloc>()
                                                .state
                                                .companyDetailModel!
                                                .data!
                                                .logo ??
                                            '',
                                        height: 72,
                                        width: 72,
                                        radius: 72)
                                    : Image.asset(Images.uploadImagePng)
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(72),
                                    child: Image.file(
                                      File(state
                                          .addCompanyModel.companyLogo!.path),
                                      fit: BoxFit.cover,
                                      height: 72,
                                      width: 72,
                                    ),
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'download'.tr,
                                style: h16.copyWith(color: ColorResources.gray),
                              ),
                              Text(
                                'SVG, PNG, JPG',
                                style:
                                    textXS.copyWith(color: ColorResources.gray),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'company_organization_banner'.tr,
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CompanyBloc>().add(SelectCompanyBanner());
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: ColorResources.lgColor,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: state.addCompanyModel.companyBanner == null
                            ? widget.isEdit
                                ? CustomImage(
                                    image: context
                                            .read<CompanyDetailBloc>()
                                            .state
                                            .companyDetailModel!
                                            .data!
                                            .banner ??
                                        '',
                                    height: 100,
                                    width: Get.width,
                                    radius: 12)
                                :

                                // context.read<CompanyDetailBloc>().state.companyDetailModel!.data!;

                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.imagePng,
                                        height: 40,
                                        width: 40,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'download_banner'.tr,
                                            style: body14.copyWith(
                                                color: ColorResources.gray),
                                          ),
                                          Text(
                                            'SVG, PNG, JPG',
                                            style: textXS.copyWith(
                                                color: ColorResources.gray),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(state
                                      .addCompanyModel.companyBanner!.path),
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'optional_field'.tr,
                      style: body12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: CustomButton(
            width: Get.width,
            height: 44,
            onTap: () {
              _submitForm();
            },
            title: 'continue'.tr),
      ),
    );
  }
}
