import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/company/company_page_screen.dart';
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

import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_favorite_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isProduct;

  const ProductDetailScreen({super.key, this.isProduct = true});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
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
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, productDetialController) {
        if (productDetialController is ProductDetailLoader) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productDetialController is ProductDetailError) {
          return Center(
            child: Text(productDetialController.error),
          );
        }
        // ProductDetailModel productDetail = ProductDetailModel();
        if (productDetialController is! ProductDetailLoader &&
            productDetialController is! ProductDetailError) {
          if (productDetialController.productDetailModel?.data == null) {
            return SizedBox.shrink();
          }
          final productDetail = productDetialController.productDetailModel!;
          return SingleChildScrollView(
            child: Column(
              children: [
                // have to update the media list
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ProductImages(
                    image: const [],
                    isProductDetail: true,
                    productDetailImages: productDetail.data?.images ?? [],
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
                              productDetail.data?.name ?? '',
                              // 'Стул раскладной',
                              style:
                                  h24.copyWith(color: ColorResources.darkGray),
                            ),
                          ),
                          CustomFavoriteButton(
                            isFavorite: productDetail.data?.isFavorite ?? false,
                            onTap: () {
                              print('favorite button pressed......');

                              context
                                  .read<ProductDetailBloc>()
                                  .add(ToggleProductFavorite(context));
                              print(
                                  'this is value of favorite = ${productDetail.data!.isFavorite}');
                            },
                          ),
                        ],
                      ),
                      // if (isProduct) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        productDetail.data?.description ?? '',
                        // 'Раскладной садовый стул из шпона дерева.',
                        style: body16.copyWith(color: ColorResources.gray),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${productDetail.data?.price} ${AppConstants.currencyCode}',
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
                                formatDateInRu(
                                    productDetail.data?.createdAt.toString() ??
                                        ''),
                                // '12 окт. 2024',
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
                              '',
                              // '5 шт',
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
                              productDetail.data?.isAvailable == 1
                                  ? 'yes'.tr
                                  : 'no'.tr,
                              // 'Уточнять наличие',
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
                              decoration: BoxDecoration(
                                color:
                                    productDetialController.showProductReviews
                                        ? null
                                        : ColorResources.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'О товаре',
                                style: button16.copyWith(
                                    color: productDetialController
                                            .showProductReviews
                                        ? ColorResources.gray
                                        : ColorResources.white),
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
                              decoration: BoxDecoration(
                                color:
                                    !productDetialController.showProductReviews
                                        ? null
                                        : ColorResources.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'reviews'.tr,
                                style: button16.copyWith(
                                    color: !productDetialController
                                            .showProductReviews
                                        ? ColorResources.gray
                                        : ColorResources.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      if (productDetialController.showProductReviews) ...[
                        const ProductReviewsWidget(),
                      ] else ...[
                        const AboutProductWidget(),
                      ],
                      // ] else ...[
                      //   const SizedBox(
                      //     height: 15,
                      //   ),
                      //   Text(
                      //     'Описание',
                      //     style: h16.copyWith(color: ColorResources.darkGray),
                      //   ),
                      //   const SizedBox(
                      //     height: 10,
                      //   ),
                      //   Text(
                      //     'Ищу поставщиков садовой мебели, конкретно раскладных стульев хорошего качества, из натуральных материалов, с интересным дизайном, 20 штук желательно похожих или в двух расцветках.',
                      //     style:
                      //         body14.copyWith(color: ColorResources.darkGray),
                      //   ),
                      //   const SizedBox(
                      //     height: 20,
                      //   ),
                      //   productInfoWidget(
                      //       title: 'Товар: ',
                      //       value: 'Количество',
                      //       titleBold: true,
                      //       valueBold: true),
                      //   productInfoWidget(
                      //       title: 'Раскладные стулья', value: '20шт'),
                      //   productInfoWidget(title: 'Диваны', value: '20шт'),
                      //   productInfoWidget(title: 'Шкафы', value: '20шт'),
                      //   productInfoWidget(
                      //       title: 'Бюджет: ',
                      //       value: '50 000 сом',
                      //       valueBold: true),
                      //   const SizedBox(
                      //     height: 10,
                      //   ),
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Text(
                      //         'Опубликовано: ',
                      //         style:
                      //             body14.copyWith(fontWeight: FontWeight.w700),
                      //       ),
                      //       Text(
                      //         '24.10.2024, 18:10',
                      //         style:
                      //             body14.copyWith(fontWeight: FontWeight.w400),
                      //       ),
                      //     ],
                      //   ),
                      // ],
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (productDetail.data?.company != null) {
                      context.read<CompanyDetailBloc>().add(GetCompanyDetail(
                          productDetail.data!.company!.id.toString()));
                      Get.to(() => CompanyPageScreen());
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
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
                            border: Border.all(
                                width: 1, color: ColorResources.lgColor),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.all(0),
                            leading: CustomImage(
                                image: productDetail.data?.company?.logo ?? '',
                                height: 40,
                                width: 40,
                                radius: 40),
                            title: Text(
                              productDetail.data?.company?.name ?? "",
                              // 'Садовая мебель Loft',
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            subtitle: Text(
                              productDetail.data?.company?.owner?.name ?? '',
                              // 'ОсОО...',
                              style: body14.copyWith(
                                  color: ColorResources.darkGray),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (productDetail.data?.company?.verificationStatus ==
                            'verified')
                          Row(
                            children: [
                              SvgPicture.asset(Images.svgVerified),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'verified_supplier'.tr,
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
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
        }
        return const SizedBox.shrink();
      }),
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.productDetailModel?.data == null) {
            return SizedBox.shrink();
          }
          if (context.read<UserBloc>().state.userInfo?.data?.id !=
              state.productDetailModel?.data?.user?.id) {
            return SizedBox.shrink();
          }
          return BottomAppBar(
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
                    onTap: state.statusUpdating
                        ? () {}
                        : () {
                            context
                                .read<ProductDetailBloc>()
                                .add(ChangeProductStatus(
                                  state.productDetailModel!.data!.id.toString(),
                                  state.productDetailModel!.data!.status ==
                                          'published'
                                      ? 'draft'
                                      : 'published',
                                ));
                          },
                    child: state.statusUpdating
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator())
                        : Text(
                            state.productDetailModel!.data!.status ==
                                    'published'
                                ? "not_active".tr
                                : 'active'.tr,
                            style: button16.copyWith(color: ColorResources.red),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
