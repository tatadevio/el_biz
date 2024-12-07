import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../base/custom_like_button.dart';
import '../product_detail_screen.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Похожие товары',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height * 0.45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                // return SizedBox(width: Get.width / 2.2, child: ProductGridItem());
                return productItem();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget productItem() {
    double height = Get.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailScreen());
        },
        child: SizedBox(
          width: Get.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CustomImage(image: '', height: Get.height * 0.25, width: Get.width * 0.4, radius: 16),
                  Positioned(top: 7, right: 7, child: CustomLikeButton()),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Стул раскладной',
                style: h16.copyWith(color: ColorResources.darkGray),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Раскладной садовый стул из дерева',
                style: body14.copyWith(color: ColorResources.gray),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '2 500 сом/шт',
                style: h16.copyWith(color: ColorResources.blue),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    '(4.0) ',
                    style: body14.copyWith(color: ColorResources.gray),
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 14,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => Icon(
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
      ),
    );
  }
}
