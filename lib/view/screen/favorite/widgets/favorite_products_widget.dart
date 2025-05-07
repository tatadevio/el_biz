import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import '../../../../utils/color_resources.dart';
import '../../../base/product_grid_item.dart';
import '../../../base/product_list_item.dart';

class FavoriteProductsWidget extends StatefulWidget {
  const FavoriteProductsWidget({super.key});

  @override
  State<FavoriteProductsWidget> createState() => _FavoriteProductsWidgetState();
}

class _FavoriteProductsWidgetState extends State<FavoriteProductsWidget> {
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
    });
  }

  late PublicProductBloc publicProductBloc;
  late FavoriteBloc favoriteBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    publicProductBloc = context.read<PublicProductBloc>();
    favoriteBloc = context.read<FavoriteBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    updateProducts();
    super.dispose();
  }

  void updateProducts() async {
    publicProductBloc.add(GetPublicProduct(1));
    favoriteBloc.add(GetFavoriteProducts(1));
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0, // Scroll to the top
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favoriteState) {
          if (favoriteState.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (favoriteState is FavoriteProductsError) {
            return Center(
              child: Text(favoriteState.error),
            );
          }

          if (!favoriteState.isLoading &&
              favoriteState is! FavoriteProductsError) {
            if (favoriteState.favoriteProducts.isEmpty) {
              return Center(
                child: Text('no_favorite_products'.tr),
              );
            }
            return favoriteState.isShowGridView
                ? GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.7),
                    itemCount: favoriteState.favoriteProducts.length,
                    itemBuilder: (context, index) {
                      return ProductGridItem(
                        // isFavorite:
                        //     favoriteState.favoriteProducts[index].isFavorite ??
                        //         false,
                        product: favoriteState.favoriteProducts[index],
                      );
                    },
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: favoriteState.favoriteProducts.length,
                    itemBuilder: (context, index) {
                      return ProductListItemWidget(
                        // isFavorite:
                        //     favoriteState.favoriteProducts[index].isFavorite ??
                        //         false,
                        product: favoriteState.favoriteProducts[index],
                      );
                    },
                  );
          }
          return SizedBox.shrink();
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
