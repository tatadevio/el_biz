import 'package:el_biz/data/model/response/favorite/favorite_products_model.dart';
import 'package:el_biz/data/model/response/favorite/favorite_tenders_model.dart';
import 'package:el_biz/data/model/response/tender/tender_item_model.dart';
import 'package:el_biz/data/repo/favorite_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo favoriteRepo;
  FavoriteBloc(this.favoriteRepo) : super(FavoriteInitial()) {
    on<UpdateShowCategories>((event, emit) {
      emit(state.copyWith(isShowCategories: event.showCategories));
    });

    on<UpdateShowGridView>((event, emit) {
      emit(state.copyWith(isShowGridView: event.showGridView));
    });

    on<GetFavoriteProducts>(_onGetFavoriteProducts);
    on<GetFavoriteTenders>(_onGetFavoriteTenders);
    on<RemoveProductFromFavoriteList>(_onRemoveProductFromFavoriteList);
    on<RemoveTenderFromFavoriteList>(_onRemoveTenderFromFavoriteList);
  }

  Future<void> _onGetFavoriteProducts(
      GetFavoriteProducts event, Emitter<FavoriteState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, favoriteProducts: []));
    } else {
      emit(state.copyWith(isProductsLoadingMore: true));
    }
    try {
      final response =
          await favoriteRepo.getFavoriteProducts(event.currentPage);

      if (response.statusCode == 200) {
        final favoriteProducts = FavoriteProductsModel.fromJson(response.body);

        emit(state.copyWith(
            favoriteProducts: List<ProductListItem>.from(state.favoriteProducts)
              ..addAll(favoriteProducts.items ?? []),
            productsCurrentPage: favoriteProducts.currentPage ?? 1,
            productsPageSize: favoriteProducts.totalPages ?? 1));
        print(
            'favorite products items = ${state.favoriteProducts.length} total length = ${favoriteProducts.total} ');
      } else {
        emit(FavoriteProductsError(response.body['message']));
      }
    } catch (e) {
      emit(FavoriteProductsError(e.toString()));
    }
    emit(state.copyWith(isLoading: false, isProductsLoadingMore: false));
  }

  Future<void> _onGetFavoriteTenders(
      GetFavoriteTenders event, Emitter<FavoriteState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true, favoriteTenders: []));
    } else {
      emit(state.copyWith(isTendersLoadingMore: true));
    }
    try {
      final response = await favoriteRepo.getFavoriteTenders(event.currentPage);

      if (response.statusCode == 200) {
        final favoriteTenders = FavoriteTendersModel.fromJson(response.body);

        emit(state.copyWith(
          favoriteTenders: List<TenderItem>.from(state.favoriteTenders)
            ..addAll(favoriteTenders.items ?? []),
          tendersCurrentPage: favoriteTenders.currentPage ?? 1,
          tendersPageSize: favoriteTenders.totalPages ?? 1,
        ));
      } else {
        emit(FavoriteTendersError(response.body['message']));
      }
    } catch (e) {
      emit(FavoriteTendersError(e.toString()));
    }
    emit(state.copyWith(isLoading: false, isTendersLoadingMore: false));
  }

  Future<void> _onRemoveProductFromFavoriteList(
    RemoveProductFromFavoriteList event,
    Emitter<FavoriteState> emit,
  ) async {
    List<ProductListItem> allFavorites = List.from(state.favoriteProducts);

    final index =
        allFavorites.indexWhere((product) => product.id == event.productId);

    if (index != -1) {
      allFavorites.removeAt(index);
      emit(state.copyWith(favoriteProducts: allFavorites));
    } else {
      // Product not found, no action needed, optionally re-emit same state
      emit(state);
    }
  }

  Future<void> _onRemoveTenderFromFavoriteList(
    RemoveTenderFromFavoriteList event,
    Emitter<FavoriteState> emit,
  ) async {
    List<TenderItem> allTenders = List.from(state.favoriteTenders);

    final index =
        allTenders.indexWhere((tender) => tender.id == event.tenderId);

    if (index != -1) {
      allTenders.removeAt(index);
      emit(state.copyWith(favoriteTenders: allTenders));
    } else {
      // Product not found, no action needed, optionally re-emit same state
      emit(state);
    }
  }
}
