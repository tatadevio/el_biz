part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final bool isLoading;
  final List<ContractModel> contracts;
  const ContractsState({this.isLoading = false, this.contracts = const []});

  ContractsState copywith({bool? isLoading, List<ContractModel>? contracts}) {
    return ContractsState(
      isLoading: isLoading ?? this.isLoading,
      contracts: contracts ?? this.contracts,
    );
  }

  @override
  List<Object> get props => [];
}

// final class ContractsInitial extends ContractsState {}
