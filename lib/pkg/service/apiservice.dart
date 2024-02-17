import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/apiresponse.dart';
import 'package:flutter_application/pkg/service/sphelper.dart';
import 'package:flutter_application/pkg/views/common/maintain.dart';
import 'package:flutter_application/pkg/views/user/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.126.6.43:9000/im'; // web地址
  final String imUrl = 'ws://10.126.6.43:9001'; // ws地址

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  Future<void>? _headersFuture;
  BuildContext? context;

  ApiService(BuildContext ctx) {
    _headersFuture = _initializeHeaders();
    context = ctx;
  }

  Future<void> _initializeHeaders() async {
    String token = await SPHelper().getToken();
    if (token.isNotEmpty) {
      headers[HttpHeaders.authorizationHeader] = token;
    }
  }

  void updateToken(String newToken) {
    headers[HttpHeaders.authorizationHeader] = newToken;
  }

  Future<Map<String, String>> getHeader() async {
    await _headersFuture;
    return headers;
  }

  final ApiResponse defaultResponse =
      ApiResponse(code: "1", msg: "API调用失败", data: "");

  Future<ApiResponse> safeApiCall(
      Future<http.Response> Function() apiMethod) async {
    String msg = AppLocalizations.of(context!)!.apiexception;

    try {
      final response = await apiMethod().timeout(
        const Duration(seconds: 3), // 設置3秒的超時時間
        onTimeout: () {
          throw TimeoutException('Request timeout');
        },
      );
      // 正常处理响应
      ApiResponse resp = _processResponse(response);
      if (context!.mounted) _handleError(context!, resp);
      return resp;
    } catch (e) {
      // 统一处理异常
      // 可以根据不同的异常类型来做不同的处理
      // ignore: avoid_print
      print('API调用异常: $e');
      return ApiResponse(
          code: defaultResponse.code, msg: msg, data: e.toString());
    }
  }

  ApiResponse _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      return ApiResponse.fromJson(json.decode(response.body));
    }
  }

  void _handleError(BuildContext context, ApiResponse apiResponse) {
    switch (apiResponse.code) {
      case "01-002": // 系統維護中
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MaintainPage(),
        ));
        break;
      case "03-001": // 尚未登入
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        break;
      default:
        // 处理其他错误
        break;
    }
  }
}
