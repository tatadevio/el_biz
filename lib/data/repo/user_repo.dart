import 'dart:convert';

import 'package:el_biz/data/model/response/account/selected_account_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.userInfoUrl);
  }

  Future<Response> updateUserData(String firstName, String lastname,
      String email, String phoneNumber) async {
    return await apiClient.postData(AppConstants.updateUserUrl, {
      'first_name': firstName,
      'last_name': lastname,
      'phone': phoneNumber,
      'email': email
    });
  }


    Future<bool> saveSelectedAccount(SelectedAccountModel account) async {
   final accountString = jsonEncode(account.toJson());
    return await sharedPreferences.setString(AppConstants.selecteAccount, accountString);
  }

  String getSelectedAccount() {
    return sharedPreferences.getString(AppConstants.selecteAccount) ?? "";
  }

  

  // Future<Response> changePassword(String password, String confirmPassword) async {
  //   return await apiClient.postData(AppConstants.changePasswordUrl, {"password": password, "password_confirmation": confirmPassword});
  // }

  // Future<Response> editProfile(String name, String phone, String email, String countryCode) async {
  //   return await apiClient.postData(AppConstants.editProfileUrl, {"name": name, "phone": phone, "country_code": countryCode, "city": "", "state": "", "address": "", "about": "", "email": email});
  // }

  // Future updateProfileImage(XFile profileImage) async {
  //   String? token = sharedPreferences.getString("token");

  //   http.MultipartRequest request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //         '${AppConstants.baseUrl}${AppConstants.imageUploadUrl}',
  //       ));
  //   request.headers.addAll({
  //     'Authorization': 'Bearer $token',
  //   });
  //   if (GetPlatform.isAndroid || GetPlatform.isIOS) {
  //     File _file = File(profileImage.path);
  //     request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
  //   }
  //   print('=====> ${request.url.path}\n' + request.files.toString());
  //   http.StreamedResponse response = await request.send();
  //   var res = await http.Response.fromStream(response);
  //   print('=====Response body is here==>${res.body}');
  //   try {
  //     return res;
  //   } catch (e) {
  //     return res;
  //   }
  // }
}
