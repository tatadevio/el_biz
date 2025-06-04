import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/similar_product_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/response/company/company_product_model.dart';

part 'similar_products_event.dart';
part 'similar_products_state.dart';

class SimilarProductsBloc
    extends Bloc<SimilarProductsEvent, SimilarProductsState> {
  final SimilarProductRepo similarProductRepo;
  SimilarProductsBloc(this.similarProductRepo)
      : super(SimilarProductsInitial()) {
    on<SimilarProductsEvent>((event, emit) {});
    on<GetSimilarProducts>(_onGetSimilarProducts);
  }

  Future<void> _onGetSimilarProducts(
      GetSimilarProducts event, Emitter<SimilarProductsState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await similarProductRepo.getSimilarProducts(
          event.productId, event.currentPage);

      if (response.statusCode == 200) {
        final similarProduct = CompanyProductModel.fromJson(response.body);

        if (event.currentPage == 1) {
          emit(state.copyWith(
            similarProduct: similarProduct.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            similarProduct: List<ProductListItem>.from(state.similarProduct)
              ..addAll(similarProduct.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            currentPage: similarProduct.data?.currentPage ?? 1,
            pageSize: similarProduct.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }
}
