import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/base/response_model.dart';
import '../data/model/response/userinfo_model.dart';
import '../data/repo/user_repo.dart';
import '../helper/route_helper.dart';
import '../utils/firestore_constants.dart';
import '../view/base/custom_toast.dart';
import 'auth_controller.dart';
import 'seller_controller.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  final SharedPreferences prefs;

  UserController(this.userRepo, this.prefs);

  bool _isLoading = false;
  bool _updating = false;
  UserInfoModel? _userInfoModel;
  XFile? _pickedImage;
  String _countryCode = "";

  bool get isLoading => _isLoading;
  bool get updating => _updating;
  UserInfoModel? get userInfoModel => _userInfoModel;
  XFile? get pickedImage => _pickedImage;
  // var _auth = FirebaseAuth.instance;
  // late Rx<User?> firebaseUser;
  // var verificationId = ''.obs;
  String _phoneNumber = '';
  // String _firebaseId = '';
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var credential;
  String get countryCode => _countryCode;

  String get phoneNumber => _phoneNumber;
  // String get firebaseId => _firebaseId;

  @override
  void onInit() {
    super.onInit();
    if (Get.find<AuthController>().isLoggedIn()) {
      getUserInfo(false);
    }
  }

  Future<ResponseModel> getUserInfo(bool fromUpdate) async {
    ResponseModel responseModel;

    _pickedImage = XFile("");
    _isLoading = true;
    update();
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      _userInfoModel = UserInfoModel.fromJson(response.body);
      print("user id is${_userInfoModel!.data.id.toString()}");
      if (_userInfoModel!.data.name.isEmpty) {
        // Get.to(() => EditProfile(
        //       isRegister: true,
        //       phoneNumber: _userInfoModel!.data.phone,
        //     ));
      } else {
        Get.find<SellerController>().getSellerInfo(_userInfoModel!.data.id.toString());
      }
      _countryCode = _userInfoModel!.data.countryCode;
      print(response.body);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateProfile(String name, String phone, String email) async {
    ResponseModel responseModel;
    _updating = true;
    update();
    print("name is $name");
    Response response = await userRepo.editProfile(name, phone, email, _countryCode);

    print(response.body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      getUserInfo(true);
      print(response.body);
      update();
    } else {
      responseModel = ResponseModel(false, "Failure");
    }
    _updating = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteMyAccount() async {
    ResponseModel responseModel;
    Response response = await userRepo.deleteAccount();
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Success");
      showShortToast("Successfully deleted");
    } else {
      responseModel = ResponseModel(true, 'Failure');
      showShortToast("something_went_wrong".tr);
    }
    return responseModel;
  }

  void pickImage() async {
    _pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
    if (_pickedImage!.path.isNotEmpty) {
      updateImage(_pickedImage!);
    }
  }

  Future updateImage(XFile image) async {
    _updating = true;
    update();
    dynamic response = await userRepo.updateProfileImage(image);
    Map map = jsonDecode(response.body);
    showShortToast(map["message"]);
    getUserInfo(true);
    _updating = false;
    update();
  }

  void updateCountryCode(String code) {
    _countryCode = code;
    update();
  }
}
