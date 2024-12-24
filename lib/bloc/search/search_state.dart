part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool isSearchProducts ;
  const SearchState({this.isSearchProducts = true});

  SearchState copyWith({bool? isSearchProducts}){
    return SearchState(isSearchProducts: isSearchProducts ?? this.isSearchProducts);
  }

  @override
  List<Object> get props => [isSearchProducts];
}

// final class SearchInitial extends SearchState {}
