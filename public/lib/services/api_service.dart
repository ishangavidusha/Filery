import 'package:dio/dio.dart';
import 'package:fileryapp/models/api_response.dart';
import 'package:fileryapp/services/auth_interceptor.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:fileryapp/utils/network_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiService with ChangeNotifier {
  Dio apiDio = Dio(BaseOptions(
    baseUrl: kReleaseMode ? Uri.base.origin + "/api/v1" : "http://localhost:5000/api/v1",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ))..interceptors.addAll([AuthInterceptor(), Logging()]);
  bool _authState = true;

  bool get authState => _authState;

  Future<ApiResponse> getDir() async {

    try {
      Response response = await apiDio.get("/dir", options: Options(contentType: Headers.jsonContentType));

      FileryLog.ok(response.data);

      return ApiResponse(success: true, msg: "");


    } on DioError catch (e) {
      return _checkError(e);
    }
  }

  ApiResponse _checkError(DioError e) {
    if (e.response != null) {
      FileryLog.w('Dio error!');
      FileryLog.w('STATUS: ${e.response?.statusCode}');
      FileryLog.w('DATA: ${e.response?.data}');
      FileryLog.w('HEADERS: ${e.response?.headers}');
      Map<String, dynamic> data = (e.response!.data as Map<String, dynamic>);
      ApiResponse apiResponse = ApiResponse(success: false, msg: data["msg"]);
      if (data.containsKey("auth")) {
        if (!data["auth"]) {
          _authState = false;
          notifyListeners();
        }
        apiResponse.auth = data["auth"];
      }
      return apiResponse;
    } else {
      FileryLog.e(e.error);
      return ApiResponse(success: false, msg: e.error.toString());
    }
  }

}