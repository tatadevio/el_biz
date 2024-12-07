import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/color_resources.dart';
import '../../utils/custom_text_style.dart';
import '../screen/product_detail/product_detail_screen.dart';

class TenderListItem extends StatelessWidget {
  const TenderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailScreen());
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
                      child: SvgPicture.asset(Images.svgHeartBorder),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Садовая мебель, раскладные стулья',
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
                          'Количество: 20шт',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: body14.copyWith(color: Color.fromRGBO(71, 84, 103, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Бюджет: 50 000 сом',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: body14.copyWith(color: Color.fromRGBO(71, 84, 103, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Юр.лицо',
                          style: body14.copyWith(color: ColorResources.gray),
                        ),
                        Text(
                          '12 окт. 2024',
                          style: body14.copyWith(color: ColorResources.gray),
                        )
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
