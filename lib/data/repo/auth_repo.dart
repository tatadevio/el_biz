import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo(this.apiClient, this.sharedPreferences);

  // Future<Response> loginViaPhone(String phone, String code, String id) {
  //   return apiClient.postData(AppConstants.loginViaOtp, {"phone": phone, "country_code": code, "firebase_id": id});
  // }

  // Future<Response> loginViaPhoneExisting(String phone, String id, String email, String countryCode) {
  //   return apiClient.postData(AppConstants.loginWithExistingUrl, {"phone": phone, "firebase_id": id, "email": email, "country_code": countryCode});
  // }

  // // Future<void> updateToken(String id) async {
  // //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  // //   preferences.setBool("new", false);
  // //   String? _deviceToken;
  // //   if (GetPlatform.isIOS) {
  // //     NotificationSettings settings =
  // //         await FirebaseMessaging.instance.requestPermission(
  // //       alert: true,
  // //       announcement: false,
  // //       badge: true,
  // //       carPlay: false,
  // //       criticalAlert: false,
  // //       provisional: false,
  // //       sound: true,
  // //     );
  // //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  // //       _deviceToken = await _saveDeviceToken();
  // //     }
  // //   } else {
  // //     _deviceToken = await _saveDeviceToken();
  // //   }

  // //   apiClient.postData(AppConstants.fcmTokenUrl, {"fcm_token": _deviceToken});

  // //   FirebaseFirestore.instance.collection('users').doc(id).set({
  // //     'user_id': id,
  // //     'fcmToken': _deviceToken,
  // //   }, SetOptions(merge: true));

  // // }

  // Future<Response> googleLogin(String id) async {
  //   log('this is id for google login: $id');

  //   return await apiClient.postData(AppConstants.googleLoginUrl, {"token": id});
  // }

  // Future<Response> appleLogin(String id, String token, String email) async {
  //   return await apiClient.postData(AppConstants.appleLoginUrl, {"apple_id": id, "token": token, "email": email});
  // }

  // Future<Response> checkVerifyPhone(Map data) async {
  //   return await apiClient.postData(
  //     AppConstants.checkPhoneUrl,
  //     data,
  //   );
  // }

  // // Future<String?> _saveDeviceToken() async {
  // //   String? _deviceToken = '@';
  // //   if (GetPlatform.isIOS) {
  // //     try {
  // //       _deviceToken = await FirebaseMessaging.instance.getToken();
  // //     } catch (e) {
  // //       print("Error while fcm");
  // //       print(e);
  // //     }
  // //   } else {
  // //     try {
  // //       _deviceToken = await FirebaseMessaging.instance.getToken();
  // //     } catch (e) {
  // //       print(e);
  // //     }
  // //   }
  // //   if (_deviceToken != null) {
  // //     print('--------Device Token---------- ' + _deviceToken);
  // //   }
  // //   return _deviceToken;
  // // }

  // Future<bool> saveUserToken(String token) async {
  //   apiClient.token = token;
  //   String? lang = sharedPreferences.getString(AppConstants.languageCode);
  //   apiClient.updateHeader(token, lang ?? "ru");
  //   return await sharedPreferences.setString(AppConstants.token, token);
  // }

  // String getUserToken() {
  //   return sharedPreferences.getString(AppConstants.token) ?? "";
  // }

  Future<bool> isLoggedIn() async {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<Response> sendOtp(String phoneNumber) async {
    print("this is phone number: $phoneNumber");
    return await apiClient
        .postData(AppConstants.sendOtpUrl, {"phone": phoneNumber});
  }

  Future<Response> checkUser(String phoneNumber) async {
    return await apiClient
        .postData(AppConstants.checkUserUrl, {"phone": phoneNumber});
  }

  Future<Response> verifyOtp(
      String otpToken, String phone, String otpCode) async {
    return await apiClient.postData(AppConstants.verifyOtpUrl,
        {"otp_token": otpToken, "phone": phone, "otp_code": otpCode});
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.token, token);
    // final sharedPreferences = await SharedPreferences.getInstance();
    String lang =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "ru";

    apiClient.updateHeader(token, lang);
  }

  Future<Response> changePassword(
      String password, String confirmPassword) async {
    return await apiClient.postData(AppConstants.changePasswordUrl, {
      "password": password,
      "password_confirmation": confirmPassword,
    });
  }

  Future<Response> login(String phoneNumber, String password) async {
    return await apiClient.postData(AppConstants.loginUrl, {
      "phone": phoneNumber,
      "password": password,
    });
  }

  Future<void> logout() async {
    await sharedPreferences.remove(AppConstants.token);

    await sharedPreferences.clear();
    apiClient.updateHeader("", "ru");
  }

  Future<Response> deleteAccount() async {
    return await apiClient.deleteData(AppConstants.deleteAccountUrl);
  }

  // Future register(String fName, String email, String countryCode) async {
  //   return apiClient.postData(AppConstants.registration, {
  //     "name": fName,
  //     "email": email,
  //     "country_code": countryCode,
  //   });
  // }

  Future<void> updateToken(String id) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("new", false);
    String? _deviceToken;
    if (GetPlatform.isIOS) {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    } else {
      _deviceToken = await _saveDeviceToken();
    }

    String uID = sharedPreferences.getString("UID") ?? "";
    print("uid is $uID");
    if (uID == "") {
      uID = FirebaseAuth.instance.currentUser?.uid ?? "";
    }

    // FirebaseMessaging.instance.subscribeToTopic('all_users').then((value) => print("Subscribed to all_users"));
    await apiClient.postData(AppConstants.updateFcmTokenUrl,
        {"fcm_token": _deviceToken, "firebase_id": uID});

    FirebaseFirestore.instance.collection('users').doc(id).set({
      'user_id': id,
      'fcmToken': _deviceToken,
    }, SetOptions(merge: true));
    // subscribeToTopic(AppConstants.newsLetterTopic);
  }

  // Future<void> updateFirebaseIdAndToken(
  //     String userId, String userFirebaseId) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool("new", false);
  //   String? _deviceToken;

  //   _deviceToken = await _saveDeviceToken();

  //   // FirebaseMessaging.instance.subscribeToTopic('all_users').then((value) => print("Subscribed to all_users"));
  //   await apiClient.postData(AppConstants.updateFcmTokenUrl,
  //       {"fcm_token": _deviceToken, "firebase_id": userFirebaseId});

  //   FirebaseFirestore.instance.collection('users').doc(userId).set({
  //     'user_id': userId,
  //     'fcmToken': _deviceToken,
  //   }, SetOptions(merge: true));
  //   // subscribeToTopic(AppConstants.newsLetterTopic);
  // }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    if (GetPlatform.isIOS) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print("Error while fcm");
        print(e);
      }
    } else {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print(e);
      }
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }
}
