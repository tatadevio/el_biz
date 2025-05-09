import 'package:el_biz/bloc/filter_fields/filter_fields_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/product_grid_item.dart';
import 'package:el_biz/view/base/product_list_item.dart';
import 'package:el_biz/view/screen/filter/company_filter/company_filter_screen.dart';
import 'package:el_biz/view/screen/filter/products_filter/products_filter_screen.dart';
import 'package:el_biz/view/screen/products/widgets/public_companies_widget.dart';
import 'package:el_biz/view/screen/products/widgets/public_products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../product/add_product_screen.dart';

class ProductScreen extends StatefulWidget {
  final bool isSelectProduct;
  const ProductScreen({super.key, this.isSelectProduct = false});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'products'.tr,
                  style: h16.copyWith(color: ColorResources.blackText),
                ),
              ),
              Container(
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
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const AddProductScreen());
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
                        'Новый тендер',
                        style: button16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, productController) {
              return Column(
                children: [
                  const Divider(
                    height: 3,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (productController.isShowCategories) {
                              Get.to(() => const CompanyFilterScreen());
                            } else {
                              context.read<FilterFieldsBloc>().add(GetFilterFields());
                              Get.to(() => const ProductsFilterScreen());
                            }
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
                                  color: Color.fromRGBO(16, 24, 40, 0.05),
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
                        //
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              border: Border.all(
                                  width: 1, color: ColorResources.lgColor),
                              color: ColorResources.lightBlue,
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
                                  Images.svgArrowUpDown,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'new'.tr,
                                  style: body14.copyWith(
                                      color: ColorResources.gray),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (!productController.isShowCategories) ...[
                          const SizedBox(width: 10),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // productController.updateGridView(true);

                              context
                                  .read<ProductBloc>()
                                  .add(const UpdateGridView(true));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: productController.isGridView
                                    ? ColorResources.primary
                                    : null,
                                border: Border.all(
                                  width: 1,
                                  color: productController.isGridView
                                      ? ColorResources.primary
                                      : ColorResources.lgColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                Images.svgCategory,
                                color: productController.isGridView
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
                              // productController.updateGridView(false);
                              context
                                  .read<ProductBloc>()
                                  .add(const UpdateGridView(false));
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: productController.isGridView
                                    ? null
                                    : ColorResources.primary,
                                border: Border.all(
                                  width: 1,
                                  color: !productController.isGridView
                                      ? ColorResources.primary
                                      : ColorResources.lgColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                Images.svgList,
                                color: !productController.isGridView
                                    ? ColorResources.white
                                    : ColorResources.gray,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            }),
          )),
      body: Stack(
        children: [
          BlocBuilder<CompanyBloc, CompanyState>(
              builder: (context, companyController) {
            return BlocBuilder<ProductBloc, ProductState>(
                builder: (context, productController) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (!widget.isSelectProduct)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                // productController.updateShowCategories(true);
                                context
                                    .read<ProductBloc>()
                                    .add(const UpdateShowCategories(true));
                              },
                              child: Container(
                                height: 40,
                                width: width * 0.42,
                                decoration: BoxDecoration(
                                    color: !productController.isShowCategories
                                        ? null
                                        : ColorResources.primary,
                                    border: Border.all(
                                      width: 1,
                                      color: productController.isGridView
                                          ? ColorResources.primary
                                          : ColorResources.lgColor,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow:
                                        !productController.isShowCategories
                                            ? []
                                            : [
                                                const BoxShadow(
                                                  blurRadius: 3,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.1),
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
                                  'companies'.tr,
                                  style: button16.copyWith(
                                      color: !productController.isShowCategories
                                          ? ColorResources.gray
                                          : Colors.white),
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                // productController.updateShowCategories(false);
                                context
                                    .read<ProductBloc>()
                                    .add(const UpdateShowCategories(false));
                              },
                              child: Container(
                                height: 40,
                                width: width * 0.42,
                                decoration: BoxDecoration(
                                    color: productController.isShowCategories
                                        ? null
                                        : ColorResources.primary,
                                    border: Border.all(
                                      width: 1,
                                      color: !productController.isGridView
                                          ? ColorResources.primary
                                          : ColorResources.lgColor,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow:
                                        productController.isShowCategories
                                            ? []
                                            : [
                                                const BoxShadow(
                                                  blurRadius: 3,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.1),
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
                                  'goods'.tr,
                                  style: button16.copyWith(
                                      color: productController.isShowCategories
                                          ? ColorResources.gray
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.isSelectProduct)
                      Expanded(
                        child: productController.isGridView
                            ? GridView.builder(
                                controller: _scrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.7),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ProductGridItem(
                                    isSelectProduct: widget.isSelectProduct,
                                    // product: index,
                                  );
                                },
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ProductListItemWidget(
                                    isSelectProduct: widget.isSelectProduct,
                                    // product: index,
                                  );
                                },
                              ),
                      )
                    else
                      Expanded(
                        child: !productController.isShowCategories
                            ? PublicProductsWidget()
                            : PublicCompaniesWidget(),
                        // const SizedBox(),
                      ),
                  ],
                ),
              );
            });
          }),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResources.primary,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: widget.isSelectProduct
          ? BottomAppBar(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: CustomButton(
                  width: width,
                  height: Get.height,
                  onTap: () {
                    Get.back();
                    context.read<ProductBloc>().add(ClearSelectedProduct());
                  },
                  title: 'send'.tr))
          : null,
    );
  }
}
