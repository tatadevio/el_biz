
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/product_grid_item.dart';
import 'package:el_biz/view/base/product_list_item.dart';
import 'package:el_biz/view/screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/company_detail/company_detail_bloc.dart';

class SelectCompanyProduct extends StatefulWidget {
  final bool isSelectProduct;
  final Function? onSendProduct;
  final List<int> selectedProducts;

  const SelectCompanyProduct(
      {super.key,
      this.isSelectProduct = false,
      this.onSendProduct,
      this.selectedProducts = const []});

  @override
  State<SelectCompanyProduct> createState() => _SelectCompanyProductState();
}

class _SelectCompanyProductState extends State<SelectCompanyProduct> {
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

  late PublicProductBloc publicBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    publicBloc = context.read<PublicProductBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    publicBloc.add(UpdateFilterEnable(false));
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
              GestureDetector(
                onTap: () {
                  Get.to(() => SearchScreen());
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
              // InkWell(
              //   onTap: () {
              //     Get.to(() => const AddProductScreen());
              //   },
              //   child: Container(
              //     height: 40,
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(
              //         12,
              //       ),
              //       color: ColorResources.green,
              //       boxShadow: const [
              //         BoxShadow(
              //           blurRadius: 2,
              //           spreadRadius: 0,
              //           offset: Offset(0, 1),
              //           color: Color.fromRGBO(16, 24, 40, 0.05),
              //         ),
              //       ],
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         SvgPicture.asset(
              //           Images.svgPlus,
              //         ),
              //         const SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           'Новый тендер',
              //           style: button16,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                        // BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
                        //     builder: (context, publicState) {
                        //   return InkWell(
                        //     borderRadius: BorderRadius.circular(12),
                        //     onTap: () {
                        //       if (productController.isShowCategories) {
                        //         Get.to(() => const CompanyFilterScreen());
                        //       } else {
                        //         context
                        //             .read<FilterFieldsBloc>()
                        //             .add(GetFilterFields());
                        //         Get.to(() => const ProductsFilterScreen());
                        //       }
                        //     },
                        //     child: Stack(
                        //       children: [
                        //         Container(
                        //           height: 40,
                        //           padding: const EdgeInsets.symmetric(
                        //               vertical: 8, horizontal: 14),
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(
                        //               12,
                        //             ),
                        //             color: ColorResources.green,
                        //             boxShadow: const [
                        //               BoxShadow(
                        //                 blurRadius: 2,
                        //                 spreadRadius: 0,
                        //                 offset: Offset(0, 1),
                        //                 color: Color.fromRGBO(16, 24, 40, 0.05),
                        //               ),
                        //             ],
                        //           ),
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               SvgPicture.asset(
                        //                 Images.filter,
                        //               ),
                        //               const SizedBox(
                        //                 width: 5,
                        //               ),
                        //               Text(
                        //                 'filter'.tr,
                        //                 style: button16,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         if (publicState.isFilterEnable)
                        //           Positioned(
                        //               top: 5,
                        //               right: 6,
                        //               child: CircleAvatar(
                        //                 radius: 3,
                        //                 backgroundColor: ColorResources.red,
                        //               ))
                        //       ],
                        //     ),
                        //   );
                        // }),
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
              return BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
                  builder: (context, publicState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
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
                                itemCount:
                                    publicState.companyProducts?.length ?? 0,
                                itemBuilder: (context, index) {
                                  // return SizedBox();
                                  return ProductGridItem(
                                    isSelectProduct: widget.isSelectProduct,
                                    product:
                                        publicState.companyProducts![index],
                                        isAlreadySelect: widget.selectedProducts.contains(publicState.companyProducts![index].id),
                                    // product: companyController.,
                                    // product: index,
                                  );
                                },
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    publicState.companyProducts?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return ProductListItemWidget(
                                    isSelectProduct: widget.isSelectProduct,
                                    product:
                                        publicState.companyProducts![index],
                                    // product: index,
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                );
              });
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
                  onTap: widget.onSendProduct!,
                  // () {
                  //   widget.onSendProduct;

                  // },
                  title: 'send'.tr))
          : null,
    );
  }
}
