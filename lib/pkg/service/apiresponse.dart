class ApiResponse {
  final String code;
  final String msg;
  final dynamic data;

  ApiResponse({required this.code, required this.msg, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}
