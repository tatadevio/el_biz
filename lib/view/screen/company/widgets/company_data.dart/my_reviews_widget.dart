import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/company/company_reviews_screen.dart';
import 'package:el_biz/view/screen/company/widgets/company_data.dart/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyReviewsWidget extends StatelessWidget {
  const MyReviewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
