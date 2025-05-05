import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/product_review/product_review_bloc.dart';
import 'package:el_biz/view/screen/product_detail/product_review_screen.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_review_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/custom_add_review_widget.dart';
import '../../../base/custom_border_button.dart';

class ProductReviewsWidget extends StatelessWidget {
  const ProductReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // if (product.review.isEmpty) {

    // }
    return BlocBuilder<ProductReviewBloc, ProductReviewState>(
        builder: (context, reviewState) {
      if (reviewState.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (reviewState.productReviews.isEmpty) {
        // return Center(
        //   child: Text('no_review_found'.tr),
        // );
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Text(
                  'На этот товар еще нет отзывов',
                  style: body14.copyWith(color: ColorResources.gray),
                ),
              ),
            ),
            CustomBorderButton(
              onTap: () {
                Get.bottomSheet(
                    CustomAddReviewWidget(
                      companyId: '',
                      isProduct: true,
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
                'Написать отзыв',
                style: textMd.copyWith(color: ColorResources.blue),
              ),
            ),
          ],
        );
      }
      return Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: reviewState.productReviews.length > 3
                ? 3
                : reviewState.productReviews.length,
            itemBuilder: (context, index) {
              final review = reviewState.productReviews[index];
              return ProductReviewItemWidget(
                review: review,
                reviewIndex: index,
              ); // update here
            },
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Get.to(() => ProductReviewsScreen(
                    productId: context
                            .read<ProductDetailBloc>()
                            .state
                            .productDetailModel
                            ?.data
                            ?.id
                            .toString() ??
                        '',
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Все отзывы',
                  style: button16.copyWith(color: ColorResources.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(Images.svgArrowForward),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Отзывы могут оставлять только те, кто заключал договор с данной компанией.  Так мы формируем честный рейтинг',
            style: body14.copyWith(color: ColorResources.gray),
          ),
        ],
      );
    });
  }
}
