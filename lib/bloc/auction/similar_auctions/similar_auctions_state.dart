part of 'similar_auctions_bloc.dart';

class SimilarAuctionsState extends Equatable {
  final bool isLoading;
  final List similarAuctions;
  final bool isMoreLoading;
  final int currentPage;
  final int totalPages;
  const SimilarAuctionsState({
    this.isLoading = false,
    this.similarAuctions = const [],
    this.isMoreLoading = false,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  SimilarAuctionsState copyWith({
    bool? isLoading,
    List? similarAuctions,
    bool? isMoreLoading,
    int? currentPage,
    int? totalPages,
  }) {
    return SimilarAuctionsState(
      isLoading: isLoading ?? this.isLoading,
      similarAuctions: similarAuctions ?? this.similarAuctions,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, similarAuctions, isMoreLoading, currentPage, totalPages];
}

final class SimilarAuctionsInitial extends SimilarAuctionsState {}
