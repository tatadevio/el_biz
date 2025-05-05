part of 'public_company_bloc.dart';

class PublicCompanyState extends Equatable {
  final bool isLoading;
  final List<CompanyItem> publicCompanies;
  final bool isMoreLoading;
  final int companyCurrentPage;
  final int companyPageSize;
  const PublicCompanyState({
    this.isLoading = false,
    this.publicCompanies = const [],
    this.isMoreLoading = false,
    this.companyCurrentPage = 1,
    this.companyPageSize = 1,
  });

  PublicCompanyState copyWith({
    bool? isLoading,
    List<CompanyItem>? publicCompanies,
    bool? isMoreLoading,
    int? companyCurrentPage,
    int? companyPageSize,
  }) {
    return PublicCompanyState(
      isLoading: isLoading ?? this.isLoading,
      publicCompanies: publicCompanies ?? this.publicCompanies,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      companyCurrentPage: companyCurrentPage ?? this.companyCurrentPage,
      companyPageSize: companyPageSize ?? this.companyPageSize,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        publicCompanies,
        isMoreLoading,
        companyCurrentPage,
        companyPageSize
      ];
}

final class PublicCompanyInitial extends PublicCompanyState {}
