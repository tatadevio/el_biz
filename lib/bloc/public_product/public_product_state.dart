part of 'public_product_bloc.dart';

class PublicProductState extends Equatable {
  final bool isLoading;
  final List<ProductListItem> publicProducts;
  final List<ProductListItem> publicFilterProducts;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  final bool isFilterEnable;
  final ProductFilterValuesModel? productFilterValuesModel;
  final int filterCurrentPage;
  final int filterPageSize;

  const PublicProductState({
    this.isLoading = false,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.publicProducts = const [],
    this.publicFilterProducts = const [],
    this.isFilterEnable = false,
    this.productFilterValuesModel,
    this.filterCurrentPage = 1,
    this.filterPageSize = 1,
  });

  PublicProductState copyWith({
    bool? isLoading,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    List<ProductListItem>? publicProducts,
    List<ProductListItem>? publicFilterProducts,
    bool? isFilterEnable,
    ProductFilterValuesModel? productFilterValuesModel,
    int? filterCurrentPage,
    int? filterPageSize,
  }) {
    return PublicProductState(
      isLoading: isLoading ?? this.isLoading,
      publicProducts: publicProducts ?? this.publicProducts,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      publicFilterProducts: publicFilterProducts ?? this.publicFilterProducts,
      isFilterEnable: isFilterEnable ?? this.isFilterEnable,
      productFilterValuesModel:
          productFilterValuesModel ?? this.productFilterValuesModel,
      filterCurrentPage: filterCurrentPage ?? this.filterCurrentPage,
      filterPageSize: filterPageSize ?? this.filterPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        publicProducts,
        isMoreLoading,
        currentPage,
        pageSize,
        publicFilterProducts,
        isFilterEnable,
        productFilterValuesModel!,
        filterCurrentPage,
        filterPageSize,
      ];
}

final class PublicProductInitial extends PublicProductState {
  PublicProductInitial()
      : super(
          productFilterValuesModel: ProductFilterValuesModel(),
        );
}
