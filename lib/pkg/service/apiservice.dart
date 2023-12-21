import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/service/apiresponse.dart';
import 'package:flutter_application/pkg/views/common/maintain.dart';
import 'package:flutter_application/pkg/views/common/state.dart';
import 'package:flutter_application/pkg/views/user/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.200.6.73:9000/im'; // 用你的实际后端服务地址替换
  final Map<String, String> _headers;

  ApiService(BuildContext context)
      : _headers = {
          HttpHeaders.contentTypeHeader: 'application/json',
        } {
    _initializeHeaders(context);
  }

  Future<void> _initializeHeaders(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final token = await authBloc.getToken();
    if (token != null) {
      _headers[HttpHeaders.authorizationHeader] = token;
    }
  }

  void updateToken(String newToken) {
    _headers[HttpHeaders.authorizationHeader] = newToken;
  }

  final ApiResponse defaultResponse =
      ApiResponse(code: "1", msg: "API调用失败", data: "");

  Future<ApiResponse> _safeApiCall(
      BuildContext context, Future<http.Response> Function() apiMethod) async {
    try {
      final response = await apiMethod();
      // 正常处理响应
      ApiResponse resp = _processResponse(response);
      if (context.mounted) _handleError(context, resp);
      return resp;
    } catch (e) {
      // 统一处理异常
      // 可以根据不同的异常类型来做不同的处理
      // ignore: avoid_print
      print('API调用异常: $e');
      return ApiResponse(
          code: defaultResponse.code,
          msg: defaultResponse.msg,
          data: e.toString());
    }
  }

  Future<ApiResponse> login(
      BuildContext context, String username, String password) async {
    return _safeApiCall(
        context,
        () => http.post(
              Uri.parse('$baseUrl/users/login'),
              headers: _headers,
              body: jsonEncode({'username': username, 'password': password}),
            ));
  }

  Future<ApiResponse> register(
      BuildContext context,
      String email,
      String password,
      String phoneNumber,
      String username,
      String nickname) async {
    return _safeApiCall(
        context,
        () => http.post(
              Uri.parse('$baseUrl/users/register'),
              headers: _headers,
              body: jsonEncode({
                'email': email,
                'password': password,
                'phone_number': phoneNumber,
                'username': username,
                'nickname': nickname,
              }),
            ));
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
