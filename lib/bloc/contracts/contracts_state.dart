part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final bool isLoading;
  // final List<ContractModel> contracts;
  final List<CompanyContractItem> salesContractItems;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  const ContractsState({
    this.isLoading = false,
    // this.contracts = const [],
    this.salesContractItems = const [],
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
  });

  ContractsState copywith({
    bool? isLoading,
    // List<ContractModel>? contracts,
    List<CompanyContractItem>? salesContractItems,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
  }) {
    return ContractsState(
      isLoading: isLoading ?? this.isLoading,
      // contracts: contracts ?? this.contracts,
      salesContractItems: salesContractItems ?? this.salesContractItems,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, salesContractItems, isLoadingMore, currentPage, pageSize];
}

// final class ContractsInitial extends ContractsState {}
