import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bloc/company_detail/company_detail_bloc.dart';
import '../../utils/Images.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/company/company_page_screen.dart';
import 'custom_image.dart';

class CompanyItemWidget extends StatelessWidget {
  final CompanyItem company;
  final bool isSearchCompany;
  const CompanyItemWidget({super.key, required this.company, this.isSearchCompany = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          // context
          //     .read<CompanyBloc>()
          //     .add(CompanyDetailById(company.id.toString()));
          context
              .read<CompanyDetailBloc>()
              .add(GetCompanyDetail(company.id.toString()));
          Get.to(() => const CompanyPageScreen(
                isCompany: true,
              ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: ColorResources.lightBlue,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(width: 1, color: ColorResources.lgColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImage(
                      image: company.logo ?? '',
                      height: 40,
                      width: 40,
                      radius: 40),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.name ?? '',
                          style: h16.copyWith(
                            color: ColorResources.darkGray,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          company.email ?? '',
                          style:
                              body14.copyWith(color: ColorResources.darkGray),
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
                                company.address ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    body14.copyWith(color: ColorResources.gray),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "(${company.reviewsAverageRating == "" ? "0" : company.reviewsAverageRating ?? '0'})",
                                    // '(4.8)',
                                    style: body14.copyWith(
                                        color: ColorResources.gray),
                                  ),
                                  RatingBar.builder(
                                    initialRating: double.tryParse(
                                            company.reviewsAverageRating ??
                                                '0') ??
                                        0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 14,
                                    ignoreGestures: true,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0),
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
                                  'more_details'.tr,
                                  style: button16.copyWith(
                                      color: ColorResources.blue),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(Images.svgArrowForward),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
