part of 'public_company_bloc.dart';

sealed class PublicCompanyEvent extends Equatable {
  const PublicCompanyEvent();

  @override
  List<Object> get props => [];
}

class GetPublicCompany extends PublicCompanyEvent {
  final int currentPage;
  const GetPublicCompany(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

class GetNewPublicCompany extends PublicCompanyEvent {
  final int currentPage;
  const GetNewPublicCompany(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
