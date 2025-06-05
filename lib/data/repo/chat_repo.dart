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

  Future<Response> updateLastMessage(String chatId, String message, int userCount, int ownerCount) async {
    return await apiClient.postData(
      "${AppConstants.updateLastMessageUrl}/$chatId", {
      "message": message,
      "user_unread_count": userCount,
      "product_owner_unread_count": ownerCount
    }
    );
  }

  Future<Response> updateReadCount(
      String chatId, int userCount, int ownerCount) async {
    return await apiClient.postData(
        "${AppConstants.updateReadCountUrl}/$chatId", {
      "user_unread_count": userCount,
      "product_owner_unread_count": ownerCount
    });
  }
}
