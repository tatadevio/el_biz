part of 'company_detail_bloc.dart';

class CompanyDetailState extends Equatable {
  final bool companyDetailLoading;
  final bool isLoading;
  final CompanyDetailModel? companyDetailModel;
  final List<ProductListItem>? companyProducts;
  final List<ProductListItem>? companyInactiveProducts;
  final List<DocumentItem>? companyDocuments;
  final List<TenderItem>? companyTenders;
  final List<TenderItem>? companyInactiveTenders;
  final List<ReviewItem>? companyReviews;
  final CompanyReviewsModel? companyReviewsModel;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  final int productCurrentPage;
  final int productPageSize;
  final bool productShowMore;
  final int inActiveProductCurrentPage;
  final int inActiveProductPageSize;
  final bool inActiveProductShowMore;
  final int activeTenderCurrentPage;
  final int activeTenderPageSize;
  final bool activeTenderShowMore;
  final int inActiveTenderCurrentPage;
  final int inActiveTenderPageSize;
  final bool inActiveTenderShowMore;

  const CompanyDetailState({
    this.companyDetailLoading = false,
    this.isLoading = false,
    this.companyDetailModel,
    this.companyProducts = const [],
    this.companyInactiveProducts = const [],
    this.companyDocuments = const [],
    this.companyTenders = const [],
    this.companyInactiveTenders = const [],
    this.companyReviews = const [],
    this.companyReviewsModel,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.productCurrentPage = 1,
    this.productPageSize = 1,
    this.productShowMore = false,
    this.inActiveProductCurrentPage = 1,
    this.inActiveProductPageSize = 1,
    this.inActiveProductShowMore = false,
    this.activeTenderCurrentPage = 1,
    this.activeTenderPageSize = 1,
    this.activeTenderShowMore = false,
    this.inActiveTenderCurrentPage = 1,
    this.inActiveTenderPageSize = 1,
    this.inActiveTenderShowMore = false,
  });

  CompanyDetailState copyWith({
    bool? companyDetailLoading,
    bool? isLoading,
    CompanyDetailModel? companyDetailModel,
    List<ProductListItem>? companyProducts,
    List<ProductListItem>? companyInactiveProducts,
    List<DocumentItem>? companyDocuments,
    List<TenderItem>? companyTenders,
    List<TenderItem>? companyInactiveTenders,
    List<ReviewItem>? companyReviews,
    CompanyReviewsModel? companyReviewsModel,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    int? productCurrentPage,
    int? productPageSize,
    bool? productShowMore,
    int? inActiveProductCurrentPage,
    int? inActiveProductPageSize,
    bool? inActiveProductShowMore,
    int? activeTenderCurrentPage,
    int? activeTenderPageSize,
    bool? activeTenderShowMore,
    int? inActiveTenderCurrentPage,
    int? inActiveTenderPageSize,
    bool? inActiveTenderShowMore,
  }) {
    return CompanyDetailState(
      companyDetailLoading: companyDetailLoading ?? this.companyDetailLoading,
      isLoading: isLoading ?? this.isLoading,
      companyDetailModel: companyDetailModel ?? this.companyDetailModel,
      companyProducts: companyProducts ?? this.companyProducts,
      companyInactiveProducts:
          companyInactiveProducts ?? this.companyInactiveProducts,
      companyDocuments: companyDocuments ?? this.companyDocuments,
      companyTenders: companyTenders ?? this.companyTenders,
      companyInactiveTenders:
          companyInactiveTenders ?? this.companyInactiveTenders,
      companyReviews: companyReviews ?? this.companyReviews,
      companyReviewsModel: companyReviewsModel ?? this.companyReviewsModel,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      productCurrentPage: productCurrentPage ?? this.productCurrentPage,
      productPageSize: productPageSize ?? this.productPageSize,
      productShowMore: productShowMore ?? this.productShowMore,
      inActiveProductCurrentPage:
          inActiveProductCurrentPage ?? this.inActiveProductCurrentPage,
      inActiveProductPageSize:
          inActiveProductPageSize ?? this.inActiveProductPageSize,
      inActiveProductShowMore:
          inActiveProductShowMore ?? this.inActiveProductShowMore,
      activeTenderCurrentPage:
          activeTenderCurrentPage ?? this.activeTenderCurrentPage,
      activeTenderPageSize: activeTenderPageSize ?? this.activeTenderPageSize,
      activeTenderShowMore: activeTenderShowMore ?? this.activeTenderShowMore,
      inActiveTenderCurrentPage:
          inActiveTenderCurrentPage ?? this.inActiveTenderCurrentPage,
      inActiveTenderPageSize:
          inActiveTenderPageSize ?? this.inActiveTenderPageSize,
      inActiveTenderShowMore:
          inActiveTenderShowMore ?? this.inActiveTenderShowMore,
    );
  }

  @override
  List<Object?> get props => [
        companyDetailLoading,
        isLoading,
        companyDetailModel,
        companyProducts,
        companyInactiveProducts,
        companyDocuments,
        companyTenders,
        companyInactiveTenders,
        companyReviews,
        companyReviewsModel,
        isMoreLoading,
        currentPage,
        pageSize,
        productCurrentPage,
        productPageSize,
        productShowMore,
        inActiveProductCurrentPage,
        inActiveProductPageSize,
        inActiveProductShowMore,
        activeTenderCurrentPage,
        activeTenderPageSize,
        activeTenderShowMore,
        inActiveTenderCurrentPage,
        inActiveTenderPageSize,
        inActiveTenderShowMore,
      ];
}
