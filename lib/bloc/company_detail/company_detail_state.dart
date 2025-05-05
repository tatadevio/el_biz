part of 'company_detail_bloc.dart';

class CompanyDetailState extends Equatable {
  final bool companyDetailLoading;
  final bool isLoading;
  final CompanyDetailModel? companyDetailModel;
  final List<ProductListItem>? companyProducts;
  final List<DocumentItem>? companyDocuments;
  final List<TenderItem>? companyTenders;
  final List<ReviewItem>? companyReviews;
  final CompanyReviewsModel? companyReviewsModel;
  final bool isMoreLoading;
  final int currentPage;
  final int pageSize;
  final int productCurrentPage;
  final int productPageSize;
  final bool productShowMore;

  const CompanyDetailState({
    this.companyDetailLoading = false,
    this.isLoading = false,
    this.companyDetailModel,
    this.companyProducts = const [],
    this.companyDocuments = const [],
    this.companyTenders = const [],
    this.companyReviews = const [],
    this.companyReviewsModel,
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.productCurrentPage = 1,
    this.productPageSize = 1,
    this.productShowMore = false,
  });

  CompanyDetailState copyWith({
    bool? companyDetailLoading,
    bool? isLoading,
    CompanyDetailModel? companyDetailModel,
    List<ProductListItem>? companyProducts,
    List<DocumentItem>? companyDocuments,
    List<TenderItem>? companyTenders,
    List<ReviewItem>? companyReviews,
    CompanyReviewsModel? companyReviewsModel,
    bool? isMoreLoading,
    int? currentPage,
    int? pageSize,
    int? productCurrentPage,
    int? productPageSize,
    bool? productShowMore,
  }) {
    return CompanyDetailState(
      companyDetailLoading: companyDetailLoading ?? this.companyDetailLoading,
      isLoading: isLoading ?? this.isLoading,
      companyDetailModel: companyDetailModel ?? this.companyDetailModel,
      companyProducts: companyProducts ?? this.companyProducts,
      companyDocuments: companyDocuments ?? this.companyDocuments,
      companyTenders: companyTenders ?? this.companyTenders,
      companyReviews: companyReviews ?? this.companyReviews,
      companyReviewsModel: companyReviewsModel ?? this.companyReviewsModel,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      productCurrentPage: productCurrentPage ?? this.productCurrentPage,
      productPageSize: productPageSize ?? this.productPageSize,
      productShowMore: productShowMore ?? this.productShowMore,
    );
  }

  @override
  List<Object?> get props => [
        companyDetailLoading,
        isLoading,
        companyDetailModel,
        companyProducts,
        companyDocuments,
        companyTenders,
        companyReviews,
        companyReviewsModel,
        isMoreLoading,
        currentPage,
        pageSize,
        productCurrentPage,
        productPageSize,
        productShowMore,
      ];
}
