part of 'public_product_bloc.dart';

class PublicProductState extends Equatable {
  final bool isLoading;
  final List<ProductListItem> publicProducts;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  const PublicProductState({
    this.isLoading = false,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.publicProducts = const [],
  });

  PublicProductState copyWith(
      {bool? isLoading, bool? isMoreLoading, int? currentPage, int? pageSize, List<ProductListItem> ? publicProducts}) {
    return PublicProductState(
      isLoading: isLoading ?? this.isLoading,
    publicProducts : publicProducts ?? this.publicProducts,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [isLoading, publicProducts, isMoreLoading, currentPage, pageSize];
}

final class PublicProductInitial extends PublicProductState {}
