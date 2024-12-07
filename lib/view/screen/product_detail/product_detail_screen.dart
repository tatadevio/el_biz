import 'package:el_biz/controller/product_detail_controller.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/product_detail/widgets/about_product_widget.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_images.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_reviews_widget.dart';
import 'package:el_biz/view/screen/product_detail/widgets/similar_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('product detail'),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.primary,
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
            child: SvgPicture.asset(Images.svgAlert),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: GetBuilder<ProductDetailController>(builder: (productDetialController) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProductImages(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(16, 24, 40, 0.06),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Стул раскладной',
                            style: h24.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: ColorResources.lgColor),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
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
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Раскладной садовый стул из шпона дерева.',
                      style: body16.copyWith(color: ColorResources.gray),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2 500 сом',
                      style: h24.copyWith(color: ColorResources.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
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
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Загружено: ',
                              style: body14.copyWith(color: ColorResources.gray, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '12 окт. 2024',
                              style: body14.copyWith(color: ColorResources.gray),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Минимальный заказ: ',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          Text(
                            '5 шт',
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            'Наличие: ',
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          Text(
                            'Уточнять наличие',
                            style: body16.copyWith(color: ColorResources.gray),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            productDetialController.toggleShowProductReview(false);
                          },
                          child: Container(
                            height: 40,
                            width: width * 0.43,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: productDetialController.showProductReviews ? null : ColorResources.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'О товаре',
                              style: button16.copyWith(color: productDetialController.showProductReviews ? ColorResources.gray : ColorResources.white),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            productDetialController.toggleShowProductReview(true);
                          },
                          child: Container(
                            height: 40,
                            width: width * 0.45,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: !productDetialController.showProductReviews ? null : ColorResources.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Отзывы',
                              style: button16.copyWith(color: !productDetialController.showProductReviews ? ColorResources.gray : ColorResources.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    if (productDetialController.showProductReviews) ...[
                      ProductReviewsWidget(),
                    ] else ...[
                      AboutProductWidget(),
                    ],
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(16, 24, 40, 0.06),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorResources.lightBlue,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: ColorResources.lgColor),
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CustomImage(image: '', height: 40, width: 40, radius: 40),
                        title: Text(
                          'Садовая мебель Loft',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        subtitle: Text(
                          'ОсОО...',
                          style: body14.copyWith(color: ColorResources.darkGray),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Images.svgVerified),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Проверенный поставщик',
                            style: body14.copyWith(color: ColorResources.gray),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SimilarProductsWidget(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
    );
  }
}
