import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/view/base/tender_grid_item.dart';
import 'package:el_biz/view/base/tender_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';

import '../../../../utils/color_resources.dart';

class FavoriteTendersWidget extends StatefulWidget {
  const FavoriteTendersWidget({super.key});

  @override
  State<FavoriteTendersWidget> createState() => _FavoriteTendersWidgetState();
}

class _FavoriteTendersWidgetState extends State<FavoriteTendersWidget> {
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
          if (favoriteState is FavoriteTendersError) {
            return Center(
              child: Text(favoriteState.error),
            );
          }

          if (!favoriteState.isLoading &&
              favoriteState is! FavoriteTendersError) {
            if (favoriteState.favoriteTenders.isEmpty) {
              return Center(
                child: Text('no_favorite_tenders'.tr),
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
                    itemCount: favoriteState.favoriteTenders.length,
                    itemBuilder: (context, index) {
                      return TenderGridItem(
                        isCompanyTender: false,
                        // isFavorite:
                        //     favoriteState.favoriteProducts[index].isFavorite ??
                        //         false,
                        tender: favoriteState.favoriteTenders[index],
                      );
                    },
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: favoriteState.favoriteTenders.length,
                    itemBuilder: (context, index) {
                      return TenderListItem(
                        // isFavorite:
                        //     favoriteState.favoriteProducts[index].isFavorite ??
                        //         false,
                        tender: favoriteState.favoriteTenders[index],
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
