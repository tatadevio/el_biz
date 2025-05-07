part of 'public_company_bloc.dart';

class PublicCompanyState extends Equatable {
  final bool isLoading;
  final List<CompanyItem> publicCompanies;
  final List<CompanyItem> newCompanies;
  final bool isMoreLoading;
  final int companyCurrentPage;
  final int companyPageSize;
  final int newCompanyCurrentPage;
  final int newCompanyPageSize;
  const PublicCompanyState({
    this.isLoading = false,
    this.publicCompanies = const [],
    this.newCompanies = const [],
    this.isMoreLoading = false,
    this.companyCurrentPage = 1,
    this.companyPageSize = 1,
    this.newCompanyCurrentPage = 1,
    this.newCompanyPageSize = 1,
  });

  PublicCompanyState copyWith({
    bool? isLoading,
    List<CompanyItem>? publicCompanies,
    List<CompanyItem>? newCompanies,
    bool? isMoreLoading,
    int? companyCurrentPage,
    int? companyPageSize,
    int? newCompanyCurrentPage,
    int? newCompanyPageSize,
  }) {
    return PublicCompanyState(
      isLoading: isLoading ?? this.isLoading,
      publicCompanies: publicCompanies ?? this.publicCompanies,
      newCompanies: newCompanies ?? this.newCompanies,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      companyCurrentPage: companyCurrentPage ?? this.companyCurrentPage,
      companyPageSize: companyPageSize ?? this.companyPageSize,
      newCompanyCurrentPage:
          newCompanyCurrentPage ?? this.newCompanyCurrentPage,
      newCompanyPageSize: newCompanyPageSize ?? this.newCompanyPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        publicCompanies,
        newCompanies,
        isMoreLoading,
        companyCurrentPage,
        companyPageSize,
        newCompanyCurrentPage,
        newCompanyPageSize,
      ];
}

final class PublicCompanyInitial extends PublicCompanyState {}
