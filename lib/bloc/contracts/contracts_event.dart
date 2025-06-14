part of 'contracts_bloc.dart';

sealed class ContractsEvent extends Equatable {
  const ContractsEvent();

  @override
  List<Object> get props => [];
}


class GetCompanySales extends ContractsEvent {
  final String companyId;
  final int currentPage;
  const GetCompanySales({required this.companyId, required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}

class GetCompanyPurchases extends ContractsEvent {
  final String companyId;
  final int currentPage;
  const GetCompanyPurchases(
      {required this.companyId, required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}
