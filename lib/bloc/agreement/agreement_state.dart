part of 'agreement_bloc.dart';

class AgreementState extends Equatable {
  final bool isLoading;
  final List<PaymentMethod> paymentMethods;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;

  final List<CompanyItem> mySales;
  final List<CompanyItem> myPurchases;
  final int mySalesCurrentPage;
  final int myPurchasesCurrentPage;
  final int mySalesPageSize;
  final int myPurchasesPageSize;
  final String salesSearchQuery;
  final String purchasesSearchQuery;
  final List<CompanyItem> filteredMySales;
  final List<CompanyItem> filteredMyPurchases;
  final bool isSearchingSales;
  final bool isSearchingPurchases;
  final bool isLoadingSalesSearchMore;
  final bool isLoadingPurchasesSearchMore;
  final int salesSearchCurrentPage;
  final int purchasesSearchCurrentPage;
  final int salesSearchPageSize;
  final int purchasesSearchPageSize;

  const AgreementState({
    this.isLoading = false,
    this.paymentMethods = const [],
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.mySales = const [],
    this.myPurchases = const [],
    this.mySalesCurrentPage = 1,
    this.myPurchasesCurrentPage = 1,
    this.mySalesPageSize = 1,
    this.myPurchasesPageSize = 1,
    this.salesSearchQuery = '',
    this.purchasesSearchQuery = '',
    this.filteredMySales = const [],
    this.filteredMyPurchases = const [],
    this.isSearchingSales = false,
    this.isSearchingPurchases = false,
    this.isLoadingSalesSearchMore = false,
    this.isLoadingPurchasesSearchMore = false,
    this.salesSearchCurrentPage = 1,
    this.purchasesSearchCurrentPage = 1,
    this.salesSearchPageSize = 1,
    this.purchasesSearchPageSize = 1,
  });

  AgreementState copyWith(
      {bool? isLoading,
      List<PaymentMethod>? paymentMethods,
      bool? isLoadingMore,
      int? currentPage,
      int? pageSize,
      List<CompanyItem>? mySales,
      List<CompanyItem>? myPurchases,
      int? mySalesCurrentPage,
      int? myPurchasesCurrentPage,
      int? mySalesPageSize,
      int? myPurchasesPageSize,
      String? salesSearchQuery,
      String? purchasesSearchQuery,
      List<CompanyItem>? filteredMySales,
      List<CompanyItem>? filteredMyPurchases,
      bool? isSearchingSales,
      bool? isSearchingPurchases,
      bool? isLoadingSalesSearchMore,
      bool? isLoadingPurchasesSearchMore,
      int? salesSearchCurrentPage,
      int? purchasesSearchCurrentPage,
      int? salesSearchPageSize,
      int? purchasesSearchPageSize}) {
    return AgreementState(
      isLoading: isLoading ?? this.isLoading,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      mySales: mySales ?? this.mySales,
      myPurchases: myPurchases ?? this.myPurchases,
      mySalesCurrentPage: mySalesCurrentPage ?? this.mySalesCurrentPage,
      myPurchasesCurrentPage:
          myPurchasesCurrentPage ?? this.myPurchasesCurrentPage,
      mySalesPageSize: mySalesPageSize ?? this.mySalesPageSize,
      myPurchasesPageSize: myPurchasesPageSize ?? this.myPurchasesPageSize,
      salesSearchQuery: salesSearchQuery ?? this.salesSearchQuery,
      purchasesSearchQuery: purchasesSearchQuery ?? this.purchasesSearchQuery,
      filteredMySales: filteredMySales ?? this.filteredMySales,
      filteredMyPurchases: filteredMyPurchases ?? this.filteredMyPurchases,
      isSearchingSales: isSearchingSales ?? this.isSearchingSales,
      isSearchingPurchases: isSearchingPurchases ?? this.isSearchingPurchases,
      isLoadingSalesSearchMore:
          isLoadingSalesSearchMore ?? this.isLoadingSalesSearchMore,
      isLoadingPurchasesSearchMore:
          isLoadingPurchasesSearchMore ?? this.isLoadingPurchasesSearchMore,
      salesSearchCurrentPage:
          salesSearchCurrentPage ?? this.salesSearchCurrentPage,
      purchasesSearchCurrentPage:
          purchasesSearchCurrentPage ?? this.purchasesSearchCurrentPage,
      salesSearchPageSize: salesSearchPageSize ?? this.salesSearchPageSize,
      purchasesSearchPageSize:
          purchasesSearchPageSize ?? this.purchasesSearchPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        paymentMethods,
        isLoadingMore,
        currentPage,
        pageSize,
        mySales,
        myPurchases,
        mySalesCurrentPage,
        myPurchasesCurrentPage,
        mySalesPageSize,
        myPurchasesPageSize,
        salesSearchQuery,
        purchasesSearchQuery,
        filteredMySales,
        filteredMyPurchases,
        isSearchingSales,
        isSearchingPurchases,
        isLoadingSalesSearchMore,
        isLoadingPurchasesSearchMore,
        salesSearchCurrentPage,
        purchasesSearchCurrentPage,
        salesSearchPageSize,
        purchasesSearchPageSize,
      ];
}

final class AgreementInitial extends AgreementState {}

// class PaymentMethodSuccess extends AgreementState {
//   final List<PaymentMethod> paymentMethods;
//   const PaymentMethodSuccess(this.paymentMethods);

//   @override
//   List<Object> get props => [paymentMethods];
// }

// class PaymentMethodError extends AgreementState {
//   final String error;
//   const PaymentMethodError(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class AddAgreementLoader extends AgreementState {
//   const AddAgreementLoader();
// }

class AddAgreementSuccess extends AgreementState {
  final String message;
  const AddAgreementSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AddAgreementError extends AgreementState {
  final String error;
  const AddAgreementError(this.error);

  @override
  List<Object> get props => [error];
}
