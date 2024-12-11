// import 'package:get/get.dart';

// import '../data/model/response/category/category_model.dart';
// import '../data/repo/category_repo.dart';

// class CategoryController extends GetxController implements GetxService {
//   final CategoryRepo categoryRepo;

//   CategoryController(this.categoryRepo);

//   bool _isLoading = false;
//   List<CategoriesItem> _categoryItem = [];
//   List<CategoriesItem> _categoryItemFilter = [];
//   List<CategoriesItem> _singleCategoryItem = [];
//   List<CategoriesItem> _filterCategories = [];

//   List<CategoriesItem> get categoryItem => _categoryItem;
//   List<CategoriesItem> get categoryItemFilter => _categoryItemFilter;
//   List<CategoriesItem> get singleCategoryItem => _singleCategoryItem;
//   List<CategoriesItem> get filterCategories => _filterCategories;

//   bool get isLoading => _isLoading;

//   @override
//   void onInit() {
//     super.onInit();
//     getCategory();
//     getCategoryFilter();
//   }

//   bool isFilterSelectedCategory(CategoriesItem category) {
//     if (_filterCategories.isNotEmpty) {
//       if (_filterCategories.contains(category)) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//     return false;
//   }

//   void updateFilterSelectedCategory(CategoriesItem category) {
//     if (_filterCategories.isNotEmpty) {
//       // if (_filterCategories.contains(category)) {
//       //   print('going to add the category');
//       //   _filterCategories.add(category);
//       // } else {
//       //   print('going to remove the category');
//       //   _filterCategories.remove(category);
//       // }
//       bool isPresent = _filterCategories.any((item) => item.id == category.id && item.name == category.name);

//       if (isPresent) {
//         _filterCategories.add(category);
//       } else {
//         _filterCategories.remove(category);
//       }
//     } else {
//       _filterCategories.add(category);
//     }
//     update();
//   }

//   Future<void> getCategory() async {
//     _isLoading = true;
//     update();
//     Response response = await categoryRepo.getCategory();
//     if (response.statusCode == 200) {
//       _categoryItem.clear();
//       _categoryItem.addAll(CategoryListModel.fromJson(response.body).data.items);
//       print(response.body);
//       update();
//     } else {}

//     _isLoading = false;
//     update();
//   }

//   Future<void> getCategoryFilter() async {
//     _isLoading = true;
//     update();
//     Response response = await categoryRepo.getCategoryFilter();
//     if (response.statusCode == 200) {
//       _categoryItemFilter.clear();
//       _categoryItemFilter.addAll(CategoryListModel.fromJson(response.body).data.items);
//       print(response.body);
//       update();
//     } else {}

//     _isLoading = false;
//     update();
//   }

//   void addSingleCat(CategoriesItem value) {
//     _singleCategoryItem.add(value);
//     update();
//   }
// }
