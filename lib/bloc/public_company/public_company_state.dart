part of 'public_company_bloc.dart';

class PublicCompanyState extends Equatable {
  final bool isLoading;
  final List<CompanyItem> publicCompanies;
  final List<CompanyItem> newCompanies;
  final List<CompanyItem> filterCompanies;
  final bool isMoreLoading;
  final int companyCurrentPage;
  final int companyPageSize;
  final int newCompanyCurrentPage;
  final int newCompanyPageSize;
  final bool isFilterEnable;
  final CompanyFilterValuesModel? companyFilterValuesModel;
  final int filterCurrentPage;
  final int filterPageSize;
  const PublicCompanyState({
    this.isLoading = false,
    this.publicCompanies = const [],
    this.newCompanies = const [],
    this.filterCompanies = const [],
    this.isMoreLoading = false,
    this.companyCurrentPage = 1,
    this.companyPageSize = 1,
    this.newCompanyCurrentPage = 1,
    this.newCompanyPageSize = 1,
    this.isFilterEnable = false,
    this.companyFilterValuesModel,
    this.filterCurrentPage = 1,
    this.filterPageSize = 1,
  });

  PublicCompanyState copyWith({
    bool? isLoading,
    List<CompanyItem>? publicCompanies,
    List<CompanyItem>? newCompanies,
    List<CompanyItem>? filterCompanies,
    bool? isMoreLoading,
    int? companyCurrentPage,
    int? companyPageSize,
    int? newCompanyCurrentPage,
    int? newCompanyPageSize,
    bool? isFilterEnable,
    CompanyFilterValuesModel? companyFilterValuesModel,
    int? filterCurrentPage,
    int? filterPageSize,
  }) {
    return PublicCompanyState(
      isLoading: isLoading ?? this.isLoading,
      publicCompanies: publicCompanies ?? this.publicCompanies,
      newCompanies: newCompanies ?? this.newCompanies,
      filterCompanies: filterCompanies ?? this.filterCompanies,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      companyCurrentPage: companyCurrentPage ?? this.companyCurrentPage,
      companyPageSize: companyPageSize ?? this.companyPageSize,
      newCompanyCurrentPage:
          newCompanyCurrentPage ?? this.newCompanyCurrentPage,
      newCompanyPageSize: newCompanyPageSize ?? this.newCompanyPageSize,
      isFilterEnable: isFilterEnable ?? this.isFilterEnable,
      companyFilterValuesModel:
          companyFilterValuesModel ?? this.companyFilterValuesModel,
      filterCurrentPage: filterCurrentPage ?? this.filterCurrentPage,
      filterPageSize: filterPageSize ?? this.filterPageSize,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        publicCompanies,
        newCompanies,
        filterCompanies,
        isMoreLoading,
        companyCurrentPage,
        companyPageSize,
        newCompanyCurrentPage,
        newCompanyPageSize,
        isFilterEnable,
        companyFilterValuesModel,
        filterCurrentPage,
        filterPageSize,
      ];
}

final class PublicCompanyInitial extends PublicCompanyState {}
