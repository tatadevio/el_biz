import 'package:el_biz/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepo productRepo;
  ProductDetailBloc(this.productRepo) : super(const ProductDetailState()) {
    on<ToggleShowProductReview>((event, emit) {
      emit(state.copywith(showProductReviews: event.isShowReview));
    });
  }
}
