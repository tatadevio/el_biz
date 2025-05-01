part of 'material_bloc.dart';

class MaterialState extends Equatable {
  final bool isLoading;
  final int pageSize;
  final int currentPage;
  final List<MaterialItem> materialItems;
  final bool isLoadingMore;
  const MaterialState({
    this.isLoading = false,
    this.pageSize = 1,
    this.currentPage = 1,
    this.materialItems = const [],
    this.isLoadingMore = false,
  });

  MaterialState copyWith(
      {bool? isLoading,
      int? pageSize,
      int? currentPage,
      List<MaterialItem>? materialItems,
      bool? isLoadingMore}) {
    return MaterialState(
      isLoading: isLoading ?? this.isLoading,
      pageSize: pageSize ?? this.pageSize,
      currentPage: currentPage ?? this.currentPage,
      materialItems: materialItems ?? this.materialItems,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, pageSize, currentPage, materialItems, isLoadingMore];
}

final class MaterialInitial extends MaterialState {}

// class MaterialLoading extends MaterialState {}

// class MaterialSuccess extends MaterialState {
//   final List<MaterialItem> materialItems;
//   const MaterialSuccess(this.materialItems);
// }

class MaterialError extends MaterialState {
  final String error;
  const MaterialError(this.error);
}
