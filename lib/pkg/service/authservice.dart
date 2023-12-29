import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/apiresponse.dart';
import 'package:flutter_application/pkg/service/apiservice.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<ApiResponse> login(
      BuildContext context, String username, String password) async {
    var apiService = ApiService(context);
    var header = await apiService.getHeader();
    return apiService.safeApiCall(() => http.post(
          Uri.parse('${apiService.baseUrl}/users/login'),
          headers: header,
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
    var apiService = ApiService(context);
    var header = await apiService.getHeader();

    return apiService.safeApiCall(() => http.post(
          Uri.parse('${apiService.baseUrl}/users/register'),
          headers: header,
          body: jsonEncode({
            'email': email,
            'password': password,
            'phone_number': phoneNumber,
            'username': username,
            'nickname': nickname,
          }),
        ));
  }
}
