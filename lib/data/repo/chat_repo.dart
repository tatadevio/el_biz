import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';
import 'package:http/http.dart' as http;

class ChatRepo {
  final ApiClient apiClient;

  ChatRepo(this.apiClient);

  Future<Response> sendMessage(String productId) async {
    return await apiClient.postData(AppConstants.messagesUrl, {
      'product_id': productId,
    });
  }

  Future<Response> getChatList(int page) async {
    return await apiClient.getData(
      "${AppConstants.chatListUrl}?page=$page",
    );
  }

  Future<Response> deleteChat(String chatId) async {
    return await apiClient.deleteData(
      "${AppConstants.deleteChaturl}/$chatId",
    );
  }

  Future<Response> sendMedia(String chatId, XFile image) async {
    Map<String, String> fields = {};
    List<http.MultipartFile> files = [];
    files.add(await http.MultipartFile.fromPath('medias[]', image.path));

    return await apiClient.postMultipartData(
        "${AppConstants.chatListUrl}/$chatId/upload-medias",
        fields: fields,
        files: files);
  }

  // Future<Response> getTicketList() async {
  //   return await apiClient.getData(
  //     AppConstants.ticketUrl,
  //   );
  // }

  // Future<Response> getSearchTicketList(String query) async {
  //   return await apiClient.getData(
  //     AppConstants.ticketUrl + "?search=$query",
  //   );
  // }

  // Future<Response> deleteMessage(String id) async {
  //   return await apiClient.deleteData(
  //     "${AppConstants.deleteMessage}/$id",
  //   );
  // }

  // Future<Response> clearMessage(String id) async {
  //   return await apiClient.deleteData(
  //     "${AppConstants.clearAllMessage}/$id",
  //   );
  // }

  // Future sendImage(String ticketId, XFile image) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString("token");
  //   http.MultipartRequest request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //         '${AppConstants.baseUrl}',
  //       ));
  //   request.headers.addAll({
  //     'Authorization': 'Bearer $token',
  //   });
  //   if (GetPlatform.isAndroid || GetPlatform.isIOS) {
  //     File _file = File(image.path);
  //     request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
  //   }
  //   Map<String, String> _fields = {};
  //   _fields.addAll(<String, String>{'ticket_id': ticketId});
  //   request.fields.addAll(_fields);
  //   //print('=====> ${request.url.path}\n' + request.fields.toString());
  //   http.StreamedResponse response = await request.send();
  //   var res = await http.Response.fromStream(response);
  //   //print('=====Response body is here==>${res.body}');
  //   try {
  //     return res;
  //   } catch (e) {
  //     return res;
  //   }
  //   //return await apiClient.getData(AppConstants.courseDetailUrl+"/"+id);
  // }
}
