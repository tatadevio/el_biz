import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/company_detail/company_detail_bloc.dart';
import '../../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../../data/model/response/company/my_companies_model.dart';
import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_toast.dart';
import '../../company/company_page_screen.dart';

class PublicCompaniesWidget extends StatefulWidget {
  const PublicCompaniesWidget({super.key});

  @override
  State<PublicCompaniesWidget> createState() => _PublicCompaniesWidgetState();
}

class _PublicCompaniesWidgetState extends State<PublicCompaniesWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }

      final publicCompanies = context.read<PublicCompanyBloc>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !publicCompanies.state.isLoading &&
          !publicCompanies.state.isMoreLoading) {
        if (publicCompanies.state.isFilterEnable) {
          int pageSize = publicCompanies.state.filterPageSize;
          if (publicCompanies.state.filterCurrentPage < pageSize) {
            int nextPage = publicCompanies.state.filterCurrentPage;

            context.read<PublicCompanyBloc>().add(FilterPublicCompanyProduct(
                productFilterValuesModel:
                    publicCompanies.state.companyFilterValuesModel!,
                currentPage: nextPage + 1));
          }
        } else {
          int pageSize = publicCompanies.state.companyPageSize;
          if (publicCompanies.state.companyCurrentPage < pageSize) {
            int nextPage = publicCompanies.state.companyCurrentPage;

            context
                .read<PublicCompanyBloc>()
                .add(GetPublicCompany(nextPage + 1));
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
            builder: (context, companyState) {
          if (companyState.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (companyState.publicCompanies.isEmpty &&
              !companyState.isFilterEnable) {
            return Center(
              child: Text('no_companies_found'.tr),
            );
          }

          if (companyState.filterCompanies.isEmpty &&
              companyState.isFilterEnable) {
            return Center(
              child: Text('no_companies_found'.tr),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (companyState.isFilterEnable) {
                context.read<PublicCompanyBloc>().add(
                    FilterPublicCompanyProduct(
                        productFilterValuesModel:
                            companyState.companyFilterValuesModel!,
                        currentPage: 1));
              } else {
                context.read<PublicCompanyBloc>().add(GetPublicCompany(1));
              }
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: companyState.isFilterEnable
                        ? companyState.filterCompanies.length
                        : companyState.publicCompanies.length,
                    itemBuilder: (context, index) {
                      return myCompanyWidget(companyState.isFilterEnable
                          ? companyState.filterCompanies[index]
                          : companyState.publicCompanies[index]);
                    },
                  ),
                  if (companyState.isMoreLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ).paddingOnly(
                        bottom: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          );
        }),
        if (_showScrollToTopButton)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _scrollToTop,
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorResources.primary,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget myCompanyWidget(CompanyItem company) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          if (context.read<AuthBloc>().state.isLoggedIn) {
            // context
            //     .read<CompanyBloc>()
            //     .add(CompanyDetailById(company.id.toString()));
            context
                .read<CompanyDetailBloc>()
                .add(GetCompanyDetail(company.id.toString()));
            context.read<SimilarCompaniesBloc>().add(GetSimilarCompanies(
                companyId: company.id.toString(), currentPage: 1));
            Get.to(() => const CompanyPageScreen(
                  isCompany: true,
                ));
          } else {
            showShortToast('login_to_view_company'.tr);
          }
        },
        child: Stack(
          children: [
            Container(
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
                              style: body14.copyWith(
                                  color: ColorResources.darkGray),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        company.reviewsAverageRating ?? '0',
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
            // Positioned(
            //   right: 10,
            //   top: 10,
            //   child: Container(
            //     height: 32,
            //     width: 32,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       backgroundBlendMode: BlendMode.colorDodge,
            //       boxShadow: const [
            //         BoxShadow(
            //           blurRadius: 1.6,
            //           spreadRadius: 0,
            //           offset: Offset(0, 0.8),
            //           color: Color.fromRGBO(16, 24, 40, 0.05),
            //         ),
            //       ],
            //     ),
            //     alignment: Alignment.center,
            //     child: SvgPicture.asset(Images.svgHeartBorder),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
