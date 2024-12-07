import 'package:get/get.dart';

import '../data/model/base/response_model.dart';
import '../data/model/response/search_model.dart';
import '../data/model/response/seller/follow_user_model.dart';
import '../data/repo/favorite_repo.dart';

class FavoriteController extends GetxController implements GetxService {
  final FavoriteRepo favoriteRepo;

  FavoriteController(this.favoriteRepo);

  bool _isLoading = false;
  bool _isShowCategories = false;

  bool get isShowCategories => _isShowCategories;

  void updateShowCategories(bool showCategories) {
    _isShowCategories = showCategories;
    update();
  }

  List<SearchItem> _searchItem = [];

  bool get isLoading => _isLoading;
  List<SearchItem> get searchItem => _searchItem;

  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  Future<ResponseModel> getFavorite() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();

    Response response = await favoriteRepo.getSearchFavorite();
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _searchItem.clear();
      _searchItem.addAll(SearchResultModel.fromJson(response.body).data.items);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> saveSearch(String title, String path, String type) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await favoriteRepo.saveSearch(title, path, type);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      print(response.body);
      getFavorite();
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteSearch(String title) async {
    String id = '';

    for (int i = 0; i < _searchItem.length; i++) {
      if (_searchItem[i].title == title) {
        id = _searchItem[i].id.toString();
      }
    }
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await favoriteRepo.deleteSearch(id);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      print(response.body);
      getFavorite();
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteSearchWithId(String id) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await favoriteRepo.deleteSearch(id);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      print(response.body);
      getFavorite();
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  List<FollowUserItems> _favoriteUsersList = [];
  List<FollowUserItems> get favoriteUsersList => _favoriteUsersList;

  Future<void> getFavoriteUsers({int? page = 1, bool reload = true}) async {
    if ((page == null || page == 1) && reload == true) {
      _isLoading = true;
    }
    update();
    Response response = await favoriteRepo.getFavoiriteUsers(page: page);
    print('response of the favorite users == ${response.body}');
    if (response.statusCode == 200) {
      final followUserModel = FollowUserModel.fromJson(response.body);
      if (page == null || page == 1) {
        _favoriteUsersList.clear();
      }
      _favoriteUsersList.addAll(followUserModel.data!.items!);
    } else {}
    _isLoading = false;
    update();
  }

  Future<void> followSeller(
    String id,
    int index,
  ) async {
    print('calling fallow seller api');
    _favoriteUsersList[index].isFollow = true;
    // _isFollowSeller = true;
    update();
    Response response = await favoriteRepo.followSeller(id);
    if (response.statusCode == 200) {
    } else {
      _favoriteUsersList[index].isFollow = false;
    }
    update();
  }

  Future<void> unFollowSeller(String id, int index) async {
    print('calling un-fallow seller api');

    _favoriteUsersList[index].isFollow = false;
    update();
    Response response = await favoriteRepo.unFollowSeller(id);
    if (response.statusCode == 200) {
    } else {
      _favoriteUsersList[index].isFollow = true;
    }
    update();
  }

  isFavoriteSearch(String title) {
    for (int i = 0; i < _searchItem.length; i++) {
      return _searchItem[i].title.contains(title);
    }
  }
}
