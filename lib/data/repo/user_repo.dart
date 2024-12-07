import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.userInfoUrl);
  }

  Future<Response> deleteAccount() async {
    return await apiClient.deleteData(AppConstants.deleteAccountUrl);
  }

  Future<Response> changePassword(String password, String confirmPassword) async {
    return await apiClient.postData(AppConstants.changePasswordUrl, {"password": password, "password_confirmation": confirmPassword});
  }

  Future<Response> editProfile(String name, String phone, String email, String countryCode) async {
    return await apiClient.postData(AppConstants.editProfileUrl, {"name": name, "phone": phone, "country_code": countryCode, "city": "", "state": "", "address": "", "about": "", "email": email});
  }

  Future updateProfileImage(XFile profileImage) async {
    String? token = sharedPreferences.getString("token");

    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.imageUploadUrl}',
        ));
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      File _file = File(profileImage.path);
      request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
    }
    print('=====> ${request.url.path}\n' + request.files.toString());
    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    print('=====Response body is here==>${res.body}');
    try {
      return res;
    } catch (e) {
      return res;
    }
  }
}
