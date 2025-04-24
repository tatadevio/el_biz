import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/delete_company_screen.dart';
import 'package:el_biz/view/screen/company/widgets/company_data_widget.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../helper/date_helper.dart';
import '../../base/custom_button.dart';

class CompanyPageScreen extends StatelessWidget {
  final bool isCompany;

  const CompanyPageScreen({super.key, this.isCompany = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, companyController) {
        if (companyController.companyDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final companyDetail = companyController.companyDetailModel;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: -2,
                        offset: Offset(0, 2),
                        color: Color.fromRGBO(16, 24, 40, 0.05),
                      ),
                    ]),
                child: Column(
                  children: [
                    CustomImage(
                        image: companyDetail?.data?.banner ?? '',
                        height: 100,
                        width: Get.width,
                        radius: 12),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImage(
                            image: companyDetail?.data?.logo ?? '',
                            height: 72,
                            width: 72,
                            radius: 72),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                companyDetail?.data?.name ?? '',
                                // 'Садовая мебель Loft',
                                style: h24.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                // 'ОсОО Исхаков',
                                companyDetail?.data?.description ?? '',
                                style:
                                    body14.copyWith(color: ColorResources.gray),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(Images.svgVerified),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'verified_user'.tr,
                                      style: body14.copyWith(
                                          color: ColorResources.gray),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(Images.svgMap),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      companyDetail?.data?.address ?? '',
                                      // 'Бишкек, ул.Масалиева 12/3',
                                      style: body14.copyWith(
                                          color: ColorResources.gray),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '(${companyDetail?.data?.rating == null ? '0' : companyDetail?.data?.rating == "" ? '0' : companyDetail?.data?.rating ?? '0'})',
                                style:
                                    body14.copyWith(color: ColorResources.gray),
                              ),
                              RatingBar.builder(
                                initialRating: double.parse(companyDetail
                                            ?.data?.rating ==
                                        null
                                    ? '0'
                                    : companyDetail?.data?.rating == ""
                                        ? '0'
                                        : companyDetail?.data?.rating ?? '0'),
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 14,
                                ignoreGestures: true,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: ColorResources.yellow,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'В В2В: ',
                              style:
                                  body16.copyWith(color: ColorResources.gray),
                            ),
                            // if (!isAdding)
                            Text(
                              formatDateInRu(
                                  companyDetail?.data?.createdAt.toString() ??
                                      ''),
                              // '12 окт. 2024',
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CompanyDataWidget(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: -2,
                        offset: Offset(0, 2),
                        color: Color.fromRGBO(16, 24, 40, 0.05),
                      ),
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'opening_hours'.tr,
                            style: body14.copyWith(
                                color: ColorResources.darkGray,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            // 'с Пн по Пт, 09:00-18:00 Обед: 13:00-14:00',
                            companyDetail?.data?.workingTime ?? '',
                            style: body14.copyWith(
                                color: ColorResources.darkGray,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'legal_name'.tr,
                            // 'Юр. лицо: ',
                            style: body14.copyWith(
                                color: ColorResources.darkGray,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            // 'ОсОО “Loft”',
                            companyDetail?.data?.legalEntity ?? '',
                            style: body14.copyWith(
                                color: ColorResources.darkGray,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              if (isCompany) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButtonWithIcon(
                        onTap: () {
                          Get.to(() => DeleteCompanyScreen(
                                id: companyDetail?.data?.id.toString() ?? '',
                              ));
                        },
                        title: 'delete_profile'.tr,
                        svgIcon: Images.svgTrash,
                        textColor: Colors.white,
                        svgIconColor: Colors.white,
                        buttonColor: ColorResources.red,
                        borderColor: ColorResources.red,
                        isMaxSize: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: isCompany
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: ColorResources.blue),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1),
                          color: Color.fromRGBO(16, 24, 40, 0.05),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'edit_profile'.tr,
                      style: button16.copyWith(color: ColorResources.blue),
                    ),
                  )
                : CustomButton(
                    width: Get.width,
                    height: 50,
                    title: "continue".tr,
                    onTap: () {},
                  )),
      ),
    );
  }
}
