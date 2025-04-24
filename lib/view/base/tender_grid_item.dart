import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/base/custom_like_button.dart';
import 'package:el_biz/view/screen/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/response/tender/tender_item_model.dart';

class TenderGridItem extends StatelessWidget {
  final bool isFavorite;
  final TenderItem tender;
  const TenderGridItem(
      {super.key, this.isFavorite = false, required this.tender});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const ProductDetailScreen(
              isProduct: false,
            ));
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
                  // Image.asset(Images.splashLogo),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CustomLikeButton(isFavorite: isFavorite),
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
                  tender.title ?? '',
                  // 'Садовая мебель, раскладные стулья',
                  style: h16.copyWith(color: ColorResources.darkGray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  tender.description ?? '',
                  // 'Раскладной садовый стул из дерева',
                  style: body14.copyWith(color: ColorResources.gray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Количество:  ${tender.quantity} шт', // quantity
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: body14.copyWith(
                      color: const Color.fromRGBO(71, 84, 103, 1)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Бюджет: ${tender.budgetFrom} - ${tender.budgetTo}сом',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: body14.copyWith(
                      color: const Color.fromRGBO(71, 84, 103, 1)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Юр.лицо',
                      style: body14.copyWith(color: ColorResources.gray),
                    ),
                    Text(
                      formatDateInRu(tender.createdAt.toString()),
                      style: body14.copyWith(color: ColorResources.gray),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
