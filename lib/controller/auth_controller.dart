import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../data/model/base/response_model.dart';
import '../data/repo/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _verifyingPhone = false;
  bool _verifyingEmail = false;
  bool _isOtpLoading = false;
  String _countryCode = "+996";
  // final _auth = FirebaseAuth.instance;
  // late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  String _phoneNumber = '';
  String _firebaseId = '';
  String _googleId = "";
  String _accessToken = "";
  String _name = "";
  String _photoUrl = "";
  String _email = "";
  int _selectedIndex = 0;
  String _appleId = "";
  String _appleEmail = "";

  bool get isLoading => _isLoading;
  bool get verifyingPhone => _verifyingPhone;
  bool get isOtpLoading => _isOtpLoading;
  bool get verifyingEmail => _verifyingEmail;
  String get countryCode => _countryCode;
  String get phoneNumber => _phoneNumber;
  String get firebaseId => _firebaseId;
  String get googleId => _googleId;
  String get accessToken => _accessToken;
  String get name => _name;
  String get photoUrl => _photoUrl;
  String get email => _email;
  int get selectedIndex => _selectedIndex;
  String get appleId => _appleId;
  String get appleEmail => _appleEmail;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    print("index is $_selectedIndex");
    update();
  }

  void updateLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<ResponseModel> phoneAuthentication(String phoneNumber, String type) async {
    ResponseModel responseModel;
    responseModel = ResponseModel(false, "Failure");
    _phoneNumber = phoneNumber;
    _isLoading = true;
    print('this is phone number : $_phoneNumber');
    update();
    // try {
    //   await _auth.verifyPhoneNumber(
    //     timeout: const Duration(seconds: 30),
    //     phoneNumber: phoneNumber,
    //     verificationCompleted: (credential) async {
    //       print("i am verification");
    //       // await _auth.signInWithCredential(credential);
    //     },
    //     codeSent: (verificationId, resendToken) {
    //       this.verificationId.value = verificationId;
    //       _isLoading = false;
    //       update();
    //       print("i am code sent");
    //       responseModel = ResponseModel(true, "Success");
    //       Get.to(() => OtpScreen(
    //             phone: _phoneNumber,
    //             type: type,
    //           ));
    //     },
    //     codeAutoRetrievalTimeout: (verificationId) {
    //       this.verificationId.value = verificationId;
    //       print("code retrival timeout");
    //       responseModel = ResponseModel(false, "Failure");
    //     },
    //     verificationFailed: (FirebaseAuthException e) {
    //       print(e.code);
    //       print(e.message);
    //       print(e);
    //       _isLoading = false;
    //       update();
    //       responseModel = ResponseModel(false, "Failure");
    //       if (e.code == 'invalid-phone-number') {
    //         showShortToast("Указанный номер телефона недействителен");
    //       } else if (e.code == '') {
    //         showShortToast(e.code + e.toString());
    //         //showShortToast("Something went wrong");
    //       } else {
    //         showShortToast(e.code + e.toString());
    //         //showShortToast("Something went wrong");
    //       }
    //     },
    //   );
    // } catch (e) {
    //   print(e);
    // }
    return responseModel;
  }

  Future<bool> verifyOtp(String otp, BuildContext context) async {
    var credential;
    _isOtpLoading = true;
    update();
    // try {
    //   credential = await _auth.signInWithCredential(
    //       PhoneAuthProvider.credential(
    //           verificationId: verificationId.value, smsCode: otp));
    //   _firebaseId = credential.user!.uid;
    // } on FirebaseAuthException catch (e) {
    //   credential = null;
    //   showShortToast("This issue ${e.message}");

    //   popUpAlert(context, e.message!, Colors.red,
    //       firebaseError: true, code: e.code);
    //   print(e);
    // }
    _isOtpLoading = false;
    update();

    return credential == null
        ? false
        : credential.user != null
            ? true
            : false;
  }

  // Future<ResponseModel> loginWithOtp() async {
  //   print("i am coming");
  //   _isOtpLoading = true;
  //   update();
  //   Response response = await authRepo.loginViaPhone(
  //     _phoneNumber,
  //     _countryCode,
  //     _firebaseId,
  //   );
  //   ResponseModel responseModel;
  //   print(response.statusCode);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     authRepo.saveUserToken(response.body["data"]["token"]);
  //     authRepo.updateToken(response.body['data']['user']['id'].toString());
  //     print("registered is ${response.body['data']['user']['registered']}");
  //     if (response.body['data']['user']['registered'] == 0) {
  //       Get.to(() => GetStartScreen(
  //             phoneNumber: _phoneNumber,
  //             email: "",
  //             name: "",
  //             type: "1",
  //           ));
  //     } else {
  //       //Get.find<UserInfoController>().getUserInfo();
  //       authRepo.saveUserToken(response.body["data"]["token"]);
  //       authRepo.updateToken(response.body['data']['user']['id'].toString());
  //       HomeScreen.loadData(true);
  //       Get.offAll(() => const DashboardScreen());
  //     }

  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText.toString());
  //   }
  //   _isLoading = false;
  //   _isOtpLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> loginWithExisting() async {
  //   print("i am coming");
  //   _isOtpLoading = true;
  //   update();
  //   Response response = await authRepo.loginViaPhoneExisting(
  //       _phoneNumber, _firebaseId, _email, _countryCode);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     authRepo.saveUserToken(response.body["data"]["token"]);
  //     authRepo.updateToken(response.body['data']['user']['id'].toString());
  //     HomeScreen.loadData(true);
  //     Get.offAll(() => const DashboardScreen());
  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText.toString());
  //   }
  //   _isLoading = false;
  //   _isOtpLoading = false;
  //   update();
  //   return responseModel;
  // }

  void changeAppleId(String val, String email) {
    _appleId = val;
    _appleEmail = email;
    print("apple id  is $_appleId");
    print("apple email  is $_appleEmail");
    update();
  }

  // Future<ResponseModel> loginWithGoogle(String email, String? authId) async {
  //   _accessToken = authId!;
  //   _isLoading = true;
  //   update();
  //   print("$email $authId");
  //   Response response = await authRepo.googleLogin(authId);
  //   ResponseModel responseModel;
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     _isLoading = false;
  //     update();
  //     print(response.body['data']["register"]);
  //     if (response.body['data']["register"] != null &&
  //         response.body['data']["register"]) {
  //       Get.to(() => GetStartScreen(
  //             phoneNumber: "",
  //             email: email,
  //             name: _name,
  //             type: "2",
  //           ));
  //     } else {
  //       print("token is");
  //       print(response.body["data"]["token"]);
  //       authRepo.saveUserToken(response.body["data"]["token"]);
  //       authRepo.updateToken(response.body['data']['user']['id'].toString());
  //       HomeScreen.loadData(true);
  //       Get.offAll(() => const DashboardScreen());
  //     }
  //     responseModel = ResponseModel(true, "Success");
  //   } else {
  //     responseModel = ResponseModel(false, "Failure");
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> loginWithApple(
  //     String email, String? authId, String token) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.appleLogin(
  //     authId!,
  //     token,
  //     email,
  //   );
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     _isLoading = false;
  //     update();
  //     if (response.body['data']["register"] != null &&
  //         response.body['data']["register"]) {
  //       _appleEmail = response.body['data']["email"];
  //       Get.to(() => GetStartScreen(
  //             phoneNumber: "",
  //             email: response.body['data']["email"] ?? "",
  //             name: _name,
  //             type: "3",
  //           ));
  //     } else {
  //       authRepo.saveUserToken(response.body["data"]["token"]);
  //       authRepo.updateToken(response.body['data']['user']['id'].toString());
  //       HomeScreen.loadData(true);
  //       Get.offAll(() => const DashboardScreen());
  //     }
  //     responseModel = ResponseModel(true, "Success");
  //   } else {
  //     responseModel = ResponseModel(false, "Failure");
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> registration(String fName, String email) async {
  //   print("i am coming");
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.register(fName, email, _countryCode);
  //   ResponseModel responseModel;

  //   if (response.statusCode == 200) {
  //     FirebaseMessaging.instance
  //         .subscribeToTopic('normal_user')
  //         .then((value) => print("Subscribed to Normal"));
  //     HomeScreen.loadData(true);
  //     responseModel = ResponseModel(true, "Success");
  //   } else {
  //     responseModel = ResponseModel(false, "Failure");
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> verifyPhoneGoogle(
  //     String name, String phone, String email) async {
  //   _isLoading = true;
  //   update();
  //   _email = email;
  //   Response response = await authRepo.checkVerifyPhone({
  //     "phone": phone,
  //     "name": name,
  //     "email": email,
  //     "token": _accessToken,
  //     "type": "google",
  //     "country_code": _countryCode
  //   });
  //   ResponseModel responseModel;

  //   if (response.statusCode == 200) {
  //     if (response.body["data"]["account_exist"]) {
  //       showShortToast(
  //           "Этот номер телефона уже существует в другой учетной записи");
  //       Get.to(
  //           () => VerifyPhoneScreen(phone: phone.replaceAll(_countryCode, "")));
  //     } else {
  //       authRepo.saveUserToken(response.body["data"]["token"]);
  //       authRepo.updateToken(response.body['data']['user']['id'].toString());
  //       HomeScreen.loadData(true);
  //       Get.offAll(() => const DashboardScreen());
  //     }

  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.body["message"]);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> verifyPhoneApple(
  //     String name, String phone, String email) async {
  //   _isLoading = true;
  //   update();
  //   _email = email;
  //   print("phone number is$phone");
  //   Response response = await authRepo.checkVerifyPhone({
  //     "phone": phone,
  //     "name": name,
  //     "email": _email,
  //     "apple_id": _appleId,
  //     "type": "apple",
  //     "country_code": _countryCode
  //   });
  //   ResponseModel responseModel;

  //   if (response.statusCode == 200) {
  //     if (response.body["data"]["account_exist"]) {
  //       showShortToast(
  //           "Этот номер телефона уже существует в другой учетной записи");
  //       Get.to(
  //           () => VerifyPhoneScreen(phone: phone.replaceAll(_countryCode, "")));
  //     } else {
  //       authRepo.saveUserToken(response.body["data"]["token"]);
  //       authRepo.updateToken(response.body['data']['user']['id'].toString());
  //       HomeScreen.loadData(true);
  //       Get.offAll(() => const DashboardScreen());
  //     }

  //     responseModel = ResponseModel(true, response.body["message"]);
  //   } else {
  //     responseModel = ResponseModel(false, response.body["message"]);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  void updateOtpLoading(bool q) {
    _isOtpLoading = q;
    update();
  }

  void updateCountryCode(String code) {
    _countryCode = code;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  void saveIdAndEmail(String id, String accessT, String email, String name, String photo) {
    _googleId = id;
    _accessToken = accessT;
    _email = email;
    _name = name;
    _photoUrl = photo;
    update();
  }
}
