import 'package:el_biz/bloc/company_detail/company_detail_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/helper/date_helper.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/chat_conversation.dart';
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

import '../../../bloc/similar_companies/similar_companies_bloc.dart';
import '../../../data/model/response/chat/chat_list_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/color_resources.dart';
import '../../base/custom_favorite_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isProduct;
  // final bool isCompanyProduct; // for active or inative list update

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
                              // print(
                              //     'this is value of favorite = ${productDetail.data!.isFavorite}');
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
                                  '${productDetail.data?.reviewAvgRating} ',
                                  // '(4.0) ',
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                                RatingBar.builder(
                                  initialRating:
                                      productDetail.data?.reviewAvgRating ?? 0,
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
                                // 'О товаре',
                                "about_product".tr,
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
                        ProductReviewsWidget(
                          isReview: productDetail.data?.isReview ?? false,
                          contractId:
                              productDetail.data?.contractId.toString() ?? '',
                        ),
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
                      context.read<SimilarCompaniesBloc>().add(
                          GetSimilarCompanies(
                              companyId:
                                  productDetail.data!.company!.id.toString(),
                              currentPage: 1));
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
          // if (context.read<UserBloc>().state.userInfo?.data?.id !=
          //     state.productDetailModel?.data?.user?.id) {
          //   return SizedBox.shrink();
          // }
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if ((userState.selectedAccountModel!.isUser == true &&
                      state.productDetailModel?.data?.user?.id ==
                          userState.selectedAccountModel!.userId) ||
                  (userState.selectedAccountModel!.isUser == false &&
                      userState.selectedAccountModel!.companyId ==
                          state.productDetailModel?.data?.company?.id)) {
                return BottomAppBar(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomBorderButton(
                          height: Get.height,
                          width: Get.width,
                          padding: const EdgeInsets.all(0),
                          border:
                              Border.all(width: 1, color: ColorResources.blue),
                          borderRadius: BorderRadius.circular(12),
                          boxShaow: const [ColorResources.shadow1],
                          child: Text(
                            "edit".tr,
                            style:
                                button16.copyWith(color: ColorResources.blue),
                          ),
                          onTap: () {
                            Get.to(() => AddProductScreen(isEdit: true,));
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
                          border:
                              Border.all(width: 1, color: ColorResources.red),
                          borderRadius: BorderRadius.circular(12),
                          boxShaow: const [ColorResources.shadow1],
                          onTap: state.statusUpdating
                              ? () {}
                              : () {
                                  context.read<ProductDetailBloc>().add(
                                        ChangeProductStatus(
                                          state.productDetailModel!.data!.id
                                              .toString(),
                                          state.productDetailModel!.data!
                                                      .status ==
                                                  'published'
                                              ? 'draft'
                                              : 'published',
                                          context,
                                        ),
                                      );
                                },
                          child: state.statusUpdating
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator())
                              : Text(
                                  state.productDetailModel!.data!.status ==
                                          'published'
                                      ? "inactive".tr
                                      : 'active'.tr,
                                  style: button16.copyWith(
                                      color: ColorResources.red),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if ((userState.selectedAccountModel!.isUser == true &&
                      state.productDetailModel?.data?.user?.id !=
                          userState.selectedAccountModel!.userId) ||
                  (userState.selectedAccountModel!.isUser == false &&
                      userState.selectedAccountModel!.companyId !=
                          state.productDetailModel?.data?.company?.id)) {
                return BottomAppBar(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: state.productDetailModel?.data?.user?.id == null
                      ? SizedBox.shrink()
                      : CustomButton(
                          width: width,
                          height: 56,
                          onTap: () {
                            // String productUserId = state
                            //     .productDetailModel!.data!.user!.id
                            //     .toString();
                            String myUserId = userState
                                .selectedAccountModel!.userId
                                .toString();
                            print('this is my user id = $myUserId ');
                            final myUser = userState.userInfo?.data;
                            final chatItem = ChatItem(
                              chatId: 0,
                              // int.parse(getChatId(userState, state)),
                              firebaseChatId:
                                  "product_${state.productDetailModel?.data?.id}_user_$myUserId",
                              type: 'product',
                              product: ProductListItem(
                                id: state.productDetailModel?.data?.id,
                                name: state.productDetailModel?.data?.name,
                                price: state.productDetailModel?.data?.price,
                                description:
                                    state.productDetailModel?.data?.description,
                                slug: state.productDetailModel?.data?.slug,
                                quantity:
                                    state.productDetailModel?.data?.quantity,
                                image: state.productDetailModel?.data?.images
                                            ?.isNotEmpty ==
                                        true
                                    ? state.productDetailModel?.data?.images![0]
                                        .thumb
                                    : '',
                                isFavorite: state
                                        .productDetailModel?.data?.isFavorite ??
                                    false,
                                user: state.productDetailModel?.data?.user,
                              ),
                              tender: TenderItem(),
                              user: User(
                                id: myUser?.id,
                                name: myUser?.name,
                                image: myUser?.image,
                                phone: myUser?.phone,
                                email:
                                    state.productDetailModel?.data?.user?.email,
                                fcmToken: myUser?.fcmToken,
                              ),
                              company: state.productDetailModel?.data?.company,
                              lastMessage: state.productDetailModel?.data?.name,
                              lastMessageDate:
                                  state.productDetailModel?.data?.createdAt,
                              userUnreadCount: 0,
                              productOwnerUnreadCount: 0,
                              createdAt:
                                  state.productDetailModel?.data?.createdAt,
                            );
                            Get.to(() => ChatConversation(
                                  chatItem: chatItem,
                                  isFirstMessage: true,
                                  // isSeller: false,

                                  // product: ProductListItem(
                                  //   id: state.productDetailModel?.data?.id,
                                  //   name: state.productDetailModel?.data?.name,
                                  //   price:
                                  //       state.productDetailModel?.data?.price,
                                  //   description: state
                                  //       .productDetailModel?.data?.description,
                                  //   slug: state.productDetailModel?.data?.slug,
                                  //   quantity: state
                                  //       .productDetailModel?.data?.quantity,
                                  //   image: state.productDetailModel?.data
                                  //               ?.images?.isNotEmpty ==
                                  //           true
                                  //       ? state.productDetailModel?.data
                                  //           ?.images![0].thumb
                                  //       : '',
                                  //   isFavorite: state.productDetailModel?.data
                                  //           ?.isFavorite ??
                                  //       false,
                                  //   user: state.productDetailModel?.data?.user,
                                  // ),
                                  // receiverId: productUserId,
                                  // // getReceiverId(userState, state),
                                  // senderId: myUserId,
                                  // isFirstMessage: true,
                                  // // productId: state.productDetailModel?.data?.id
                                  // //         .toString() ??
                                  // //     '',
                                  // firebaseChatId:
                                  //     "product_${state.productDetailModel?.data?.id}_user_$myUserId",
                                  // productName:
                                  //     state.productDetailModel?.data?.name ??
                                  //         '',
                                  // productId: state.productDetailModel?.data?.id
                                  //         .toString() ??
                                  //     '',
                                  // productPrice: state
                                  //         .productDetailModel?.data?.price
                                  //         .toString() ??
                                  //     '0',
                                  // productUserId: state
                                  //         .productDetailModel?.data?.user?.id ??
                                  //     0,
                                  // companyId: state.productDetailModel?.data
                                  //         ?.company?.id ??
                                  //     0,
                                ));
                          },
                          title: 'Чат с продавцом'),
                );
// chat option
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  // String getReceiverId(UserState userState, ProductDetailState state) {
  //   if (userState.selectedAccountModel!.isUser == true) {
  //     return state.productDetailModel?.data?.user?.id.toString() ?? '';
  //   } else if (userState.selectedAccountModel!.isUser == false) {
  //     return state.productDetailModel?.data?.company?.id.toString() ?? '';
  //   }
  //   return '';
  // }

  String getChatId(UserState userState, ProductDetailState state) {
    if (userState.selectedAccountModel!.isUser == true) {
      return "${state.productDetailModel?.data?.id}-${state.productDetailModel?.data?.user?.id}";
    } else if (userState.selectedAccountModel!.isUser == false) {
      return "${state.productDetailModel?.data?.id}-${state.productDetailModel?.data?.company?.id}";
    }
    return '';
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
