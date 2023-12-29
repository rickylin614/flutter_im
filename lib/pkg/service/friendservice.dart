import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/apiresponse.dart';
import 'package:flutter_application/pkg/service/apiservice.dart';
import 'package:http/http.dart' as http;

class FriendService {
  Future<ApiResponse> getFriendList(BuildContext context) async {
    ApiService apiService = ApiService(context);
    Map<String, String> parameters = {
      'index': '1',
      'size': '999',
    };
    var header = await apiService.getHeader();

    return apiService.safeApiCall(() => http.get(
          Uri.parse('${apiService.baseUrl}/friend')
              .replace(queryParameters: parameters),
          headers: header,
        ));
  }
}
