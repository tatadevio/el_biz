part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final bool isLoading;
  // final List<ContractModel> contracts;
  final List<CompanyContractItem> salesContractItems;
  final CompanyContractItem? contractDetail;
  // final bool isLoadingMore;
  // final int currentPage;
  // final int pageSize;
  final bool isSigning;
  final bool isUpdating;
  final bool isAddingPayment;
  final int salesContractItemsCurrentPage;
  final int salesContractItemsPageSize;
  final int purchasesContractItemsCurrentPage;
  final int purchasesContractItemsPageSize;
  final bool isSalesLoadingMore;
  final bool isPurchasesLoadingMore;

  const ContractsState({
    this.isLoading = false,
    // this.contracts = const [],
    this.salesContractItems = const [],
    this.contractDetail,
    // this.isLoadingMore = false,
    // this.currentPage = 1,
    // this.pageSize = 1,
    this.isSigning = false,
    this.isUpdating = false,
    this.isAddingPayment = false,
    this.salesContractItemsCurrentPage = 1,
    this.salesContractItemsPageSize = 1,
    this.purchasesContractItemsCurrentPage = 1,
    this.purchasesContractItemsPageSize = 1,
    this.isSalesLoadingMore = false,
    this.isPurchasesLoadingMore = false,
  });

  ContractsState copywith({
    bool? isLoading,
    // List<ContractModel>? contracts,
    List<CompanyContractItem>? salesContractItems,
    CompanyContractItem? contractDetail,
    // bool? isLoadingMore,
    // int? currentPage,
    // int? pageSize,
    bool? isSigning,
    bool? isUpdating,
    bool? isAddingPayment,
    int? salesContractItemsCurrentPage,
    int? salesContractItemsPageSize,
    int? purchasesContractItemsCurrentPage,
    int? purchasesContractItemsPageSize,
    bool? isSalesLoadingMore,
    bool? isPurchasesLoadingMore,
  }) {
    return ContractsState(
      isLoading: isLoading ?? this.isLoading,
      // contracts: contracts ?? this.contracts,
      salesContractItems: salesContractItems ?? this.salesContractItems,
      contractDetail: contractDetail ?? this.contractDetail,
      // isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      // currentPage: currentPage ?? this.currentPage,
      // pageSize: pageSize ?? this.pageSize,
      isSigning: isSigning ?? this.isSigning,
      isUpdating: isUpdating ?? this.isUpdating,
      isAddingPayment: isAddingPayment ?? this.isAddingPayment,
      salesContractItemsCurrentPage:
          salesContractItemsCurrentPage ?? this.salesContractItemsCurrentPage,
      salesContractItemsPageSize:
          salesContractItemsPageSize ?? this.salesContractItemsPageSize,
      purchasesContractItemsCurrentPage: purchasesContractItemsCurrentPage ??
          this.purchasesContractItemsCurrentPage,
      purchasesContractItemsPageSize:
          purchasesContractItemsPageSize ?? this.purchasesContractItemsPageSize,
      isSalesLoadingMore: isSalesLoadingMore ?? this.isSalesLoadingMore,
      isPurchasesLoadingMore:
          isPurchasesLoadingMore ?? this.isPurchasesLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        salesContractItems,
        contractDetail,
        // isLoadingMore,
        // currentPage,
        // pageSize,
        isSigning,
        isUpdating,
        isAddingPayment,
        salesContractItemsCurrentPage,
        salesContractItemsPageSize,
        purchasesContractItemsCurrentPage,
        purchasesContractItemsPageSize,
        isSalesLoadingMore,
        isPurchasesLoadingMore,
      ];
}

// final class ContractsInitial extends ContractsState {}
