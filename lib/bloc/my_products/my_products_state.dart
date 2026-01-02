part of 'my_products_bloc.dart';

class MyProductsState extends Equatable {
  final List<ProductListItem> myProducts;
  final bool isLoading;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;

  const MyProductsState(
      {this.myProducts = const [],
      this.isLoading = false,
      this.isMoreLoading = false,
      this.currentPage = 1,
      this.pageSize = 1});

  MyProductsState copyWith({
    List<ProductListItem>? myProducts,
    bool? isLoading,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
  }) {
    return MyProductsState(
      myProducts: myProducts ?? this.myProducts,
      isLoading: isLoading ?? this.isLoading,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props =>
      [myProducts, isLoading, isMoreLoading, currentPage, pageSize];
}

final class MyProductsInitial extends MyProductsState {}
