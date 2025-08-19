import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/search/search_bloc.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';
import '../../../base/product_grid_item.dart';
import '../../../base/product_list_item.dart';

class SearchProductWidget extends StatefulWidget {
  final TextEditingController searchController;
  final ScrollController? scrollController;
  const SearchProductWidget(
      {super.key,
      required this.searchController,
      required this.scrollController});

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController!.addListener(() {
      if (widget.scrollController!.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (widget.scrollController!.offset <= 300 &&
          _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }

      final searchBloc = context.read<SearchBloc>();

      if (widget.scrollController!.position.pixels >=
              widget.scrollController!.position.maxScrollExtent - 300 &&
          !searchBloc.state.isLoading &&
          !searchBloc.state.isMoreLoading) {
        int pageSize = searchBloc.state.pageSize;
        if (searchBloc.state.currentPage < pageSize) {
          int nextPage = searchBloc.state.currentPage;

          context.read<SearchBloc>().add(SearchProduct(
              search: widget.searchController.text, currentPage: nextPage + 1));
        }
      }
    });
  }

  void _scrollToTop() {
    widget.scrollController!.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              if (widget.searchController.text.isEmpty) {
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
              return SingleChildScrollView(
                controller: widget.scrollController!,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                    ),
                    if (searchState.isMoreLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ).paddingOnly(
                          bottom: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              controller: widget.scrollController!,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchState.searchProducts.length,
                    itemBuilder: (context, index) {
                      return ProductListItemWidget(
                        product: searchState.searchProducts[index],
                        isPublicProduct: false,
                        isSearchProduct: true,
                      );
                    },
                  ),
                  if (searchState.isMoreLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ).paddingOnly(
                        bottom: MediaQuery.of(context).padding.bottom),
                ],
              ),
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
    );
  }
}
