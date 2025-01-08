import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/Images.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../company/company_reviews_screen.dart';
import '../../company/widgets/company_data.dart/review_item.dart';

class ProductReviewsWidget extends StatelessWidget {
  const ProductReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // if (product.review.isEmpty) {
    //   return Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 50),
    //         child: Center(
    //           child: Text(
    //             'На этот товар еще нет отзывов',
    //             style: body14.copyWith(color: ColorResources.gray),
    //           ),
    //         ),
    //       ),
    //       CustomBorderButton(
    //         onTap: () {
    //           Get.bottomSheet(CustomAddReviewWidget(), isScrollControlled: true, backgroundColor: Colors.white);
    //         },
    //         height: 44,
    //         width: Get.width,
    //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    //         border: Border.all(width: 1, color: ColorResources.blue),
    //         borderRadius: BorderRadius.circular(12),
    //         boxShaow: [
    //           ColorResources.shadow1,
    //         ],
    //         child: Text(
    //           'Написать отзыв',
    //           style: textMd.copyWith(color: ColorResources.blue),
    //         ),
    //       ),
    //     ],
    //   );
    // }
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const ReviewItem();
          },
        ),
        const Divider(),
        InkWell(
          onTap: () {
            Get.to(() => CompanyReviewsScreen());
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
  }
}
