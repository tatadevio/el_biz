import 'package:el_biz/bloc/auction/auctions/auctions_bloc.dart';

import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/screen/auction/auctions/widgets/active_auctions_widget.dart';
import 'package:el_biz/view/screen/auction/auctions/widgets/my_auctions_widget.dart';
import 'package:el_biz/view/screen/my_products/my_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../bloc/product/product_bloc.dart';
import '../../../../data/model/response/company/company_product_model.dart';
import '../../product/add_product_screen.dart';
import '../auction_filter/auction_filter_screen.dart';
import '../new_auction/new_auction_screen.dart';
import '../search_auction/search_auction_screen.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> {
  // void _callScrolling(BuildContext context, ScrollController scrollController) {

  // }

  bool isActiveAuctions = true;

  String activeSortOrder = "desc";
  String activeOrderBy = "created_at";

  @override
  Widget build(BuildContext context) {
    // _callScrolling(context, _scrollController);
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'auctions'.tr,
                    style: h16.copyWith(color: ColorResources.blackText),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SearchAuctionScreen());
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorResources.lgColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(Images.svgSearch),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 4,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: ColorResources.gray
                                            .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              'new_auction'.tr,
                              style:
                                  h16.copyWith(color: ColorResources.darkGray),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: SvgPicture.asset(Images.svgBag),
                              onTap: () {
                                // context
                                //         .read<ProductBloc>()
                                //         .add(const UpdateShowCategories(false));
                                // clearSelectedProduct();
                                // UserData? myUser = context
                                //     .read<UserBloc>()
                                //     .state
                                //     .userInfo
                                //     ?.data;
                                Get.back();
                                Get.to(
                                  () => MyProductsScreen(
                                    isSelectProduct: true,
                                    onSendProduct: () async {
                                      ProductListItem? selectedProduct = context
                                          .read<ProductBloc>()
                                          .state
                                          .selectedProduct;

                                      Get.back();
                                      // send isProduct message...
                                      if (selectedProduct != null) {
                                        Get.to(() => NewAuctionScreen(
                                            selectedProduct: selectedProduct));
                                      }
                                    },
                                  ),
                                );
                              },
                              title: Text(
                                'select_from_your_products'.tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                'post_existing_products'.tr,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            Divider(
                              color: ColorResources.gray.withOpacity(0.4),
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: SvgPicture.asset(Images.svgPlus1),
                              onTap: () {
                                Get.back();
                                Get.to(() => const AddProductScreen(
                                      isAuction: true,
                                    ));
                              },
                              title: Text(
                                'create_new'.tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                'create_auction_with_new_product'.tr,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                    );
                    // Get.to(() => SelectCategoryScreen(
                    //       onSelect: (selectedCategories) {
                    //         for (var category in selectedCategories) {
                    //           print(
                    //               'these are the selected categoris : ${category.toJson()}');
                    //         }
                    //         context
                    //             .read<TendersBloc>()
                    //             .state
                    //             .newTenderModel
                    //             .categories = selectedCategories;
                    //         Get.to(() => NewTende2Screen());
                    //       },
                    //     ));
                  },
                  child: Container(
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: ColorResources.green,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1),
                          color: Color.fromRGBO(16, 24, 40, 0.05),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Images.svgPlus,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'new_auction'.tr,
                          style: button16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(95),
              child: BlocBuilder<AuctionsBloc, AuctionsState>(
                  builder: (context, auctionsController) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          if (isActiveAuctions)
                            BlocBuilder<AuctionsBloc, AuctionsState>(
                                builder: (context, tenderState) {
                              return Stack(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      // context
                                      //     .read<FilterFieldsBloc>()
                                      //     .add(GetFilterFields());
                                      Get.to(() => AuctionFilterScreen());
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                        color: ColorResources.green,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color: Color.fromRGBO(
                                                16, 24, 40, 0.05),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            Images.filter,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'filter'.tr,
                                            style: button16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (tenderState.isFilterEnable)
                                    Positioned(
                                      top: 5,
                                      right: 6,
                                      child: CircleAvatar(
                                        radius: 3,
                                        backgroundColor: ColorResources.red,
                                      ),
                                    ),
                                ],
                              );
                            }),
                          //
                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: (isActiveAuctions)
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        activeSortOrder =
                                            activeSortOrder == "asc"
                                                ? "desc"
                                                : "asc";
                                      });
                                      context
                                          .read<AuctionsBloc>()
                                          .add(GetAuctions(
                                            page: 1,
                                            isRefresh: true,
                                            direction: activeSortOrder,
                                            orderBy: activeOrderBy,
                                          ));
                                    },
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12,
                                        ),
                                        border: Border.all(
                                            width: 1,
                                            color: ColorResources.lgColor),
                                        color: ColorResources.lightBlue,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color: Color.fromRGBO(
                                                16, 24, 40, 0.05),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            Images.svgArrowUpDown,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            activeSortOrder == 'asc'
                                                ? 'old'.tr
                                                : 'new'.tr,
                                            style: body14.copyWith(
                                                color: ColorResources.gray),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context
                                  .read<AuctionsBloc>()
                                  .add(const UpdateAuctionGridView(true));
                              // tendersController.updateGridView(true);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: auctionsController.isGridView
                                    ? ColorResources.primary
                                    : null,
                                border: Border.all(
                                  width: 1,
                                  color: auctionsController.isGridView
                                      ? ColorResources.primary
                                      : ColorResources.lgColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                Images.svgCategory,
                                color: auctionsController.isGridView
                                    ? ColorResources.white
                                    : ColorResources.gray,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context
                                  .read<AuctionsBloc>()
                                  .add(const UpdateAuctionGridView(false));
                              // auctionsController.updateGridView(false);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: auctionsController.isGridView
                                    ? null
                                    : ColorResources.primary,
                                border: Border.all(
                                  width: 1,
                                  color: !auctionsController.isGridView
                                      ? ColorResources.primary
                                      : ColorResources.lgColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                Images.svgList,
                                color: !auctionsController.isGridView
                                    ? ColorResources.white
                                    : ColorResources.gray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(child: Container()),
                    //   ],
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // productController.updateShowCategories(true);
                              // context
                              //     .read<ProductBloc>()
                              //     .add(const UpdateShowCategories(true));
                              setState(() {
                                isActiveAuctions = true;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: width * 0.46,
                              decoration: BoxDecoration(
                                  color: !isActiveAuctions
                                      ? null
                                      : ColorResources.primary,
                                  border: Border.all(
                                    width: 1,
                                    // color: productController.isGridView
                                    //     ? ColorResources.primary
                                    //     : ColorResources.lgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: !isActiveAuctions
                                      ? []
                                      : [
                                          const BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color:
                                                Color.fromRGBO(16, 24, 40, 0.1),
                                          ),
                                          const BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color: Color.fromRGBO(
                                                16, 24, 40, 0.06),
                                          ),
                                        ]),
                              alignment: Alignment.center,
                              child: Text(
                                'active_auctions'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: button16.copyWith(
                                    color: !isActiveAuctions
                                        ? ColorResources.gray
                                        : Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // productController.updateShowCategories(false);
                              // context
                              //     .read<ProductBloc>()
                              //     .add(const UpdateShowCategories(false));
                              setState(() {
                                isActiveAuctions = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: width * 0.46,
                              decoration: BoxDecoration(
                                  color: isActiveAuctions
                                      ? null
                                      : ColorResources.primary,
                                  border: Border.all(
                                    width: 1,
                                    // color: !productController.isGridView
                                    //     ? ColorResources.primary
                                    //     : ColorResources.lgColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: isActiveAuctions
                                      ? []
                                      : [
                                          const BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color:
                                                Color.fromRGBO(16, 24, 40, 0.1),
                                          ),
                                          const BoxShadow(
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1),
                                            color: Color.fromRGBO(
                                                16, 24, 40, 0.06),
                                          ),
                                        ]),
                              alignment: Alignment.center,
                              child: Text(
                                'my_auctions'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: button16.copyWith(
                                    color: isActiveAuctions
                                        ? ColorResources.gray
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            )),
        body: isActiveAuctions ? ActiveAuctionsWidget() : MyAuctionsWidget());
  }
}
