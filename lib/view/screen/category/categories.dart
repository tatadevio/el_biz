import 'dart:math';

import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../../controller/product_controller.dart';
import '../../../data/model/response/category/category_model.dart';
import '../../../utils/Images.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/color_resources.dart';
import '../../base/no_data.dart';
import '../../base/product_shimmer.dart';
import '../filter/filter_category.dart';
import '../product/product_card.dart';
import '../search/search_screen.dart';

class Categories extends StatefulWidget {
  final String title;
  final String id;
  final bool fromFavSearch;
  final List<CategoriesItem> categoryItem;
  const Categories({Key? key, required this.title, required this.categoryItem, required this.id, this.fromFavSearch = false}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFollow = false;

  @override
  void initState() {
    super.initState();
    if (widget.fromFavSearch) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isFollow = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool _isLogin = Get.find<AuthController>().isLoggedIn();
    var height = Get.height;
    // var width = Get.width;
    return Scaffold(
      backgroundColor: ColorResources.background,
      extendBodyBehindAppBar: false,
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, productState) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).cardColor,
              leadingWidth: 25,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only()),
              title: Container(
                decoration: BoxDecoration(
                  color: ColorResources.background,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: height * 0.055,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextFormField(
                    onTap: () {
                      Get.to(() => const SearchScreen());
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "search".tr,
                        filled: true,
                        hintStyle: const TextStyle(color: ColorResources.greyLight),
                        fillColor: ColorResources.background,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(Images.svgSearch, color: ColorResources.greyLight),
                        )),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const FilterCategory(fromHome: false));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorResources.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Image.asset(
                          Images.filter,
                          color: ColorResources.white,
                          width: 30,
                        ),
                      ),
                    ),
                  ),

                  // Image.asset(
                  //   Images.filter,
                  //   color: ColorResources.white,
                  //   width: 30,
                  // ),
                ),
              ],
              centerTitle: false,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            if (widget.categoryItem.isNotEmpty)
              SliverPersistentHeader(
                delegate: SliverDelegate(
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: const BorderRadius.only(bottomRight: Radius.circular(24.0), bottomLeft: Radius.circular(24.0))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < widget.categoryItem.length; i++)
                                  InkWell(
                                    onTap: () {
                                      // productState.getProductWithCat(widget.categoryItem[i].id.toString(), widget.categoryItem[i].name);
                                      context.read<ProductBloc>().add(GetProductWithCat(widget.categoryItem[i].id.toString(), widget.categoryItem[i].name));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: widget.categoryItem[i].id.toString() == productState.selectedSubCatId ? ColorResources.primary : Colors.white,
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(color: ColorResources.hintColor.withOpacity(0.7))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.categoryItem[i].name,
                                            style: TextStyle(fontSize: 18, color: widget.categoryItem[i].id.toString() == productState.selectedSubCatId ? Colors.white : ColorResources.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            SliverToBoxAdapter(
                child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: !productState.isCatLoading
                  ? [
                      productState.catProductItem.isNotEmpty
                          ? BlocBuilder<ProductBloc, ProductState>(builder: (context, productState) {
                              return ProductCard(
                                isFavorite: false,
                                isEdit: "",
                                productItem: productState.catProductItem,
                              );
                            })
                          : NoDataWidget(
                              image: "",
                              title: "empty_title".tr,
                              description: "empty_desc".tr,
                              btnTxt: "to_main".tr,
                              imageWidget: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xffF2F4F7), border: Border.all(color: const Color(0xffF9FAFB), width: 7.2)),
                                child: SvgPicture.asset(
                                  Images.svgSearch,
                                  color: ColorResources.primary,
                                ),
                              ),
                              onTap: () {
                                Get.back();
                              },
                            ),
                      if (productState.catProductItem.isNotEmpty && context.read<AuthBloc>().state.isLoggedIn)
                        Positioned(
                          top: 40,
                          child: InkWell(
                            onTap: () {
                              print("${AppConstants.productWithCatId}${widget.id}");

                              setState(() {
                                isFollow = !isFollow;
                              });

                              // if (isFollow) {
                              //   Get.find<FavoriteController>().saveSearch(widget.title, productState.currentQuery, "1");
                              // } else {
                              //   Get.find<FavoriteController>().deleteSearch(widget.title);
                              // }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: !isFollow ? Colors.white : ColorResources.primary,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: ColorResources.primary,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isFollow
                                    ? Row(
                                        children: [
                                          SvgPicture.asset(
                                            Images.svgHeart,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "unfollow_this_search".tr,
                                            style: const TextStyle(color: Colors.white, fontSize: 18),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite,
                                            color: ColorResources.primary,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            "follow_this_search".tr,
                                            style: const TextStyle(color: ColorResources.primary, fontSize: 18),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                    ]
                  : [ProductWidgetShimmer()],
            )),
          ],
        );
      }),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 80 || oldDelegate.minExtent != 80 || child != oldDelegate.child;
  }
}
