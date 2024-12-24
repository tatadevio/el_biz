part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeStatusSearch extends SearchEvent {
  final bool showProducts ;
  ChangeStatusSearch(this.showProducts);

  @override
  List<Object> get props => [showProducts];
}