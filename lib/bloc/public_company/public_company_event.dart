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

class UpdateCompanyFilterEnable extends PublicCompanyEvent {
  final bool isEnable;
  const UpdateCompanyFilterEnable(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class FilterPublicCompanyProduct extends PublicCompanyEvent {
  final CompanyFilterValuesModel productFilterValuesModel;
  final int currentPage;
  const FilterPublicCompanyProduct({
    required this.productFilterValuesModel,
    required this.currentPage,
  });

  @override
  List<Object> get props => [
        productFilterValuesModel,
        currentPage,
      ];
}

class ClearPublicCompanyState extends PublicCompanyEvent {}
