import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import '../../helper/route_helper.dart';
import '../../utils/appConstant.dart';
import '../model/base/error_response.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token) ?? "";
    debugPrint('Token: $token');
    String lang =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "ru";
    updateHeader(token, lang);
  }

  void updateHeader(String token, String languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Accept-Language': languageCode,
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    // SharedPreferences prefer = await SharedPreferences.getInstance();
    if (token == '') {
      token = sharedPreferences.getString(AppConstants.token) ?? "";
      debugPrint('Token: $token');
      String lang =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "ru";
      updateHeader(token, lang);
    }
    log("token = $token");
    try {
      if (foundation.kDebugMode) {
        print('====> API Call: $uri');
      }
      http.Response _response = await http
          .get(
            Uri.parse(AppConstants.baseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n');
        //print('====> API Response: [${response.body}] $uri\n');
      }

      if (_response.statusCode != 200) {
        // if (response.body["message"] == "Unauthenticated.") {
        //   prefer.clear();
        //   Get.offAllNamed(RouteHelper.getLoginRoute());
        // }
      }

      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    try {
      if (foundation.kDebugMode) {
        print('====> API Call: $uri');
        print('====> API Body: ${jsonEncode(body)}');
      }
      http.Response _response = await http
          .post(
            Uri.parse(AppConstants.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        print('====> API Response: [${response.statusCode}] $uri\n');
      }

      ///  token expire
      if (response.body["message"] == "Unauthenticated.") {
        prefer.clear();
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }
      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    try {
      if (foundation.kDebugMode) {
        // print('====> API Call: $uri\nToken: $token');
        //print('====> API Body: ${jsonEncode(body)}');
      }
      http.Response _response = await http
          .delete(
            Uri.parse(AppConstants.baseUrl + uri),
            //body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
        print('====> API Response: [${response.statusCode}] $uri\n');
      }

      ///  token expire
      if (response.body["message"] == "Unauthenticated.") {
        prefer.clear();
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }
      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors[0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 0, statusText: noInternetMessage);
    }

    return _response;
  }

  Future<Response> postMultipartData(
    String uri, {
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    Map<String, String>? headers,
  }) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppConstants.baseUrl + uri),
      );

      request.fields.addAll(fields);
      request.files.addAll(files);
      request.headers.addAll(headers ?? _mainHeaders);

      if (foundation.kDebugMode) {
        print('====> Multipart API Call: $uri');
        print('====> Fields: $fields');
        print('====> Files: ${files.map((e) => e.filename)}');
      }

      http.StreamedResponse streamedResponse =
          await request.send().timeout(Duration(seconds: timeoutInSeconds));

      final responseString = await streamedResponse.stream.bytesToString();
      final statusCode = streamedResponse.statusCode;

      if (foundation.kDebugMode) {
        print('====> Multipart Response: [$statusCode] $uri');
        log('====> Response Body: $responseString');
      }

      dynamic body;
      try {
        body = jsonDecode(responseString);
      } catch (e) {
        body = responseString;
      }

      if (statusCode == 401 ||
          (body is Map && body["message"] == "Unauthenticated.")) {
        prefer.clear();
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }

      return Response(
        statusCode: statusCode,
        body: body,
        statusText: streamedResponse.reasonPhrase,
      );
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // patch data
  Future<Response> patchData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    try {
      if (foundation.kDebugMode) {
        print('====> API PATCH Call: $uri');
        print('====> API PATCH Body: ${jsonEncode(body)}');
      }

      http.Response _response = await http
          .patch(
            Uri.parse(AppConstants.baseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      Response response = handleResponse(_response);

      if (foundation.kDebugMode) {
        print(
            '====> API PATCH Response: [${response.statusCode}] $uri\n${response.body}');
      }

      if (response.body["message"] == "Unauthenticated.") {
        prefer.clear();
        Get.offAllNamed(RouteHelper.getLoginRoute());
      }

      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
}
