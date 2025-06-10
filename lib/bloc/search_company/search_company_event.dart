part of 'search_company_bloc.dart';

sealed class SearchCompanyEvent extends Equatable {
  const SearchCompanyEvent();

  @override
  List<Object> get props => [];
}

class ClearSearchCompanyList extends SearchCompanyEvent {}

class SearchCompany extends SearchCompanyEvent {
  final String search;
  final int currentPage;

  const SearchCompany({required this.search, required this.currentPage});

  @override
  List<Object> get props => [search, currentPage];
}
