import 'package:get/get.dart';

import '../data/model/base/response_model.dart';
import '../data/model/response/product/product_model.dart';
import '../data/repo/product_repo.dart';
import 'auth_controller.dart';
import 'post_ad_controller.dart';
import 'product_detail_controller.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;

  ProductController(this.productRepo);

  bool _isLoading = false;
  bool _isGridView = true;
  bool _isShowCategories = false;
  List<String> _selectedKeywords = [];
  List<String> _selectedMaterial = [];

  bool get isGridView => _isGridView;
  bool get isShowCategories => _isShowCategories;
  List<String> get selectedKeywords => _selectedKeywords;
  List<String> get selectedMaterial => _selectedMaterial;

  void updateGridView(bool gridView) {
    _isGridView = gridView;
    update();
  }

  void updateShowCategories(bool showCategories) {
    _isShowCategories = showCategories;
    update();
  }

  bool keywordSelected(String keyword) {
    if (_selectedKeywords.isEmpty) {
      return false;
    }
    if (_selectedKeywords.contains(keyword)) {
      return true;
    } else {
      return false;
    }
  }

  void updateKeywordSelected(String keyword) {
    if (_selectedKeywords.isEmpty) {
      _selectedKeywords.add(keyword);
    } else {
      if (_selectedKeywords.contains(keyword)) {
        _selectedKeywords.remove(keyword);
      } else {
        _selectedKeywords.add(keyword);
      }
    }
    update();
  }

  bool materialSelected(String material) {
    if (_selectedMaterial.isEmpty) {
      return false;
    }
    if (_selectedMaterial.contains(material)) {
      return true;
    } else {
      return false;
    }
  }

  void updateMaterialSelected(String material) {
    if (_selectedMaterial.isEmpty) {
      _selectedMaterial.add(material);
    } else {
      if (_selectedMaterial.contains(material)) {
        _selectedMaterial.remove(material);
      } else {
        _selectedMaterial.add(material);
      }
    }
    update();
  }

  bool _isFav = false;
  bool _isCatLoading = false;
  bool _searchLoading = false;
  bool _bottomLoading = false;
  final List<ProductItem> _recommendProductItem = [];
  final List<ProductItem> _latestProductItem = [];
  final List<ProductItem> _favProductItem = [];
  final List<ProductItem> _catProductItem = [];
  final List<ProductItem> _likeProductItem = [];
  final List<ProductItem> _searchProductItem = [];
  final List<ProductItem> _relatedProductItem = [];
  final List<int> _favIds = [];
  final List<int> _likeIds = [];
  String _selectedSubCatId = '';
  String _selectedSubCatName = '';
  String _selectedCity = '';
  String _selectedCityName = '';
  String _sortType = '';
  String _selectedCurrency = 'KGS';
  String _currentQuery = '';
  bool _isLatest = false;
  int _showFavSearch = 0;
  int _pageSizeL = 1;
  int _currentPageSizeL = 1;
  int _pageSizeR = 1;
  int _currentPageSizeR = 1;

  int _pageSizeF = 1;
  int _currentPageSizeF = 1;

  List<ProductItem> get recommendProductItem => _recommendProductItem;
  List<ProductItem> get latestProductItem => _latestProductItem;
  List<ProductItem> get favProductItem => _favProductItem;
  List<ProductItem> get likeProductItem => _likeProductItem;
  List<ProductItem> get catProductItem => _catProductItem;
  List<ProductItem> get searchProductItem => _searchProductItem;
  List<ProductItem> get relatedProductItem => _relatedProductItem;
  List<int> get favIds => _favIds;
  List<int> get likeIds => _likeIds;
  String get selectedSubCatId => _selectedSubCatId;
  String get selectedSubCatName => _selectedSubCatName;
  String get selectedCity => _selectedCity;
  String get selectedCityName => _selectedCityName;
  String get sortType => _sortType;
  String get selectedCurrency => _selectedCurrency;
  String get currentQuery => _currentQuery;

  bool get isLoading => _isLoading;
  bool get isCatLoading => _isCatLoading;
  bool get searchLoading => _searchLoading;
  bool get isFav => _isFav;
  bool get isLatest => _isLatest;
  int get showFavSearch => _showFavSearch;
  bool get bottomLoading => _bottomLoading;
  int get pageSizeL => _pageSizeL;
  int get currentPageSizeL => _currentPageSizeL;
  int get pageSizeR => _pageSizeR;
  int get currentPageSizeR => _currentPageSizeR;
  int get pageSizeF => _pageSizeF;
  int get currentPageSizeF => _currentPageSizeF;

  @override
  void onInit() {
    super.onInit();
    getRecommendedProduct(true, 1);
    getLatestProduct(true, 1);
    if (Get.find<AuthController>().isLoggedIn()) {
      getFavProduct(true, 1);
      getLikesProduct();
    }
  }

  Future<void> getRecommendedProduct(bool reload, int pageSize) async {
    if (reload) {
      if (_recommendProductItem.isEmpty) {
        _isLoading = true;
      }
    } else {
      _bottomLoading = true;
    }
    update();

    Response response = await productRepo.getProduct("?recommend=true", pageSize.toString());
    if (response.statusCode == 200) {
      if (reload) {
        _recommendProductItem.clear();
      }
      for (int i = 0; i < ProductListModel.fromJson(response.body).data.items.length; i++) {
        _recommendProductItem.add(ProductListModel.fromJson(response.body).data.items[i]);
      }
      _pageSizeR = ProductListModel.fromJson(response.body).data.totalPages;
      _currentPageSizeR = ProductListModel.fromJson(response.body).data.currentPage;
      update();
    } else {}

    _isLoading = false;
    _bottomLoading = false;
    update();
  }

  Future<void> getRelatedProduct(String id) async {
    _isLoading = true;
    update();
    Response response = await productRepo.getRelatedProduct(id);
    if (response.statusCode == 200) {
      _relatedProductItem.clear();
      _relatedProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      update();
    } else {}

    _isLoading = false;
    _bottomLoading = false;
    update();
  }

  Future<void> getLatestProduct(bool reload, int pageSize) async {
    if (reload) {
      if (_latestProductItem.isEmpty) {
        _isLoading = true;
      }
    } else {
      _bottomLoading = true;
    }
    update();
    Response response = await productRepo.getProduct("?sort_by=latest", pageSize.toString());
    if (response.statusCode == 200) {
      if (reload) {
        _latestProductItem.clear();
      }
      for (int i = 0; i < ProductListModel.fromJson(response.body).data.items.length; i++) {
        _latestProductItem.add(ProductListModel.fromJson(response.body).data.items[i]);
      }
      _pageSizeL = ProductListModel.fromJson(response.body).data.totalPages;
      _currentPageSizeL = ProductListModel.fromJson(response.body).data.currentPage;
      update();
    } else {}

    _isLoading = false;
    _bottomLoading = false;
    update();
  }

  Future<void> getProductWithCat(String id, String name) async {
    _selectedSubCatId = id;
    _selectedSubCatName = name;
    _isCatLoading = true;
    update();
    Response response = await productRepo.getProductWithCatId(id);
    if (response.statusCode == 200) {
      _currentQuery = "?category_id=$id";
      _catProductItem.clear();
      _catProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      update();
    } else {}
    _isCatLoading = false;
    update();
  }

  Future<void> searchProduct(String query) async {
    _searchLoading = true;
    update();
    Response response = await productRepo.searchProduct(query);
    if (response.statusCode == 200) {
      _searchProductItem.clear();
      _searchProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      update();
    } else {}
    _searchLoading = false;
    update();
  }

  Future<ResponseModel> getFilterProduct(String minPrice, String maxPrice) async {
    ResponseModel responseModel;
    _isCatLoading = true;
    update();
    Response response =
        await productRepo.getFilterProduct(_selectedSubCatId, _sortType, minPrice, maxPrice, Get.find<PostAdController>().addAttributeList, Get.find<PostAdController>().addAttributeListMulti, Get.find<PostAdController>().addAttributeListInt);
    if (response.statusCode == 200) {
      _currentQuery = "?category_id=$_selectedSubCatId&sort_by=$_sortType&min_price=$minPrice&max_price=$maxPrice";
      responseModel = ResponseModel(true, "Success");
      _catProductItem.clear();
      _catProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isCatLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getFilterProductWithQuery(String query) async {
    ResponseModel responseModel;
    _isCatLoading = true;
    update();
    Response response = await productRepo.getFilterProductWithFav(query);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _catProductItem.clear();
      _catProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isCatLoading = false;
    update();
    return responseModel;
  }

  Future<void> getFavProduct(bool reload, int pageSize) async {
    if (reload) {
      if (_favProductItem.isEmpty) {
        _isFav = true;
      }
    } else {
      _bottomLoading = true;
    }
    update();
    Response response = await productRepo.getFavProduct(pageSize.toString());
    if (response.statusCode == 200) {
      if (reload) {
        _favProductItem.clear();
        _favIds.clear();
      }
      for (int i = 0; i < ProductListModel.fromJson(response.body).data.items.length; i++) {
        _favProductItem.add(ProductListModel.fromJson(response.body).data.items[i]);
      }
      _pageSizeF = ProductListModel.fromJson(response.body).data.totalPages;
      _currentPageSizeF = ProductListModel.fromJson(response.body).data.currentPage;
      update();
    } else {}

    for (int i = 0; i < _favProductItem.length; i++) {
      _favIds.add(_favProductItem[i].id);
    }

    _isFav = false;
    _bottomLoading = false;
    update();
  }

  Future<void> addToFav(String id, ProductItem item) async {
    //_isFav = true;
    update();
    _favIds.add(int.parse(id));
    Get.find<ProductDetailController>().changeFavQuantity(true);
    update();
    Response response = await productRepo.addToFav(id);
    if (response.statusCode == 200) {
      //getFavProduct(true, 1);
      _favProductItem.add(item);
      update();
    } else {}
    _isFav = false;
    update();
  }

  Future<void> removeFromFav(String id, ProductItem item) async {
    //  _isFav = true;
    _favIds.remove(int.parse(id));
    Get.find<ProductDetailController>().changeFavQuantity(false);
    update();
    Response response = await productRepo.removeFromFav(id);
    if (response.statusCode == 200) {
      _favProductItem.remove(item);
      //  getFavProduct(true, 1);
      update();
    } else {}
    _isFav = false;
    update();
  }

  Future<void> getLikesProduct() async {
    _isLoading = true;
    update();
    Response response = await productRepo.getLikesProduct();
    if (response.statusCode == 200) {
      _likeIds.clear();
      _likeProductItem.clear();
      _likeProductItem.addAll(ProductListModel.fromJson(response.body).data.items);
      for (int i = 0; i < ProductListModel.fromJson(response.body).data.items.length; i++) {
        _likeIds.add(ProductListModel.fromJson(response.body).data.items[i].id);
      }
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> addToLike(String id) async {
    _likeIds.add(int.parse(id));
    _isLoading = true;
    update();
    Response response = await productRepo.addToLike(id);
    if (response.statusCode == 200) {
      Get.find<ProductDetailController>().productDetailModel!.likes = Get.find<ProductDetailController>().productDetailModel!.likes + 1;
      getLikesProduct();
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> removeFromLikes(String id) async {
    _likeIds.remove(int.parse(id));
    _isLoading = true;
    update();
    Response response = await productRepo.removeFromLike(id);
    if (response.statusCode == 200) {
      Get.find<ProductDetailController>().productDetailModel!.likes = Get.find<ProductDetailController>().productDetailModel!.likes - 1;
      getLikesProduct();
      update();
    } else {}

    _isLoading = false;
    update();
  }

  void updateNameId(String id, String name, {bool callProduct = false}) {
    _selectedSubCatId = id;
    _selectedSubCatName = name;
    if (callProduct) {
      getProductWithCat(_selectedSubCatId, _selectedSubCatName);
    }
    update();
  }

  void changeCityId(String id, String name) {
    _selectedCity = id;
    _selectedCityName = name;
    update();
  }

  void setSortType(String id) {
    _sortType = id;
    update();
  }

  void selectCurrency(String value) {
    _selectedCurrency = value;
    update();
  }

  void changeStatus(bool value) {
    _isLatest = value;
    update();
  }

  void changeStatusSearch(int value) {
    _showFavSearch = value;
    update();
  }

  void showBottomLoader() {
    _bottomLoading = true;
    update();
  }
}
