import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_text_style.dart';
import '../../base/product_grid_item.dart';
import '../../base/product_list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }

      searchBloc = context.read<SearchBloc>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !searchBloc.state.isLoading &&
          !searchBloc.state.isMoreLoading) {
        int pageSize = searchBloc.state.pageSize;
        if (searchBloc.state.currentPage < pageSize) {
          int nextPage = searchBloc.state.currentPage;

          context.read<SearchBloc>().add(SearchProduct(
              search: searchController.text, currentPage: nextPage + 1));
        }
      }
    });
  }

  late SearchBloc searchBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchBloc = context.read<SearchBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchBloc.add(ClearSearchList());
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
    double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    border: OutlineInputBorder(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SvgPicture.asset(Images.svgSearch),
                    ),
                  ),
                  onChanged: (val) {
                    context
                        .read<SearchBloc>()
                        .add(SearchProduct(search: val, currentPage: 1));
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                searchController.clear();
                context.read<SearchBloc>().add(ClearSearchList());
              },
              child: Text(
                'Отмена',
                style: body14.copyWith(color: ColorResources.gray),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(95),
          child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5),
                    child: SizedBox(
                      height: height * 0.06,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 4.0, 5.0, 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(ChangeStatusSearch(false));
                                  // productController.changeStatusSearch(0);
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: ColorResources.lightBlue,
                                    boxShadow:
                                        searchState.isSearchProducts == false
                                            ? const [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.06),
                                                ),
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  spreadRadius: 3,
                                                  offset: Offset(0, 1),
                                                  color: Color.fromRGBO(
                                                      16, 24, 40, 0.1),
                                                ),
                                              ]
                                            : [],
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Компании".tr,
                                    style: mediumTextStyle.copyWith(
                                      color:
                                          searchState.isSearchProducts == false
                                              ? ColorResources.primary
                                              : ColorResources.black,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(ChangeStatusSearch(true));
                                  // productController.changeStatusSearch(1);
                                },
                                child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // color: productController.showFavSearch == 1 ? ColorResources.primary : ColorResources.background,
                                    color: ColorResources.lightBlue,
                                    boxShadow: searchState.isSearchProducts
                                        ? const [
                                            BoxShadow(
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: Offset(0, 1),
                                              color: Color.fromRGBO(
                                                  16, 24, 40, 0.06),
                                            ),
                                            BoxShadow(
                                              blurRadius: 3,
                                              spreadRadius: 3,
                                              offset: Offset(0, 1),
                                              color: Color.fromRGBO(
                                                  16, 24, 40, 0.1),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Center(
                                      child: Text("goods".tr,
                                          style: mediumTextStyle.copyWith(
                                            color: searchState.isSearchProducts
                                                ? ColorResources.primary
                                                : ColorResources.black,
                                          ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            // productController.updateGridView(true);

                            context
                                .read<SearchBloc>()
                                .add(const UpdateGridView(true));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: searchState.isGridView
                                  ? ColorResources.primary
                                  : null,
                              border: Border.all(
                                width: 1,
                                color: searchState.isGridView
                                    ? ColorResources.primary
                                    : ColorResources.lgColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              Images.svgCategory,
                              color: searchState.isGridView
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
                                .read<SearchBloc>()
                                .add(const UpdateGridView(false));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: searchState.isGridView
                                  ? null
                                  : ColorResources.primary,
                              border: Border.all(
                                width: 1,
                                color: !searchState.isGridView
                                    ? ColorResources.primary
                                    : ColorResources.lgColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              Images.svgList,
                              color: !searchState.isGridView
                                  ? ColorResources.white
                                  : ColorResources.gray,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, searchState) {
              if (searchState.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (searchState.searchProducts.isEmpty) {
                if (searchController.text.isEmpty) {
                  return Center(
                    child: Text(
                      'search_for_products'.tr,
                      style: body14,
                    ),
                  );
                }
                return Center(
                  child: Text(
                    'no_product_found'.tr,
                    style: body14,
                  ),
                );
              }
              if (searchState.isGridView) {
                return GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7),
                  itemCount: searchState.searchProducts.length,
                  itemBuilder: (context, index) {
                    // return SizedBox();
                    return ProductGridItem(
                      product: searchState.searchProducts[index],
                      isSearchProduct: true,

                      // product: companyController.,
                      // product: index,
                    );
                  },
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: searchState.searchProducts.length,
                itemBuilder: (context, index) {
                  return ProductListItemWidget(
                    product: searchState.searchProducts[index],
                    isPublicProduct: false,
                    isSearchProduct: true,
                  );
                },
              );
            }),
          ),
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
    );
  }
}
