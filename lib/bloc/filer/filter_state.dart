part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final bool isLoading;
  final List<CategoriesItem> categories;
  const FilterState({
    this.isLoading = false,
    this.categories = const [],
  });

  FilterState copyWith({bool? isLoading, List<CategoriesItem>? categories}) {
    return FilterState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [isLoading, categories];
}

// final class FilterInitial extends FilterState {}
