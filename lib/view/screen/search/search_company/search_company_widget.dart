import 'package:el_biz/bloc/search_company/search_company_bloc.dart';
import 'package:el_biz/view/base/company_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../bloc/search/search_bloc.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/custom_text_style.dart';

class SearchCompanyWidget extends StatefulWidget {
  final TextEditingController searchController;
  final ScrollController? scrollController;
  const SearchCompanyWidget(
      {super.key,
      required this.searchController,
      required this.scrollController});

  @override
  State<SearchCompanyWidget> createState() => _SearchCompanyWidgetState();
}

class _SearchCompanyWidgetState extends State<SearchCompanyWidget> {
  // final ScrollController _scrollController = ScrollController();

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

      final searchBloc = context.read<SearchCompanyBloc>();

      if (widget.scrollController!.position.pixels >=
              widget.scrollController!.position.maxScrollExtent - 300 &&
          !searchBloc.state.isLoading &&
          !searchBloc.state.isMoreLoading) {
        int pageSize = searchBloc.state.pageSize;
        if (searchBloc.state.currentPage < pageSize) {
          int nextPage = searchBloc.state.currentPage;

          context.read<SearchCompanyBloc>().add(SearchCompany(
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
              builder: (context, productState) {
            return BlocBuilder<SearchCompanyBloc, SearchCompanyState>(
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
                      'search_for_companies'.tr,
                      style: body14,
                    ),
                  );
                }
                return Center(
                  child: Text(
                    'no_company_found'.tr,
                    style: body14,
                  ),
                );
              }
              // if (productState.isGridView) {
              //   return GridView.builder(
              //     controller: widget.scrollController!,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         mainAxisSpacing: 10,
              //         crossAxisSpacing: 10,
              //         childAspectRatio: 0.7),
              //     itemCount: searchState.searchProducts.length,
              //     itemBuilder: (context, index) {
              //       // return SizedBox();
              //       return ProductGridItem(
              //         product: searchState.searchProducts[index],
              //         isSearchProduct: true,

              //         // product: companyController.,
              //         // product: index,
              //       );
              //     },
              //   );
              // }
              return ListView.builder(
                controller: widget.scrollController!,
                itemCount: searchState.searchProducts.length,
                itemBuilder: (context, index) {
                  return CompanyItemWidget(
                    company: searchState.searchProducts[index],
                    isSearchCompany: true,
                    // product: searchState.searchProducts[index],
                    // isPublicProduct: false,
                    // isSearchProduct: true,
                  );
                },
              );
            });
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
