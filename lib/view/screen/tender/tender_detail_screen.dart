import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/data/model/response/tender/tender_detail_model.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/product/add_product_screen.dart';
import 'package:el_biz/view/screen/product_detail/widgets/about_product_widget.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_images.dart';
import 'package:el_biz/view/screen/product_detail/widgets/product_reviews_widget.dart';
import 'package:el_biz/view/screen/product_detail/widgets/similar_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/tender_detail/tender_detail_bloc.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';

class TenderDetailScreen extends StatelessWidget {
  final bool isProduct;

  const TenderDetailScreen({super.key, this.isProduct = true});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('tender_detail'),
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
      body: BlocBuilder<TenderDetailBloc, TenderDetailState>(
          builder: (context, productDetialController) {
        if (productDetialController is TenderDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productDetialController is TenderDetailError) {
          return Center(
            child: Text('error'),
          );
        }
        var tenderDetail = TenderDetailModel();
        if (productDetialController is TenderDetailSuccess) {
          tenderDetail = productDetialController.tenderDetailModel;
        }
        // tenderDetail = productDetialController.tenderDetailModel;
        return SingleChildScrollView(
          child: Column(
            children: [
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ProductImages(
                  image: tenderDetail.data?.media ?? [],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
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
                            tenderDetail.data?.title ?? '',
                            // 'Стул раскладной hrer update',
                            style: h24.copyWith(color: ColorResources.darkGray),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: ColorResources.lgColor),
                            borderRadius: BorderRadius.circular(12),
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
                      ],
                    ),
                    if (isProduct) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        tenderDetail.data?.description ?? '',
                        // 'Раскладной садовый стул из шпона дерева.',
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${tenderDetail.data?.budgetFrom} - ${tenderDetail.data?.budgetTo} ${AppConstants.currencyCode}',
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
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                                RatingBar.builder(
                                  initialRating: 4,
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
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Загружено: ',
                                style: body14.copyWith(
                                    color: ColorResources.gray,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '12 окт. 2024',
                                style:
                                    body14.copyWith(color: ColorResources.gray),
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
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            Text(
                              '5 шт',
                              style:
                                  body16.copyWith(color: ColorResources.gray),
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
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            Text(
                              'Уточнять наличие',
                              style:
                                  body16.copyWith(color: ColorResources.gray),
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
                              // productDetialController.toggleShowProductReview(false);
                              context
                                  .read<ProductDetailBloc>()
                                  .add(const ToggleShowProductReview(false));
                            },
                            child: Container(
                              height: 40,
                              width: width * 0.43,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              // decoration: BoxDecoration(
                              //   color:
                              //       productDetialController.showProductReviews
                              //           ? null
                              //           : ColorResources.primary,
                              //   borderRadius: BorderRadius.circular(6),
                              // ),
                              alignment: Alignment.center,
                              child: Text(
                                'О товаре',
                                // style: button16.copyWith(
                                //     color: productDetialController
                                //             .showProductReviews
                                //         ? ColorResources.gray
                                //         : ColorResources.white),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {
                              // productDetialController.toggleShowProductReview(true);
                              context
                                  .read<ProductDetailBloc>()
                                  .add(const ToggleShowProductReview(true));
                            },
                            child: Container(
                              height: 40,
                              width: width * 0.45,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              // decoration: BoxDecoration(
                              //   color:
                              //       !productDetialController.showProductReviews
                              //           ? null
                              //           : ColorResources.primary,
                              //   borderRadius: BorderRadius.circular(6),
                              // ),
                              alignment: Alignment.center,
                              child: Text(
                                'Отзывы',
                                // style: button16.copyWith(
                                //     color: !productDetialController
                                //             .showProductReviews
                                //         ? ColorResources.gray
                                //         : ColorResources.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      // if (productDetialController.showProductReviews) ...[
                      //   const ProductReviewsWidget(),
                      // ] else ...[
                      //   const AboutProductWidget(),
                      // ],
                    ] else ...[
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Описание',
                        style: h16.copyWith(color: ColorResources.darkGray),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ищу поставщиков садовой мебели, конкретно раскладных стульев хорошего качества, из натуральных материалов, с интересным дизайном, 20 штук желательно похожих или в двух расцветках.',
                        style: body14.copyWith(color: ColorResources.darkGray),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      productInfoWidget(
                          title: 'Товар: ',
                          value: 'Количество',
                          titleBold: true,
                          valueBold: true),
                      productInfoWidget(
                          title: 'Раскладные стулья', value: '20шт'),
                      productInfoWidget(title: 'Диваны', value: '20шт'),
                      productInfoWidget(title: 'Шкафы', value: '20шт'),
                      productInfoWidget(
                          title: 'Бюджет: ',
                          value: '50 000 сом',
                          valueBold: true),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Опубликовано: ',
                            style: body14.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '24.10.2024, 18:10',
                            style: body14.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
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
                        border:
                            Border.all(width: 1, color: ColorResources.lgColor),
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        leading: CustomImage(
                            image: '', height: 40, width: 40, radius: 40),
                        title: Text(
                          'Садовая мебель Loft',
                          style: h16.copyWith(color: ColorResources.darkGray),
                        ),
                        subtitle: Text(
                          'ОсОО...',
                          style:
                              body14.copyWith(color: ColorResources.darkGray),
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
                            'verified_supplier'.tr,
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
      bottomNavigationBar: "user" == "user"
          ? BottomAppBar(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: CustomBorderButton(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.all(0),
                      border: Border.all(width: 1, color: ColorResources.blue),
                      borderRadius: BorderRadius.circular(12),
                      boxShaow: const [ColorResources.shadow1],
                      child: Text(
                        "edit".tr,
                        style: button16.copyWith(color: ColorResources.blue),
                      ),
                      onTap: () {
                        Get.to(() => AddProductScreen(isEdit: true));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomBorderButton(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.all(0),
                      border: Border.all(width: 1, color: ColorResources.red),
                      borderRadius: BorderRadius.circular(12),
                      boxShaow: const [ColorResources.shadow1],
                      child: Text(
                        "not_active".tr,
                        style: button16.copyWith(color: ColorResources.red),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget productInfoWidget(
      {String? title,
      String? value,
      bool titleBold = false,
      bool valueBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        children: [
          Text(
            title ?? '',
            style: body14.copyWith(
              color: titleBold ? ColorResources.darkGray : ColorResources.gray,
              fontWeight: titleBold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: body14.copyWith(
                color:
                    titleBold ? ColorResources.darkGray : ColorResources.gray,
                fontWeight: valueBold ? FontWeight.w700 : FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
