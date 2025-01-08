import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/check_box_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_like_button.dart';
import 'package:el_biz/view/screen/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductGridItem extends StatelessWidget {
  final bool isFavorite;
  final bool isSelectProduct;
  final int? productId;

  const ProductGridItem(
      {super.key,
      this.isFavorite = false,
      this.isSelectProduct = false,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const ProductDetailScreen());
      },
      child: Container(
        decoration: const BoxDecoration(
            // border: Border.all(
            //   width: 1,
            //   color: ColorResources.lgColor,
            // ),
            ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  CustomImage(
                      image: '',
                      height: Get.height,
                      width: Get.width,
                      radius: 16),
                  if (!isSelectProduct)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: CustomLikeButton(isFavorite: isFavorite),
                    ),
                  if (isSelectProduct)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CheckBoxButton(
                        productId: productId,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Стул раскладной',
                  style: h16.copyWith(color: ColorResources.darkGray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Раскладной садовый стул из дерева',
                  style: body14.copyWith(color: ColorResources.gray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '2 500 сом/шт',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: h16.copyWith(color: ColorResources.blue),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '(4.8) ',
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                    RatingBar.builder(
                      initialRating: 4.8,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 14,
                      ignoreGestures: true,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
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
          ],
        ),
      ),
    );
  }
}
