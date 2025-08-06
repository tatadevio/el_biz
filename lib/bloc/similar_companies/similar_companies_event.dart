part of 'similar_companies_bloc.dart';

sealed class SimilarCompaniesEvent extends Equatable {
  const SimilarCompaniesEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarCompanies extends SimilarCompaniesEvent {
  final String companyId;
  final int currentPage;
  const GetSimilarCompanies({required this.companyId, required this.currentPage});

  @override
  List<Object> get props => [companyId, currentPage];
}
