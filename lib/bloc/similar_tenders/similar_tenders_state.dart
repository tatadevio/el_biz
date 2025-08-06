part of 'similar_tenders_bloc.dart';

 class SimilarTendersState extends Equatable {
    final bool isLoading;
  final List<TenderItem> similarTenders;
  final bool isMoreLoading;
  final int currentPage;
  final int totalPages;
  const SimilarTendersState({
    this.isLoading = false,
    this.similarTenders = const [],
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  SimilarTendersState copyWith({
    bool? isLoading,
    List<TenderItem>? similarTenders,
    bool? isMoreLoading,
    int? currentPage,
    int? totalPages,
  }) {
    return SimilarTendersState(
      isLoading: isLoading ?? this.isLoading,
      similarTenders: similarTenders ?? this.similarTenders,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [isLoading, similarTenders, isMoreLoading, currentPage, totalPages];
}

final class SimilarTendersInitial extends SimilarTendersState {}
