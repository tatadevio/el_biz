part of 'search_tender_bloc.dart';

sealed class SearchTenderEvent extends Equatable {
  const SearchTenderEvent();

  @override
  List<Object> get props => [];
}

class ClearSearchTenderList extends SearchTenderEvent {}

class SearchTender extends SearchTenderEvent {
  final String search;
  final int currentPage;

  const SearchTender({required this.search, required this.currentPage});

  @override
  List<Object> get props => [search, currentPage];
}

class ToggleSearchTenderFavorite extends SearchTenderEvent {
  final int tenderId;
  final BuildContext context;
  const ToggleSearchTenderFavorite(this.tenderId, this.context);

  @override
  List<Object> get props => [tenderId, context];
}
