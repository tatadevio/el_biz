import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/product_detail/product_detail_screen.dart';
import 'check_box_button.dart';

class ProductListItem extends StatelessWidget {
  final bool isFavorite;
  final bool isSelectProduct;
  final int? productId;

  const ProductListItem(
      {super.key,
      this.isFavorite = false,
      this.isSelectProduct = false,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(() => const ProductDetailScreen());
        },
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                children: [
                  CustomImage(image: '', height: 120, width: 100, radius: 16),
                  // Image.asset(
                  //   Images.splashLogo,
                  //   height: 120,
                  //   width: 100,
                  // ),
                  if (!isSelectProduct)
                    Positioned(
                      right: 10,
                      top: 5,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1),
                              color: Color.fromRGBO(16, 24, 40, 0.05),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          isFavorite ? Images.svgHeart : Images.svgHeartBorder,
                          color: isFavorite ? ColorResources.primaryRed : null,
                        ),
                      ),
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
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
