part of 'post_ad_bloc.dart';

class PostAdState extends Equatable {
  final bool isLoading;
  final String selectedCategoryId;
  final String selectedCategory;
  final String selectedCityId;
  final String selectedCityName;
  final String selectedCategoryName;
  const PostAdState({this.isLoading = false, this.selectedCategoryId = '', this.selectedCategory = '', this.selectedCityId = '', this.selectedCityName = '', this.selectedCategoryName = ''});

  PostAdState copyWith({bool? isLoading, String? selectedCategoryId, String? selectedCategory, String? selectedCityId, String? selectedCityName, String? selectedCategoryName}) {
    return PostAdState(
      isLoading: isLoading ?? this.isLoading,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      selectedCityName: selectedCityName ?? this.selectedCityName,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
    );
  }

  @override
  List<Object> get props => [isLoading, selectedCategoryId, selectedCategory, selectedCityId, selectedCityName];
}

// final class PostAdInitial extends PostAdState {}
