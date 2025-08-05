part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final bool isLoading;
  // final List<ContractModel> contracts;
  final List<CompanyContractItem> salesContractItems;
  final CompanyContractItem? contractDetail;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  final bool isSigning;
  final bool isUpdating;
  final bool isAddingPayment;

  const ContractsState({
    this.isLoading = false,
    // this.contracts = const [],
    this.salesContractItems = const [],
    this.contractDetail,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.isSigning = false,
    this.isUpdating = false,
    this.isAddingPayment = false,
  });

  ContractsState copywith({
    bool? isLoading,
    // List<ContractModel>? contracts,
    List<CompanyContractItem>? salesContractItems,
    CompanyContractItem? contractDetail,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
    bool? isSigning,
    bool? isUpdating,
    bool? isAddingPayment,
  }) {
    return ContractsState(
      isLoading: isLoading ?? this.isLoading,
      // contracts: contracts ?? this.contracts,
      salesContractItems: salesContractItems ?? this.salesContractItems,
      contractDetail: contractDetail ?? this.contractDetail,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isSigning: isSigning ?? this.isSigning,
      isUpdating: isUpdating ?? this.isUpdating,
      isAddingPayment: isAddingPayment ?? this.isAddingPayment,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        salesContractItems,
        contractDetail,
        isLoadingMore,
        currentPage,
        pageSize,
        isSigning,
        isUpdating,
        isAddingPayment,
      ];
}

// final class ContractsInitial extends ContractsState {}
