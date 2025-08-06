part of 'similar_companies_bloc.dart';

class SimilarCompaniesState extends Equatable {
  final bool isLoading;
  final List<CompanyItem> similarCompanies;
  final bool isMoreLoading;
  final int currentPage;
  final int totalPages;

  const SimilarCompaniesState({
    this.isLoading = false,
    this.similarCompanies = const [],
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  SimilarCompaniesState copyWith({
    bool? isLoading,
    List<CompanyItem>? similarCompanies,
    bool? isMoreLoading,
    int? currentPage,
    int? totalPages,
  }) {
    return SimilarCompaniesState(
      isLoading: isLoading ?? this.isLoading,
      similarCompanies: similarCompanies ?? this.similarCompanies,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, similarCompanies, isMoreLoading, currentPage, totalPages];
}

final class SimilarCompaniesInitial extends SimilarCompaniesState {}
