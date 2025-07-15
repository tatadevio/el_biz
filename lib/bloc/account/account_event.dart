part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetMyAccounts extends AccountEvent {
  final int? currentPage;
  const GetMyAccounts({this.currentPage});

  @override
  List<Object> get props => [currentPage ?? 1];
}

class AddAccount extends AccountEvent {
  final String accountName;
  final String accountNumber;
  final String bic;
  const AddAccount(
      {required this.accountName,
      required this.accountNumber,
      required this.bic});

  @override
  List<Object> get props => [accountName, accountNumber, bic];
}

class UpdateAccount extends AccountEvent {
  final String id;
  final String accountName;
  final String accountNumber;
  final String bic;
  const UpdateAccount(
      {required this.id,
      required this.accountName,
      required this.accountNumber,
      required this.bic});

  @override
  List<Object> get props => [id, accountName, accountNumber, bic];
}

class DeleteAccount extends AccountEvent {
  final String id;
  const DeleteAccount({required this.id});

  @override
  List<Object> get props => [id];
}

class MakePrimaryAccount extends AccountEvent {
  final int id;
  const MakePrimaryAccount({required this.id});

  @override
  List<Object> get props => [id];
}
