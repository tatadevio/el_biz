part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final bool isShowCategories;
  final List<String> selectedKeywords;
  final List<String> selectedMaterial;
  final List<XFile> pickedLogo;
  final String selectedSubCatId;
  final String selectedSubCatName;
  final bool isCatLoading;
  final String currentQuery;
  final List<ProductItem> catProductItem;
  final String selectedCityName;
  final String selectedCity;
  final String sortType;
  final List<CategoriesItem> filterCategories;

  const ProductState({
    this.isLoading = false,
    this.isGridView = true,
    this.isShowCategories = false,
    this.selectedKeywords = const [],
    this.selectedMaterial = const [],
    this.pickedLogo = const [],
    this.selectedSubCatId = '',
    this.selectedSubCatName = '',
    this.isCatLoading = false,
    this.currentQuery = '',
    this.catProductItem = const [],
    this.selectedCityName = '',
    this.selectedCity = '',
    this.sortType = '',
    this.filterCategories = const [],
  });

  ProductState copywith({
    bool? isLoading,
    bool? isGridView,
    bool? isShowCategories,
    List<String>? selectedKeywords,
    List<String>? selectedMaterial,
    List<XFile>? pickedLogo,
    String? selectedSubCatId,
    String? selectedSubCatName,
    bool? isCatLoading,
    String? currentQuery,
    List<ProductItem>? catProductItem,
    String? selectedCityName,
    String? selectedCity,
    String? sortType,
    List<CategoriesItem>? filterCategories,
  }) {
    return ProductState(
        isLoading: isLoading ?? this.isLoading,
        isGridView: isGridView ?? this.isGridView,
        isShowCategories: isShowCategories ?? this.isShowCategories,
        selectedKeywords: selectedKeywords ?? this.selectedKeywords,
        selectedMaterial: selectedMaterial ?? this.selectedMaterial,
        pickedLogo: pickedLogo ?? this.pickedLogo,
        selectedSubCatId: selectedSubCatId ?? this.selectedSubCatId,
        selectedSubCatName: selectedSubCatName ?? this.selectedSubCatName,
        isCatLoading: isCatLoading ?? this.isCatLoading,
        currentQuery: currentQuery ?? this.currentQuery,
        catProductItem: catProductItem ?? this.catProductItem,
        selectedCityName: selectedCityName ?? this.selectedCityName,
        selectedCity: selectedCity ?? this.selectedCity,
        sortType: sortType ?? this.sortType,
        filterCategories: filterCategories ?? this.filterCategories);
  }

  bool keywordsSelected(String keyword) {
    if (selectedKeywords.isEmpty) {
      return false;
    }
    if (selectedKeywords.contains(keyword)) {
      return true;
    } else {
      return false;
    }
  }

  bool materialSelected(String material) {
    if (selectedMaterial.isEmpty) {
      return false;
    }
    if (selectedMaterial.contains(material)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<Object> get props =>
      [isLoading, isGridView, isShowCategories, selectedKeywords, selectedMaterial, pickedLogo, selectedSubCatId, selectedSubCatName, isCatLoading, currentQuery, catProductItem, selectedCityName, selectedCity, sortType, filterCategories];
}
