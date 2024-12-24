import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class PostAdRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PostAdRepo(this.apiClient, this.sharedPreferences);

  // Future<Response> getAttributes(String id) async {
  //   return await apiClient.getData(AppConstants.attributesUrl + "/$id");
  // }

  // Future<Response> getMyAds(String status) async {
  //   return await apiClient.getData(AppConstants.myAdsUrl + "?status=$status");
  // }

  // Future<Response> getEditAds(String id) async {
  //   return await apiClient.getData("${AppConstants.editAdsUrl}/$id");
  // }

  // Future<Response> removeImage(String id) async {
  //   return await apiClient.deleteData("${AppConstants.removeImageUrl}/$id");
  // }

  // Future sellProduct(
  //     {required List<XFile> document,
  //     required String name,
  //     required String description,
  //     required String price,
  //     required String cityId,
  //     required String catId,
  //     required String currency,
  //     required List<AddAttribute> attribute,
  //     required String id,
  //     required String lat,
  //     required String long,
  //     required String address,
  //     required List<List<String>> contactList}) async {
  //   print(document);

  //   String? token = sharedPreferences.getString("token");
  //   Uri url = id == ""
  //       ? Uri.parse(
  //           '${AppConstants.baseUrl}${AppConstants.addProductUrl}',
  //         )
  //       : Uri.parse(
  //           '${AppConstants.baseUrl}${AppConstants.updateProductUrl}/$id',
  //         );
  //   http.MultipartRequest request = http.MultipartRequest('POST', url);
  //   request.headers.addAll({
  //     'Authorization': 'Bearer $token',
  //   });
  //   if (GetPlatform.isAndroid || GetPlatform.isIOS) {
  //     for (int i = 0; i < document.length; i++) {
  //       File file0 = File(document[i].path);
  //       request.files.add(http.MultipartFile('galleries[]', file0.readAsBytes().asStream(), file0.lengthSync(), filename: file0.path.split('/').last));
  //     }
  //   }
  //   Map<String, String> _fields = {};
  //   _fields.addAll(<String, String>{
  //     'name': name,
  //     'description': description,
  //     'price': price == "" ? "0" : price,
  //     'city_id': cityId,
  //     // 'phone': phone,
  //     'currency': currency,
  //     'category_id': catId,
  //     // 'social_link': socialLink,
  //     // 'addtional_information': additionalInfo,
  //     // 'whatsapp_number': whatsapp,
  //     // 'enable_phone': enablePhone?"1":"0",
  //     'dates': DateTime.now().toIso8601String(),
  //     "latitude": lat,
  //     "longitude": long,
  //     // "phone_country_code": phoneCode,
  //     // "whatsapp_country_code": whatsappCode,
  //     "address": address,

  //     for (int i = 0; i < contactList.length; i++) ...{
  //       for (int j = 0; j < contactList[i].length; j++)
  //         if (i == 0)
  //           'contact[whatsapp][$j]': contactList[i][j]
  //         else if (i == 1)
  //           'contact[telegram][$j]': contactList[i][j]
  //         else if (i == 2)
  //           'contact[instagram][$j]': contactList[i][j]
  //         else if (i == 3)
  //           'contact[vk][$j]': contactList[i][j]
  //         else if (i == 4)
  //           'contact[email][$j]': contactList[i][j]
  //         else if (i == 5)
  //           'contact[website][$j]': contactList[i][j]
  //     },
  //   });

  //   for (int i = 0; i < attribute.length; i++) {
  //     _fields.addAll(<String, String>{
  //       'attribute[${attribute[i].id}]': attribute[i].answer,
  //     });
  //   }

  //   //

  //   request.fields.addAll(_fields);
  //   print('=====> ${request.url.path}\n' + request.fields.toString());
  //   http.StreamedResponse response = await request.send();
  //   var res = await http.Response.fromStream(response);
  //   print('=====Response body is here==>${res.body}');
  //   try {
  //     return res;
  //   } catch (e) {
  //     return res;
  //   }
  //   //return await apiClient.getData(AppConstants.courseDetailUrl+"/"+id);
  // }

  // Future<Response> deleteAds(String id) async {
  //   return await apiClient.deleteData("${AppConstants.deleteProductUrl}/$id");
  // }
}
