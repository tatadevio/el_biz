import 'package:get/get.dart';

import '../data/model/response/banners_model.dart';
import '../data/model/response/homepage_model.dart';
import '../data/model/response/product/product_model.dart';
import '../data/repo/home_repo.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController(this.homeRepo);

  bool _isLoading = false;
  int _products = 0;
  int _users = 0;
  int _posts = 0;
  List<BannersItem> _bannersItem = [];
  List<ProductItem> _storyProductList = [];
  HomePageModel? _homePageModel;
  bool _noInternet = false;

  List<ProductItem> get storyProductList => _storyProductList;

  bool get isLoading => _isLoading;
  int get products => _products;
  int get users => _users;
  int get posts => _posts;
  List<BannersItem> get bannersItem => _bannersItem;
  HomePageModel? get homePageModel => _homePageModel;
  bool get noInternet => _noInternet;

  @override
  void onInit() {
    super.onInit();
    getHomeData();
    getBanners();
    getStoriesList();
  }

  Future<void> getHomeData() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getHomeData();
    if (response.statusCode == 200) {
      _homePageModel = HomePageModel.fromJson(response.body);
      print("home page data");
      print(_homePageModel?.toJson());
      update();
    } else {}

    _isLoading = false;
    update();
  }

  Future<void> getBanners() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getBanners();
    if (response.statusCode == 200) {
      _bannersItem.addAll(BannersModel.fromJson(response.body).data.items);
      print(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }

  void updateConnection(bool value) {
    _noInternet = value;
    update();
  }

  Future<void> getStoriesList() async {
    _isLoading = true;
    update();
    Response response = await homeRepo.getStoryList();
    if (response.statusCode == 200) {
      if (response.body['data']['items'].isNotEmpty) {
        _storyProductList.clear();
        for (int i = 0; i < response.body['data']['items'].length; i++) {
          _storyProductList.add(ProductItem.fromJson(response.body['data']['items'][i]));
        }
      }
      print(response.body);
      update();
    } else {}

    _isLoading = false;
    update();
  }
}
