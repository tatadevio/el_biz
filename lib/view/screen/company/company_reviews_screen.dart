import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_add_review_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../bloc/company_detail/company_detail_bloc.dart';
import '../../base/custom_border_button.dart';

class CompanyReviewsScreen extends StatelessWidget {
  final String companyId;

  const CompanyReviewsScreen({
    super.key,
    required this.companyId,
  });

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<CompanyDetailBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isMoreLoading) {
        int pageSize = accountController.state.pageSize;
        if (accountController.state.currentPage < pageSize) {
          int nextPage = accountController.state.currentPage;

          accountController.add(GetCompanyReviews(companyId, nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    _callScrolling(context, _controller);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'reviews_of_the_company'.tr,
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
      ),
      body: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: double.parse((state
                                                            .companyReviewsModel
                                                            ?.data
                                                            ?.averageRating ??
                                                        '0')
                                                    .toString())
                                                .toStringAsFixed(2),
                                            // '4.8',
                                            // rating.toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.darkGray,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '/5',
                                            // '/$maxRating',
                                            style: body14.copyWith(
                                                color: ColorResources.darkGray),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${state.companyReviewsModel?.data?.totalReviews} отзывов',
                                      style: body14.copyWith(
                                          color: ColorResources.gray),
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: double.parse(state
                                          .companyReviewsModel
                                          ?.data
                                          ?.averageRating ??
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final data = state.companyReviewsModel?.data;

                            final Map<int, int> ratings = {
                              5: data?.total5Rating ?? 0,
                              4: data?.total4Rating ?? 0,
                              3: data?.total3Rating ?? 0,
                              2: data?.total2Rating ?? 0,
                              1: data?.total1Rating ?? 0,
                            };

                            final int maxRatingCount = data?.maximumRating ?? 0;

                            int rating = index + 1;
                            int count = ratings[rating] ?? 0;
                            double percentage = maxRatingCount > 0
                                ? (count / maxRatingCount) * 100
                                : 0;

                            // return customRatingBar(
                            //     (index + 1).toString(), (index + 1) / 5);
                            return customRatingBar(
                                (index + 1).toString(), percentage);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state.companyReviews != null &&
                    state.companyReviews!.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.companyReviews!.length,
                    itemBuilder: (context, index) {
                      return ReviewItemWidget(
                        review: state.companyReviews![index],
                        reviewIndex: index,
                      );
                    },
                  ),
                const Divider(),
                if (state.isMoreLoading)
                  const Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomBorderButton(
          onTap: () {
            Get.bottomSheet(
                CustomAddReviewWidget(
                  companyId: companyId,
                ),
                isScrollControlled: true,
                backgroundColor: Colors.white);
          },
          height: 44,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: Border.all(width: 1, color: ColorResources.blue),
          borderRadius: BorderRadius.circular(12),
          boxShaow: const [
            ColorResources.shadow1,
          ],
          child: Text(
            'write_a_review'.tr,
            style: textMd.copyWith(color: ColorResources.blue),
          ),
        ),
      ),
    );
  }

  // Widget customRatingBar(String rating, double ratingValue) {
  //   print('this is ratingValue $ratingValue');
  //   return Row(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 4),
  //         child: Text(
  //           rating,
  //           style: body12,
  //         ),
  //       ),
  //       const SizedBox(
  //         width: 8,
  //       ),
  //       Expanded(
  //         child: LinearProgressIndicator(
  //           value: ratingValue.clamp(0.0, 1.0),
  //           backgroundColor: Colors.grey.shade300,
  //           valueColor:
  //               const AlwaysStoppedAnimation<Color>(ColorResources.yellow),
  //           minHeight: 8,
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget customRatingBar(String starLabel, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 20, child: Text('$starLabel')),
          // const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: percentage / 100,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
