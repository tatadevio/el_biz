import 'package:bloc/bloc.dart';
import 'package:el_biz/data/repo/my_products_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/response/company/company_product_model.dart';

part 'my_products_event.dart';
part 'my_products_state.dart';

class MyProductsBloc extends Bloc<MyProductsEvent, MyProductsState> {
  final MyProductsRepo myProductsRepo;
  MyProductsBloc(this.myProductsRepo) : super(MyProductsInitial()) {
    on<MyProductsEvent>((event, emit) {});

    on<GetMyProducts>(_onGetMyProducts);
  }
  Future<void> _onGetMyProducts(
      GetMyProducts event, Emitter<MyProductsState> emit) async {
    if (event.page == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      final response = await myProductsRepo.getMyProducts(
          event.page, event.orderBy, event.direction);
      print('public products status code =  ${response.statusCode}');

      if (response.statusCode == 200) {
        final companyProducts = CompanyProductModel.fromJson(response.body);
        // print(
        // 'my products list length =  ${companyProducts.data?.total}');

        if (event.page == 1) {
          emit(state.copyWith(
            myProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            myProducts: List<ProductListItem>.from(state.myProducts)
              ..addAll(companyProducts.data?.items ?? []),
          ));
        }

        emit(state.copyWith(
            currentPage: companyProducts.data?.currentPage ?? 1,
            pageSize: companyProducts.data?.totalPages ?? 1));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("public product catch part = ${e.toString()}");
    }
    emit(state.copyWith(isLoading: false, isMoreLoading: false));
  }
}
