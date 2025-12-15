import 'package:el_biz/bloc/filter_fields/filter_fields_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_button.dart';
import 'package:el_biz/view/base/custom_dialog.dart';
import 'package:el_biz/view/base/product_grid_item.dart';
import 'package:el_biz/view/base/product_list_item.dart';
import 'package:el_biz/view/screen/filter/company_filter/company_filter_screen.dart';
import 'package:el_biz/view/screen/filter/products_filter/products_filter_screen.dart';
import 'package:el_biz/view/screen/product/import_product_screen.dart';
import 'package:el_biz/view/screen/product/product_import_screen.dart';
import 'package:el_biz/view/screen/products/widgets/public_companies_widget.dart';
import 'package:el_biz/view/screen/products/widgets/public_products_widget.dart';
import 'package:el_biz/view/screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../bloc/company/company_bloc.dart';
import '../../../bloc/search/search_bloc.dart' as search;
import '../product/add_product_screen.dart';

class ProductScreen extends StatefulWidget {
  final bool isSelectProduct;
  final Function? onSendProduct;
  final List<int> selectedProducts;

  const ProductScreen(
      {super.key,
      this.isSelectProduct = false,
      this.onSendProduct,
      this.selectedProducts = const []});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;
  String productDirection = 'asc';
  String productOrderBy = 'created_at';
  String companyOrderBy = 'created_at';
  String companyDirection = 'asc';

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

      final publicProductBloc = context.read<PublicProductBloc>();

      // isShowcategories mean showCompanies
      if (Get.find<PublicProductBloc>().state.isFilterEnable) {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            !publicProductBloc.state.isLoading &&
            !publicProductBloc.state.isMoreLoading) {
          print('filter product scroll.......');
          int pageSize = publicProductBloc.state.filterPageSize;
          if (publicProductBloc.state.filterCurrentPage < pageSize) {
            int nextPage = publicProductBloc.state.filterCurrentPage;

            publicProductBloc.add(FilterPublicProduct(
                productFilterValuesModel: Get.find<PublicProductBloc>()
                    .state
                    .productFilterValuesModel!,
                currentPage: nextPage + 1));
          }
        }
      } else {
        if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 300 &&
            !publicProductBloc.state.isLoading &&
            !publicProductBloc.state.isMoreLoading) {
          print('all product scroll.......');
          int pageSize = publicProductBloc.state.pageSize;
          if (publicProductBloc.state.currentPage < pageSize) {
            int nextPage = publicProductBloc.state.currentPage;

            publicProductBloc.add(GetPublicProduct(nextPage + 1));
          }
        }
      }
    });
  }

  late PublicProductBloc publicBloc;
  late PublicCompanyBloc publicCompanyBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    publicBloc = context.read<PublicProductBloc>();
    publicCompanyBloc = context.read<PublicCompanyBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    publicBloc.add(UpdateFilterEnable(false));
    publicCompanyBloc.add(UpdateCompanyFilterEnable(false));
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required StateSetter setState,
    required String title,
    required String value,
    required String orderBy,
    required String direction,
    required String currentOrderBy,
    required String currentDirection,
    bool isCompany = false,
  }) {
    final bool isSelected =
        (orderBy == currentOrderBy && direction == currentDirection);
    return RadioListTile<String>(
      value: value,
      groupValue: isSelected ? value : null,
      onChanged: (_) {
        setState(() {
          if (isCompany) {
            companyOrderBy = orderBy;
            companyDirection = direction;
          } else {
            productOrderBy = orderBy;
            productDirection = direction;
          }
        });
        if (isCompany) {
          context.read<PublicCompanyBloc>().add(
                GetPublicCompany(1,
                    orderBy: companyOrderBy, direction: companyDirection),
              );
        } else {
          context.read<PublicProductBloc>().add(
                GetPublicProduct(1, orderBy: orderBy, direction: direction),
              );
        }
        Navigator.pop(context);
      },
      title: Row(
        children: [
          SvgPicture.asset(Images.svgArrowUpDown),
          const SizedBox(width: 12),
          Text(title, style: body14),
        ],
      ),
      activeColor: ColorResources.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    // double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productController) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    productController.isShowCategories
                        ? 'Каталог'
                        : 'products'.tr,
                    style: h16.copyWith(color: ColorResources.blackText),
                  ),
                ),
                if (!widget.isSelectProduct)
                  GestureDetector(
                    onTap: () {
                      if (productController.isShowCategories) {
                        context
                            .read<search.SearchBloc>()
                            .add(search.ChangeStatusSearch(false));
                      } else {
                        context
                            .read<search.SearchBloc>()
                            .add(search.ChangeStatusSearch(true));
                      }
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
                if (!productController.isShowCategories) ...[
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(AlertDialog(
                        titlePadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Expanded(child: Text('New Product')),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              // contentPadding: const EdgeInsets.all(0),
                              onTap: () {
                                Get.back();
                                Get.to(() => const AddProductScreen());
                              },
                              title: Text('Add New Product'),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(30)),
                              child: ListTile(
                                // contentPadding: const EdgeInsets.all(0),
                                onTap: () {
                                  Get.back();
                                  Get.to(() => ImportProductScreen());
                                },
                                title: Text('Import from CSV'),
                              ),
                            )
                          ],
                        ),
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
                            'new_product'.tr,
                            style: button16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            );
          }),
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
                        BlocBuilder<PublicCompanyBloc, PublicCompanyState>(
                            builder: (context, publicState) {
                          if (productController.isShowCategories) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Get.to(() => const CompanyFilterScreen());
                              },
                              child: Stack(
                                children: [
                                  Container(
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
                                          color:
                                              Color.fromRGBO(16, 24, 40, 0.05),
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
                                  if (publicState.isFilterEnable)
                                    Positioned(
                                        top: 5,
                                        right: 6,
                                        child: CircleAvatar(
                                          radius: 3,
                                          backgroundColor: ColorResources.red,
                                        ))
                                ],
                              ),
                            );
                          }
                          return BlocBuilder<PublicProductBloc,
                                  PublicProductState>(
                              builder: (context, publicProductState) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                context
                                    .read<FilterFieldsBloc>()
                                    .add(GetFilterFields());
                                Get.to(() => const ProductsFilterScreen());
                              },
                              child: Stack(
                                children: [
                                  Container(
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
                                          color:
                                              Color.fromRGBO(16, 24, 40, 0.05),
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
                                  if (publicProductState.isFilterEnable)
                                    Positioned(
                                        top: 5,
                                        right: 6,
                                        child: CircleAvatar(
                                          radius: 3,
                                          backgroundColor: ColorResources.red,
                                        ))
                                ],
                              ),
                            );
                          });
                        }),
                        //
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: (productController.isShowCategories)
                                ? () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.4,
                                              minChildSize: 0.3,
                                              maxChildSize: 0.8,
                                              expand: false,
                                              builder:
                                                  (context, scrollController) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'sort_by'.tr,
                                                            style: h16.copyWith(
                                                                color:
                                                                    ColorResources
                                                                        .darkGray,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          IconButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            icon: const Icon(
                                                                Icons.close),
                                                            color:
                                                                ColorResources
                                                                    .gray,
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          controller:
                                                              scrollController,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'newest_first'
                                                                          .tr,
                                                                  value:
                                                                      'c_newest',
                                                                  orderBy:
                                                                      'created_at',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      companyOrderBy,
                                                                  currentDirection:
                                                                      companyDirection,
                                                                  isCompany:
                                                                      true,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'oldest_first'
                                                                          .tr,
                                                                  value:
                                                                      'c_oldest',
                                                                  orderBy:
                                                                      'created_at',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      companyOrderBy,
                                                                  currentDirection:
                                                                      companyDirection,
                                                                  isCompany:
                                                                      true,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'name_a_z'
                                                                          .tr,
                                                                  value:
                                                                      'c_name_az',
                                                                  orderBy:
                                                                      'name',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      companyOrderBy,
                                                                  currentDirection:
                                                                      companyDirection,
                                                                  isCompany:
                                                                      true,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'name_z_a'
                                                                          .tr,
                                                                  value:
                                                                      'c_name_za',
                                                                  orderBy:
                                                                      'name',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      companyOrderBy,
                                                                  currentDirection:
                                                                      companyDirection,
                                                                  isCompany:
                                                                      true,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                : () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.6,
                                              minChildSize: 0.5,
                                              maxChildSize: 0.9,
                                              expand: false,
                                              builder:
                                                  (context, scrollController) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'sort_by'.tr,
                                                            style: h16.copyWith(
                                                                color:
                                                                    ColorResources
                                                                        .darkGray,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          IconButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            icon: const Icon(
                                                                Icons.close),
                                                            color:
                                                                ColorResources
                                                                    .gray,
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          controller:
                                                              scrollController,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'newest_first'
                                                                          .tr,
                                                                  value:
                                                                      'newest',
                                                                  orderBy:
                                                                      'created_at',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'oldest_first'
                                                                          .tr,
                                                                  value:
                                                                      'oldest',
                                                                  orderBy:
                                                                      'created_at',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'name_a_z'
                                                                          .tr,
                                                                  value:
                                                                      'name_az',
                                                                  orderBy:
                                                                      'name',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'name_z_a'
                                                                          .tr,
                                                                  value:
                                                                      'name_za',
                                                                  orderBy:
                                                                      'name',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'price_low_high'
                                                                          .tr,
                                                                  value:
                                                                      'price_low_high',
                                                                  orderBy:
                                                                      'price',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'price_high_low'
                                                                          .tr,
                                                                  value:
                                                                      'price_high_low',
                                                                  orderBy:
                                                                      'price',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'quantity_low_high'
                                                                          .tr,
                                                                  value:
                                                                      'quantity_low_high',
                                                                  orderBy:
                                                                      'quantity',
                                                                  direction:
                                                                      'asc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                                _buildSortOption(
                                                                  context:
                                                                      context,
                                                                  setState:
                                                                      setState,
                                                                  title:
                                                                      'quantity_high_low'
                                                                          .tr,
                                                                  value:
                                                                      'quantity_high_low',
                                                                  orderBy:
                                                                      'quantity',
                                                                  direction:
                                                                      'desc',
                                                                  currentOrderBy:
                                                                      productOrderBy,
                                                                  currentDirection:
                                                                      productDirection,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
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
                        ),

                        if (!productController.isShowCategories ||
                            widget.isSelectProduct) ...[
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
              return BlocBuilder<PublicProductBloc, PublicProductState>(
                  builder: (context, publicState) {
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
                                        color:
                                            !productController.isShowCategories
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
                                        color:
                                            productController.isShowCategories
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
                                  itemCount: publicState.isFilterEnable
                                      ? publicState.publicFilterProducts.length
                                      : publicState.publicProducts.length,
                                  itemBuilder: (context, index) {
                                    // return SizedBox();
                                    return ProductGridItem(
                                      isSelectProduct: widget.isSelectProduct,
                                      product: publicState.isFilterEnable
                                          ? publicState
                                              .publicFilterProducts[index]
                                          : publicState.publicProducts[index],
                                      // product: companyController.,
                                      // product: index,
                                    );
                                  },
                                )
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: publicState.isFilterEnable
                                      ? publicState.publicFilterProducts.length
                                      : publicState.publicProducts.length,
                                  itemBuilder: (context, index) {
                                    return ProductListItemWidget(
                                      isSelectProduct: widget.isSelectProduct,
                                      product: publicState.isFilterEnable
                                          ? publicState
                                              .publicFilterProducts[index]
                                          : publicState.publicProducts[index],
                                      // product: index,
                                    );
                                  },
                                ),
                        )
                      else
                        Expanded(
                          child: !productController.isShowCategories
                              ? PublicProductsWidget(
                                  orderBy: productOrderBy,
                                  direction: productDirection)
                              : PublicCompaniesWidget(
                                  orderBy: companyOrderBy,
                                  direction: companyDirection),
                          // const SizedBox(),
                        ),
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
