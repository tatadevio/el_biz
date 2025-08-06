import 'package:el_biz/view/screen/company/company_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../../data/model/response/company/my_companies_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_image.dart';

class SimilarCompaniesWidget extends StatelessWidget {
  final String companyId;
  const SimilarCompaniesWidget({super.key, required this.companyId});

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final similarCompanyBloc = context.read<SimilarCompaniesBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !similarCompanyBloc.state.isLoading &&
          !similarCompanyBloc.state.isMoreLoading) {
        print(
            'going to call the similar company list pagination ${similarCompanyBloc.state.totalPages} and ${similarCompanyBloc.state.currentPage} and company ${companyId}');
        int pageSize = similarCompanyBloc.state.totalPages;
        if (similarCompanyBloc.state.currentPage < pageSize) {
          int nextPage = similarCompanyBloc.state.currentPage;

          similarCompanyBloc.add(GetSimilarCompanies(
              companyId: companyId, currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    _callScrolling(context, _scrollController);
    return BlocBuilder<SimilarCompaniesBloc, SimilarCompaniesState>(
      builder: (context, similarCompaniesState) {
        return similarCompaniesState.similarCompanies.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Похожие поставщики',
                      style: h16.copyWith(color: ColorResources.darkGray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: Get.width * 0.4,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  similarCompaniesState.similarCompanies.length,
                              itemBuilder: (context, index) {
                                return companiesItem(
                                    context,
                                    similarCompaniesState
                                        .similarCompanies[index]);
                              },
                            ),
                            if (similarCompaniesState.isMoreLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ).paddingOnly(bottom: 80),
                  ],
                ),
              )
            : SizedBox.shrink();
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
        context.read<SimilarCompaniesBloc>().add(GetSimilarCompanies(
            companyId: company.id.toString(), currentPage: 1));
        Get.to(() => const CompanyPageScreen(
              isCompany: true,
            ));
      },
      child: Container(
        width: width * 0.83,
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
