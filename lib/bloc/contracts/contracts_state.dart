part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final bool isLoading;
  // final List<ContractModel> contracts;
  final List<CompanyContractItem> salesContractItems;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  final bool isSigning;
  final bool isUpdating;
  const ContractsState({
    this.isLoading = false,
    // this.contracts = const [],
    this.salesContractItems = const [],
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.isSigning = false,
    this.isUpdating = false,
  });

  ContractsState copywith({
    bool? isLoading,
    // List<ContractModel>? contracts,
    List<CompanyContractItem>? salesContractItems,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
    bool? isSigning,
    bool? isUpdating,
  }) {
    return ContractsState(
      isLoading: isLoading ?? this.isLoading,
      // contracts: contracts ?? this.contracts,
      salesContractItems: salesContractItems ?? this.salesContractItems,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isSigning: isSigning ?? this.isSigning,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        salesContractItems,
        isLoadingMore,
        currentPage,
        pageSize,
        isSigning,
        isUpdating
      ];
}

// final class ContractsInitial extends ContractsState {}
