import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/pkg/model/apiresponse.dart';
import 'package:flutter_application/pkg/service/apiservice.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

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

  Future<io.Socket> createConnect(BuildContext context) async {
    ApiService apiService = ApiService(context);
    var header = await apiService.getHeader();

    // 建立 Socket.IO 連接
    io.Socket socket = io.io(apiService.imUrl, <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': header, // 將 header 放在這裡
      'path': '/connect'
    });

    return socket;
  }
}
