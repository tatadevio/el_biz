import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../utils/color_resources.dart';
import '../../../base/product_grid_item.dart';
import '../../../base/product_list_item.dart';

class PublicProductsWidget extends StatefulWidget {
  const PublicProductsWidget({super.key});

  @override
  State<PublicProductsWidget> createState() => _PublicProductsWidgetState();
}

class _PublicProductsWidgetState extends State<PublicProductsWidget> {
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
    return Stack(
      children: [
        BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
          return BlocBuilder<PublicProductBloc, PublicProductState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.publicProducts.isEmpty) {
                return Center(
                  child: Text('no_product_found'.tr),
                );
              }

              return
                  // SizedBox();
                  productState.isGridView
                      ? GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.7),
                          itemCount: state.publicProducts.length,
                          itemBuilder: (context, index) {
                            return ProductGridItem(
                              isFavorite:
                                  state.publicProducts[index].isFavorite ??
                                      false,
                              product: state.publicProducts[index],
                            );
                          },
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: state.publicProducts.length,
                          itemBuilder: (context, index) {
                            return ProductListItemWidget(
                              isFavorite:
                                  state.publicProducts[index].isFavorite ??
                                      false,
                              product: state.publicProducts[index],
                            );
                          },
                        );
            },
          );
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
    );
  }
}
