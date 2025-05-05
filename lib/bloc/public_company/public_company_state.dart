part of 'public_company_bloc.dart';

sealed class PublicCompanyState extends Equatable {
  const PublicCompanyState();
  
  @override
  List<Object> get props => [];
}

final class PublicCompanyInitial extends PublicCompanyState {}
