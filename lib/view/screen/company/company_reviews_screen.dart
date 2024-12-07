import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_add_review_widget.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../base/custom_border_button.dart';

class CompanyReviewsScreen extends StatelessWidget {
  const CompanyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Отзывы на компанию',
          style: h16.copyWith(color: ColorResources.darkGray),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
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
                                        const TextSpan(
                                          text: '4.8',
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
                                          style: body14.copyWith(color: ColorResources.darkGray),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '12 отзывов',
                                    style: body14.copyWith(color: ColorResources.gray),
                                  ),
                                ],
                              ),
                              RatingBar.builder(
                                initialRating: 4.8,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 14,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
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
                          return customRatingBar((index + 1).toString(), (index + 1) / 5);
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ReviewItem();
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: CustomBorderButton(
          onTap: () {
            Get.bottomSheet(CustomAddReviewWidget(), isScrollControlled: true, backgroundColor: Colors.white);
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
            'Написать отзыв',
            style: textMd.copyWith(color: ColorResources.blue),
          ),
        ),
      ),
    );
  }

  Widget customRatingBar(String rating, double ratingValue) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            rating,
            style: body12,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: ratingValue.clamp(0.0, 1.0),
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(ColorResources.yellow),
            minHeight: 8,
          ),
        )
      ],
    );
  }
}
