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

class SignContract extends ContractsEvent {
  final String contractId;
  final String directorName;
  final XFile signatureFile;
  const SignContract({
    required this.contractId,
    required this.directorName,
    required this.signatureFile,
  });

  @override
  List<Object> get props => [contractId, directorName, signatureFile];
}

class UpdateContractStatus extends ContractsEvent {
  final String contractId;
  final String status;
  const UpdateContractStatus({required this.contractId, required this.status});
  @override
  List<Object> get props => [contractId, status];
}

class UpdatePaymentStatus extends ContractsEvent {
  final String contractId;
  final String status;
  const UpdatePaymentStatus({required this.contractId, required this.status});
  @override
  List<Object> get props => [contractId, status];
}

class AddPaymentData extends ContractsEvent {
  final String contractId;
  final String note;
  final XFile image;
  const AddPaymentData(
      {required this.contractId, required this.note, required this.image});

  @override
  List<Object> get props => [contractId, note, image];
}
