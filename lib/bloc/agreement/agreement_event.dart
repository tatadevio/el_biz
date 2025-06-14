part of 'agreement_bloc.dart';

sealed class AgreementEvent extends Equatable {
  const AgreementEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentMethod extends AgreementEvent {
  final int currentPage;
  const GetPaymentMethod({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class AddAgreement extends AgreementEvent {
  final Map<String, dynamic> data;
  const AddAgreement({required this.data});
  @override
  List<Object> get props => [data];
}

class GetMySales extends AgreementEvent {
  final int currentPage;
  const GetMySales({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class GetMyPurchases extends AgreementEvent {
  final int currentPage;
  const GetMyPurchases({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

