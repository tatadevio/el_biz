import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button_with_icon.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/add_company_screen.dart';
import 'package:el_biz/view/screen/company/delete_company_screen.dart';
import 'package:el_biz/view/screen/company/widgets/company_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../data/model/response/company/company_detail_model.dart';
import '../../../data/model/response/company/my_companies_model.dart';
import '../../../helper/date_helper.dart';
import '../../base/custom_button.dart';
import 'widgets/similar_companies_widget.dart';

class CompanyPageScreen extends StatelessWidget {
  final bool isCompany;

  const CompanyPageScreen({super.key, this.isCompany = false});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, companyController) {
        if (companyController.companyDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final companyDetail = companyController.companyDetailModel;
        // if (companyDetail?.data == null) {
        //   return SizedBox();
        // }
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              if (companyDetail?.data?.owner?.status ==
                                  'verified')
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
                                '(${companyDetail?.data?.reviewsAvgRating == null ? '0' : companyDetail?.data?.reviewsAvgRating == "" ? '0' : companyDetail?.data?.reviewsAvgRating ?? '0'})',
                                style:
                                    body14.copyWith(color: ColorResources.gray),
                              ),
                              RatingBar.builder(
                                initialRating: double.parse(companyDetail
                                            ?.data?.reviewsAvgRating ==
                                        null
                                    ? '0'
                                    : companyDetail?.data?.reviewsAvgRating ==
                                            ""
                                        ? '0'
                                        : companyDetail
                                                ?.data?.reviewsAvgRating ??
                                            '0'),
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
                    CompanyDataWidget(
                      scrollController: _scrollController,
                    ),
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
                          if (companyDetail?.data?.workingHours != null)
                            Text(
                              // 'с Пн по Пт, 09:00-18:00 Обед: 13:00-14:00',
                              formatWorkingHours(
                                  companyDetail!.data!.workingHours!),
                              style: body14.copyWith(
                                  color: ColorResources.darkGray,
                                  fontWeight: FontWeight.w400),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (companyDetail?.data?.lunchBreak != null) ...[
                            Text(
                              'lunch_break'.tr,
                              style: body14.copyWith(
                                  color: ColorResources.darkGray,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              // 'с Пн по Пт, 09:00-18:00 Обед: 13:00-14:00',
                              '${companyDetail!.data!.lunchBreak!.open ?? ''} - ${companyDetail.data!.lunchBreak!.close ?? ''}',
                              style: body14.copyWith(
                                  color: ColorResources.darkGray,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
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
                            companyDetail!.data?.legalEntity ?? '',
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if ((userState.selectedAccountModel!.isUser == true &&
                            companyDetail.data!.owner!.id ==
                                userState.selectedAccountModel!.userId) ||
                        (userState.selectedAccountModel!.isUser == false &&
                            userState.selectedAccountModel!.companyId ==
                                companyDetail.data!.id)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButtonWithIcon(
                              onTap: () {
                                Get.to(() => DeleteCompanyScreen(
                                      id: companyDetail.data?.id.toString() ??
                                          '',
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
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
              // add similar companies
              SimilarCompaniesWidget(
                companyId: companyDetail.data?.id.toString() ?? '',
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, companyState) {
          if (companyState.companyDetailLoading ||
              companyState.companyDetailModel?.data == null) {
            return SizedBox.shrink();
          }
          final companyData = companyState.companyDetailModel!;

          return BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if ((userState.selectedAccountModel!.isUser == true &&
                      companyData.data!.owner!.id ==
                          userState.selectedAccountModel!.userId) ||
                  (userState.selectedAccountModel!.isUser == false &&
                      userState.selectedAccountModel!.companyId ==
                          companyData.data!.id)) {
                return BottomAppBar(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: isCompany
                          ? GestureDetector(
                              onTap: () {
                                Get.to(() => AddCompanyScreen(
                                      isEdit: true,
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1, color: ColorResources.blue),
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
                                  style: button16.copyWith(
                                      color: ColorResources.blue),
                                ),
                              ),
                            )
                          : CustomButton(
                              width: Get.width,
                              height: 50,
                              title: "continue".tr,
                              onTap: () {},
                            )),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  String formatWorkingHours(WorkingHours workingHours) {
    final Map<String, LunchBreak?> hoursMap = {
      'monday': workingHours.monday,
      'tuesday': workingHours.tuesday,
      'wednesday': workingHours.wednesday,
      'thursday': workingHours.thursday,
      'friday': workingHours.friday,
      'saturday': workingHours.saturday,
      'sunday': workingHours.sunday,
    };

    const ruDays = {
      'monday': 'Пн',
      'tuesday': 'Вт',
      'wednesday': 'Ср',
      'thursday': 'Чт',
      'friday': 'Пт',
      'saturday': 'Сб',
      'sunday': 'Вс',
    };

    List<String> resultLines = ["Время работы:"];
    Map<String, List<String>> grouped = {};

    for (var entry in hoursMap.entries) {
      final day = entry.key;
      final value = entry.value;
      final open = value?.open;
      final close = value?.close;

      // Only include days with both open and close times
      if (open != null && close != null) {
        final timeRange = '$open-$close';
        grouped.putIfAbsent(timeRange, () => []).add(ruDays[day]!);
      }
    }

    for (var entry in grouped.entries) {
      final List<String> days = entry.value;
      final time = entry.key;

      if (days.length == 1) {
        resultLines.add('${days.first}, $time');
      } else {
        resultLines.add('с ${days.first} по ${days.last}, $time');
      }
    }

    return resultLines.join('\n');
  }
}
