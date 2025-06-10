import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/data/repo/search_company_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_company_event.dart';
part 'search_company_state.dart';

class SearchCompanyBloc extends Bloc<SearchCompanyEvent, SearchCompanyState> {
  final SearchCompanyRepo searchCompanyRepo;
  SearchCompanyBloc(this.searchCompanyRepo) : super(SearchCompanyInitial()) {
    on<SearchCompanyEvent>((event, emit) {});
    on<SearchCompany>(_onSearchProduct);
    on<ClearSearchCompanyList>(_onClearSearchList);
    // on<ToggleSearchProductFavorite>(_onToggleSearchProductFavorite);
  }

  Future<void> _onSearchProduct(
      SearchCompany event, Emitter<SearchCompanyState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isMoreLoading: true));
    }

    try {
      print('public products status code = start try');
      final response = await searchCompanyRepo.searchCompany(
          event.search, event.currentPage);
      print('public products status code =  ${response.statusCode}');

      if (response.statusCode == 200) {
        final companyProducts = MyCompaniesModel.fromJson(response.body);
        print(
            'public products list length =  ${companyProducts.data?.items?.length}');

        if (event.currentPage == 1) {
          emit(state.copyWith(
            searchProducts: companyProducts.data?.items,
            isLoading: false,
          ));
        } else {
          emit(state.copyWith(
            searchProducts: List<CompanyItem>.from(state.searchProducts)
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

  Future<void> _onClearSearchList(
      ClearSearchCompanyList event, Emitter<SearchCompanyState> emit) async {
    emit(state.copyWith(searchProducts: []));
  }

  // toggle favorite
  // Future<void> _onToggleSearchProductFavorite(
  //     ToggleSearchProductFavorite event, Emitter<SearchState> emit) async {
  //   final updatedProducts = state.searchProducts.map((product) {
  //     if (product.id == event.productId) {
  //       return product.copyWith(
  //         isFavorite: !(product.isFavorite ?? false),
  //       );
  //     }
  //     return product;
  //   }).toList();

  //   emit(state.copyWith(searchProducts: updatedProducts));
  //   try {
  //     final response =
  //         await searchRepo.toggleFavorite(event.productId.toString());
  //     if (response.statusCode == 200) {
  //       // ignore: use_build_context_synchronously
  //       event.context
  //           .read<PublicProductBloc>()
  //           .add(ToggleFavoritePublicProductInList(event.productId));

  //       // ignore: use_build_context_synchronously
  //       // event.context
  //       //     .read<CompanyDetailBloc>()
  //       //     .add(ToggleFavoriteProductInList(event.productId));
  //     } else {
  //       final updatedProducts = state.searchProducts.map((product) {
  //         if (product.id == event.productId) {
  //           return product.copyWith(
  //             isFavorite: !(product.isFavorite ?? false),
  //           );
  //         }
  //         return product;
  //       }).toList();
  //       emit(state.copyWith(searchProducts: updatedProducts));
  //     }
  //   } catch (e) {
  //     final updatedProducts = state.searchProducts.map((product) {
  //       if (product.id == event.productId) {
  //         return product.copyWith(
  //           isFavorite: !(product.isFavorite ?? false),
  //         );
  //       }
  //       return product;
  //     }).toList();
  //     emit(state.copyWith(searchProducts: updatedProducts));
  //   }
  // }
}
