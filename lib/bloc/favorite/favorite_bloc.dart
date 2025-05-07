import 'package:el_biz/data/model/response/favorite/favorite_products_model.dart';
import 'package:el_biz/data/repo/favorite_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/company/company_product_model.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo favoriteRepo;
  FavoriteBloc(this.favoriteRepo) : super(const FavoriteState()) {
    on<UpdateShowCategories>((event, emit) {
      emit(state.copyWith(isShowCategories: event.showCategories));
    });

    on<UpdateShowGridView>((event, emit) {
      emit(state.copyWith(isShowGridView: event.showGridView));
    });

    on<GetFavoriteProducts>(_onGetFavoriteProducts);
    on<RemoveProductFromFavoriteList>(_onRemoveProductFromFavoriteList);
  }

  Future<void> _onGetFavoriteProducts(
      GetFavoriteProducts event, Emitter<FavoriteState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isProductsLoadingMore: true));
    }
    try {
      final response =
          await favoriteRepo.getFavoriteProducts(event.currentPage);
      print(
          'this is favorite products api response = ${response.statusCode} and ${response.body}');
      if (response.statusCode == 200) {
        final favoriteProducts = FavoriteProductsModel.fromJson(response.body);
        // List<ProductListItem> products = [];
        emit(state.copyWith(favoriteProducts: favoriteProducts.items));
      } else {
        emit(FavoriteProductsError(response.body['message']));
      }
    } catch (e) {
      emit(FavoriteProductsError(e.toString()));
    }
    emit(state.copyWith(isLoading: false, isProductsLoadingMore: false));
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
}
