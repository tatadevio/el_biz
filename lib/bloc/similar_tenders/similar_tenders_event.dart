part of 'similar_tenders_bloc.dart';

sealed class SimilarTendersEvent extends Equatable {
  const SimilarTendersEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarTenders extends SimilarTendersEvent {
  final String tenderId;
  final int currentPage;
  const GetSimilarTenders({required this.tenderId, required this.currentPage});

  @override
  List<Object> get props => [tenderId, currentPage];
}

class ToggleFavoriteSimilarTenderInList extends SimilarTendersEvent {
  final String tenderId;
  const ToggleFavoriteSimilarTenderInList({required this.tenderId});

  @override
  List<Object> get props => [tenderId];
}

class ToggleFavoriteSimilarTender extends SimilarTendersEvent {
  final String tenderId;
  final BuildContext context;
  const ToggleFavoriteSimilarTender(
      {required this.tenderId, required this.context});

  @override
  List<Object> get props => [tenderId, context];
}
