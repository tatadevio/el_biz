import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../company/company_page_screen.dart';
import '../../company/new_companies_screen.dart';

class NewCompaniesWidget extends StatelessWidget {
  const NewCompaniesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
      builder: (context, state) {
        if (state.isLoading || state.newCompanies.isEmpty) {
          return SizedBox();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'new_companies'.tr,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: width * 0.4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.newCompanies.length,
                itemBuilder: (context, index) {
                  return companiesItem(context, state.newCompanies[index]);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const NewCompaniesScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'all_companies'.tr,
                        style: button16.copyWith(color: ColorResources.blue),
                      ),
                      SvgPicture.asset(Images.svgArrowForwardIcon),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget companiesItem(BuildContext context, CompanyItem company,
      {bool isVerifiedSupplier = false}) {
    double width = Get.width;
    return GestureDetector(
      onTap: () {
        context
            .read<CompanyDetailBloc>()
            .add(GetCompanyDetail(company.id.toString()));
        Get.to(() => const CompanyPageScreen(
              isCompany: true,
            ));
      },
      child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: ColorResources.lgColor,
          ),
          color: ColorResources.lightBlue,
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: -2,
              offset: Offset(0, 4),
              color: Color.fromRGBO(16, 24, 40, 0.1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: const EdgeInsets.only(top: 10, left: 5),
            //   height: 40,
            //   width: 40,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(
            //         width: 0.56,
            //         color: ColorResources.lgColor,
            //       )),
            //       chi
            // ),
            CustomImage(
                image: company.logo ?? '', height: 40, width: 40, radius: 40),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        company.name ?? '',
                        // 'Садовая мебель Loft',
                        style: h16.copyWith(color: ColorResources.darkGray),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.favorite,
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    company.owner?.name ?? '',
                    // 'ОсОО...',
                    style: body14.copyWith(color: ColorResources.darkGray),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (company.verificationStatus == 'verified')
                    Row(
                      children: [
                        SvgPicture.asset(Images.svgVerified),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Проверенный поставщик',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Images.svgMap,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        company.address ?? '',
                        // 'Кыргызстан, Бишкек',
                        style: body14.copyWith(color: ColorResources.gray),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              company.reviewsAverageRating ?? '',
                              // '(4,8)',
                              style:
                                  body14.copyWith(color: ColorResources.gray),
                            ),
                            RatingBar.builder(
                              initialRating: double.tryParse(
                                      company.reviewsAverageRating ?? '0') ??
                                  0,
                              minRating: 1,
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
                        children: [
                          Text(
                            'more_details'.tr,
                            style:
                                button16.copyWith(color: ColorResources.blue),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Images.svgArrowForwardIcon),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   width: 10,
            // ),
          ],
        ),
      ),
    );
  }
}
