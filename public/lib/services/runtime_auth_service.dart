import 'package:dio/dio.dart';
import 'package:fileryapp/models/jwt_session.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:fileryapp/utils/network_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuntimeAuthService {
  Dio tokenDio = Dio(BaseOptions(
    baseUrl: kReleaseMode ? Uri.base.origin + "/api/v1/auth" : "http://localhost:5000/api/v1/auth",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ))..interceptors.add(Logging());

  Future<String?> getAccessToken() async {
    JWTSession? jwtSession;
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        String? data = sharedPreferences.getString(key);
        if (data != null) {
          jwtSession = JWTSession.fromJson(data);
          String token = jwtSession.data.accessToken;
          if (JwtDecoder.isExpired(token)) {
            jwtSession = null;
          }
        }
      }

      return jwtSession?.data.accessToken;

    } catch (e) {
      FileryLog.e(e.toString());
      return null;
    }
  }

  Future<void> _setAccessToken(String accessToken) async {
    JWTSession? jwtSession;
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        String? data = sharedPreferences.getString(key);
        if (data != null) {
          jwtSession = JWTSession.fromJson(data);
          jwtSession.data.accessToken = accessToken;

          sharedPreferences.setString(key, jwtSession.toJson());

        }
      }

    } catch (e) {
      FileryLog.e(e.toString());
    }
  }

  Future<String?> _getRefreshToken() async {
    JWTSession? jwtSession;
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        String? data = sharedPreferences.getString(key);
        if (data != null) {
          jwtSession = JWTSession.fromJson(data);
          String token = jwtSession.data.refreshToken;
          if (JwtDecoder.isExpired(token)) {
            jwtSession = null;
          }
        }
      }

      return jwtSession?.data.refreshToken;

    } catch (e) {
      FileryLog.e(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> refreshAccessToken() async {
    try {
      String? refreshToken = await _getRefreshToken();
      if (refreshToken == null) {
        return {
          "success": false,
          "msg": "Authentication failed!"
        };
      }

      Response response = await tokenDio.get("/refresh-token", options: Options(contentType: Headers.jsonContentType, headers: {'Authorization': 'Bearer $refreshToken'}));
      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      String newAccessToken = data["data"]["access_token"];

      _setAccessToken(newAccessToken);

      return {
        "success": true,
        "msg": newAccessToken
      };


    } on DioError catch (e) {
      if (e.response != null) {
        FileryLog.w('Dio error!');
        FileryLog.w('STATUS: ${e.response?.statusCode}');
        FileryLog.w('DATA: ${e.response?.data}');
        FileryLog.w('HEADERS: ${e.response?.headers}');
        return {
          "success": false,
          "msg": (e.response!.data as Map<String, dynamic>)["msg"]
        };
      } else {
        FileryLog.e(e.error);
        return {
          "success": false,
          "msg": e.error.toString()
        };
      }
    }
  }
}