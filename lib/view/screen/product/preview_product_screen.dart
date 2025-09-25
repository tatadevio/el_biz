import 'dart:developer';

import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/view/base/custom_toast.dart';
import 'package:el_biz/view/screen/dashboard/dashboard.dart';
import 'package:el_biz/view/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../bloc/add_product/add_product_bloc.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/custom_button.dart';
import '../../base/custom_image.dart';
import '../auction/new_auction/new_auction_screen.dart';
import './widgets/add_product_images_preview.dart';

class PreviewProductScreen extends StatefulWidget {
  // final List<Map<String, dynamic>> selectedMaterial;
  // final AddProductModel productData;
  final bool isEdit;
  final bool isAuction;
  // final String productFrom;
  const PreviewProductScreen({
    super.key,
    // required this.selectedMaterial,
    // required this.productData,
    required this.isEdit,
    required this.isAuction,
    // required this.productFrom,
  });

  @override
  State<PreviewProductScreen> createState() => _PreviewProductScreenState();
}

class _PreviewProductScreenState extends State<PreviewProductScreen> {
  bool _isShowDescription = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            if (widget.isAuction) {
              Get.until((route) =>
                  route.settings.name == '/AuctionsScreen' ||
                  route.settings.name == '/DashboardScreen');
              Get.to(
                  () => NewAuctionScreen(selectedProduct: state.productItem!));
            } else {
              HomeScreen().loadData(context);
              Get.offAll(() => const DashboardScreen());
              context.read<ProductBloc>().add(EmptyPickedLogo());
            }
          } else if (state is AddProductFailure) {
            showCustomSnackBar(state.message);
          }
        },
        child: BlocBuilder<AddProductBloc, AddProductState>(
          builder: (context, state) {
            if (state is AddProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productData == null) {
              return const SizedBox();
            }
            final productData = state.productData;
            if (productData == null) {
              return const Center(
                child: Text('No product data available'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (productData.productImages?.isNotEmpty ?? false)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: AddProductImagesPreview(
                        productData: productData,
                      ),
                    ),
                  if (productData.productUploadedImages != null &&
                      productData.productUploadedImages!.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: productData.productUploadedImages!
                            .map(
                              (image) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomImage(
                                    image: image.small ?? '',
                                    height: 80,
                                    width: 70,
                                    radius: 10),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  Container(
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                productData.productName ?? '',
                                // 'Стул раскладной',
                                style: h24.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                            ),
                            // Container(
                            //   height: 40,
                            //   width: 40,
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     border: Border.all(
                            //         width: 1, color: ColorResources.lgColor),
                            //     borderRadius: BorderRadius.circular(12),
                            //     boxShadow: const [
                            //       BoxShadow(
                            //         blurRadius: 2,
                            //         spreadRadius: 0,
                            //         offset: Offset(0, 1),
                            //         color: Color.fromRGBO(16, 24, 40, 0.05),
                            //       ),
                            //     ],
                            //   ),
                            //   alignment: Alignment.center,
                            //   child: SvgPicture.asset(Images.svgHeartBorder),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          productData.brandName ?? '',
                          // 'Раскладной садовый стул из шпона дерева.',
                          style: body16.copyWith(color: ColorResources.gray),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${productData.price} ${AppConstants.currencyCode}",
                          // '2 500 сом',
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
                                    '(0) ',
                                    style: body14.copyWith(
                                        color: ColorResources.gray),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 14,
                                    ignoreGestures: true,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0),
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
                                  'uploaded'.tr,
                                  style: body14.copyWith(
                                      color: ColorResources.gray,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '12 окт. 2024',
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
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
                                'minimum_order'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              Text(
                                "${productData.quantity} ${productData.quantityUnit}",
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
                                'availability'.tr,
                                style: h16.copyWith(
                                    color: ColorResources.darkGray),
                              ),
                              const SizedBox(width: 8),
                              _getAvailabilityIcon(productData.availability),
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
                                setState(() {
                                  _isShowDescription = true;
                                });
                                // productDetialController.toggleShowProductReview(false);
                              },
                              child: Container(
                                height: 40,
                                width: width * 0.43,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: !_isShowDescription
                                      ? null
                                      : ColorResources.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'about_the_product'.tr,
                                  style: button16.copyWith(
                                      color: !_isShowDescription
                                          ? ColorResources.gray
                                          : ColorResources.white),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                setState(() {
                                  _isShowDescription = false;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: width * 0.45,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _isShowDescription
                                      ? null
                                      : ColorResources.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'reviews'.tr,
                                  style: button16.copyWith(
                                      color: _isShowDescription
                                          ? ColorResources.gray
                                          : ColorResources.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        if (_isShowDescription) ...[
                          Text(
                            productData.description ?? '',
                            style: body14,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'characteristics'.tr,
                            style: h16.copyWith(color: ColorResources.darkGray),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (context
                                  .read<AddProductBloc>()
                                  .state
                                  .productData
                                  ?.material !=
                              null)
                            characteristicsItem(
                                title: 'Материал',
                                value: context
                                        .read<AddProductBloc>()
                                        .state
                                        .productData
                                        ?.material!
                                        .name ??
                                    ''
                                //  materialItemsToString(
                                //   [

                                //   ],
                                // ),
                                ),
                          const Divider(),
                          characteristicsItem(
                              title: 'Средний вес',
                              value:
                                  "${productData.weight} ${productData.weightUnit}"),
                          const Divider(),
                          characteristicsItem(
                              title: 'Размеры',
                              value: "${productData.dimensions}"),
                        ],
                        // if (!_isShowDescription) ...[
                        //   ProductReviewsWidget(),
                        // ] else ...[
                        //   AboutProductWidget(),
                        // ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: BlocBuilder<AddProductBloc, AddProductState>(
            builder: (context, state) {
          if (state is AddProductLoading) {
            return CustomButtonLoader(width: Get.width, height: Get.height);
          }
          return CustomButton(
              width: Get.width,
              height: Get.height,
              onTap: () {
                final currentProductData =
                    context.read<AddProductBloc>().state.productData;
                if (currentProductData == null) {
                  showCustomSnackBar('Product data is not available');
                  return;
                }

                if (widget.isEdit) {
                  final productDetailState =
                      context.read<ProductDetailBloc>().state;
                  final productId =
                      productDetailState.productDetailModel?.data?.id;
                  if (productId == null) {
                    showCustomSnackBar('Product ID is not available');
                    return;
                  }

                  log('this is product data $currentProductData');
                  context.read<AddProductBloc>().add(
                      UpdateProduct(currentProductData, productId.toString()));
                } else {
                  log('this is product data $currentProductData');
                  context.read<AddProductBloc>().add(AddProduct(
                      addProductModel: currentProductData,
                      productFrom: widget.isAuction ? 'auction' : 'normal'));
                }
              },
              title: 'save'.tr);
        }),
      ),
    );
  }

  String materialItemsToString(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return '';
    }
    String value = "";
    for (int i = 0; i < items.length; i++) {
      if (i < items.length - 1) {
        value = "$value ${items[i]['title']}, ";
      } else {
        value = "$value ${items[i]['title']}";
      }
    }

    return value;
  }

  Widget characteristicsItem({String title = '', String value = ''}) {
    if (value == '') {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          Expanded(
            child: Text(
              value,
              style: body16.copyWith(color: ColorResources.gray),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAvailabilityIcon(String? availability) {
    if (availability == '1') {
      // Available - show green check
      return Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      );
    } else {
      // Not available (0 or null) - show red cross
      return Icon(
        Icons.cancel,
        color: Colors.red,
        size: 20,
      );
    }
  }
}
