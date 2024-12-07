import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../data/model/base/response_model.dart';
import '../data/model/base/timing_date_model.dart';
import '../data/model/response/product/product_model.dart';
import '../data/model/response/seller/company_category_model.dart';
import '../data/model/response/seller/follow_user_model.dart';
import '../data/model/response/seller/seller_info_model.dart';
import '../data/repo/seller_repo.dart';
import 'post_ad_controller.dart';

class SellerController extends GetxController implements GetxService {
  final SellerRepo managerRepo;

  SellerController(this.managerRepo);

  bool _isLoading = false;
  bool _isRegister = false;
  bool _isFav = false;
  bool _isActive = true;
  String _latitude = "0.0";
  String _locationAddress = "";
  String _longitude = "0.0";
  bool _isFollowSeller = false;
  final List<List<String>> _contactList = [[], [], [], [], [], []];
  final List<CompanyCategoryItem> _companyCategory = [];
  CompanyCategoryItem? _selectedCategory;
  final List<String> _timingDays = [];
  final List<DaySchedule> _scheduleTiming = [
    DaySchedule(day: "Monday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Tuesday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Wednesday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Thursday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Friday", openingTime: "09:00", closingTime: "18:00", isOpen: true),
    DaySchedule(day: "Saturday", openingTime: "00:00", closingTime: "00:00", isOpen: false),
    DaySchedule(day: "Sunday", openingTime: "00:00", closingTime: "00:00", isOpen: false),
  ];
  XFile _pickedBanner = XFile("");
  XFile _pickedLogo = XFile("");
  String _companyName = "";
  String _companyAbout = "";
  final List<ProductItem> _sellerProduct = [];
  SellerInfoModel? _sellerInfoModel;

  String get latitude => _latitude;
  String get locationAddress => _locationAddress;
  String get longitude => _longitude;
  String get companyName => _companyName;
  String get companyAbout => _companyAbout;

  bool get isLoading => _isLoading;
  bool get isFav => _isFav;
  bool get isRegister => _isRegister;
  bool get isActive => _isActive;
  bool get isFollowSeller => _isFollowSeller;
  List<ProductItem> get sellerProduct => _sellerProduct;
  List<CompanyCategoryItem> get companyCategory => _companyCategory;
  List<List<String>> get contactList => _contactList;
  CompanyCategoryItem? get selectedCategory => _selectedCategory;
  List<String> get timingDays => _timingDays;
  List<DaySchedule> get scheduleTiming => _scheduleTiming;
  XFile get pickedBanner => _pickedBanner;
  XFile get pickedLogo => _pickedLogo;
  SellerInfoModel? get sellerInfoModel => _sellerInfoModel;

  @override
  onInit() {
    super.onInit();
    getCompanyCategory();
  }

  Future<ResponseModel> getSellerProduct(String id) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await managerRepo.getSellerProductList(id);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _sellerProduct.clear();
      _sellerProduct.addAll(ProductListModel.fromJson(response.body).data.items);

      print(response.body);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getCompanyCategory() async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await managerRepo.getCompanyCategory();
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _companyCategory.clear();
      _companyCategory.addAll(CompanyCategoryModel.fromJson(response.body).data!.items!);
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getSellerInfo(String id, {bool showLoading = true}) async {
    ResponseModel responseModel;
    if (showLoading == true) {
      _isLoading = true;
    }
    update();
    Response response = await managerRepo.getSellerInfoUrl(id);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _sellerInfoModel = SellerInfoModel.fromJson(response.body);
      _isFav = _sellerInfoModel?.data?.isFavorite ?? false;
      _isFollowSeller = sellerInfoModel?.data?.isFollow ?? false;
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void changeStatus(bool value) {
    _isActive = value;
    update();
  }

  Future<ResponseModel> changeAdStatus(String id, String status) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    Response response = await managerRepo.changeStatus(id, status);
    if (response.statusCode == 200) {
      Get.find<PostAdController>().getMyAds("inactive");
      Get.find<PostAdController>().getMyAds("active");
      responseModel = ResponseModel(true, "Success");
      print(response.body);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> registerSeller({
    required String companyName,
    required String companyPhone,
    required String about,
    required String passportId,
    required String issuedBy,
    required String nationality,
  }) async {
    ResponseModel responseModel;
    _isRegister = true;
    update();
    Response response = await managerRepo
        .registerSeller({"company_name": companyName, "company_phone": companyPhone, "company_category_id": _selectedCategory!.id.toString(), "company_about": about, "passport_id": passportId, "issued_by": issuedBy, "nationality": nationality});
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      print(response.body);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isRegister = false;
    update();
    return responseModel;
  }

  void addContact(List<List<String>> value) {
    for (int i = 0; i < value.length; i++) {
      if (value[i].isNotEmpty) {
        // Check if there are existing values for this contact type
        if (_contactList[i].isEmpty) {
          // If empty, add the new values
          _contactList[i] = List.from(value[i]);
        } else {
          // Append new values to the existing list
          _contactList[i].addAll(value[i]);
        }
      }
    }
    update(); // Update the UI
  }

  void addLocationAddress(String address, String latitude, String longitude) {
    _locationAddress = address;
    _longitude = longitude;
    _latitude = latitude;
    update();
  }

  void changeCategory(CompanyCategoryItem? value) {
    _selectedCategory = value;
    update();
  }

  void addAndRemove(String value) {
    if (_timingDays.contains(value)) {
      _timingDays.remove(value);
    } else {
      _timingDays.add(value);
    }
    update();
  }

  void updateDay(int index, bool value) {
    _scheduleTiming[index].isOpen = value;
    for (int i = 0; i < _scheduleTiming.length; i++) {
      print("schedule value ${_scheduleTiming[i].toJson()}");
    }
    update();
  }

  void changeCompanyInfo(String name, String about) {
    _companyName = name;
    _companyAbout = about;
    update();
  }

  Future<void> addToFavSeller(
    String id,
  ) async {
    _isFav = true;
    update();
    Response response = await managerRepo.addToFav(id);
    if (response.statusCode == 200) {
      //getFavProduct(true, 1);
    } else {
      _isFav = false;
    }
    update();
  }

  Future<void> removeFromFav(String id, {ProductItem? item}) async {
    //  _isFav = true;
    // _favIds.remove(int.parse(id));
    // Get.find<ProductDetailController>().changeFavQuantity(false);
    _isFav = false;
    update();
    Response response = await managerRepo.removeFromFav(id);
    if (response.statusCode == 200) {
      // _favProductItem.remove(item);
    } else {
      _isFav = true;
    }
    update();
  }

  Future<void> followSeller(
    String id,
  ) async {
    _isFollowSeller = true;
    update();
    Response response = await managerRepo.followSeller(id);
    if (response.statusCode == 200) {
      //getFavProduct(true, 1);
    } else {
      _isFollowSeller = false;
    }
    update();
  }

  Future<void> unFollowSeller(String id) async {
    _isFollowSeller = false;
    update();
    Response response = await managerRepo.unFollowSeller(id);
    if (response.statusCode == 200) {
      // _favProductItem.remove(item);
    } else {
      _isFollowSeller = true;
    }
    update();
  }

  Future<void> deleteFollower(String id) async {
    _isFollowersLoading = true;
    update();
    Response response = await managerRepo.deleteFollower(id);
    _isFollowersLoading = false;
    if (response.statusCode == 200) {
      // _favProductItem.remove(item);
    } else {
      // _isFollowSeller = true;
    }
    update();
  }

  bool _isFollowersLoading = false;
  bool get isFollowersLoading => _isFollowersLoading;

  bool _isFollowingsLoading = false;
  bool get isFollowingsLoading => _isFollowingsLoading;

  FollowUserModel _followUserModel = FollowUserModel();
  FollowUserModel get followUserModel => _followUserModel;

  List<FollowUserItems> _myFollowersList = [];
  List<FollowUserItems> get myFollowersList => _myFollowersList;

  List<FollowUserItems> _myFollowingsList = [];
  List<FollowUserItems> get myFollowingsList => _myFollowingsList;

  Future<void> getMyFollowers({int? page, bool reload = true, bool isSeller = false, int? sellerId}) async {
    if ((page == null || page == 1) && reload == true) {
      _isFollowersLoading = true;
    }
    // _isLoading = true;
    update();
    Response response;
    if (isSeller == false) {
      response = await managerRepo.getMyFollowers(page);
    } else {
      response = await managerRepo.getSellerFollowers(page, sellerId!);
    }

    if (response.statusCode == 200) {
      _followUserModel = FollowUserModel.fromJson(response.body);
      if (page == null || page == 1) {
        _myFollowersList.clear();
      }
      _myFollowersList.addAll(_followUserModel.data!.items!);
    } else {
      // responseModel = ResponseModel(false, "Failure");
    }
    _isFollowersLoading = false;
    update();
    // return responseModel;
  }

  Future<void> getMyFollowings({int? page, bool reload = true, bool isSeller = false, int? sellerId}) async {
    if ((page == null || page == 1) && reload == true) {
      _isFollowingsLoading = true;
    }
    update();

    Response response;

    if (isSeller == false) {
      response = await managerRepo.getMyFollowings(page);
    } else {
      response = await managerRepo.getSellerFollowings(page, sellerId!);
    }

    if (response.statusCode == 200) {
      _followUserModel = FollowUserModel.fromJson(response.body);
      if (page == null || page == 1) {
        _myFollowingsList.clear();
      }
      _myFollowingsList.addAll(_followUserModel.data!.items!);
    } else {
      // responseModel = ResponseModel(false, "Failure");
    }
    _isFollowingsLoading = false;
    update();
    // return responseModel;
  }
}
