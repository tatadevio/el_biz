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

class SearchProduct extends SearchEvent {
  final String search;
  final int currentPage;

  const SearchProduct({required this.search, required this.currentPage});

  @override
  List<Object> get props => [search, currentPage];
}

class ToggleFavoriteSearchProduct extends SearchEvent {
  final int productId;
  final BuildContext context;
  const ToggleFavoriteSearchProduct({required this.productId, required  this.context});

  @override
  List<Object> get props => [productId, context];
}
