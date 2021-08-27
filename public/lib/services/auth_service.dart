import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fileryapp/utils/filery_log.dart';
import 'package:fileryapp/utils/network_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:fileryapp/models/jwt_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Dio authDio = Dio(BaseOptions(
    baseUrl: kReleaseMode ? Uri.base.origin + "/api/v1/auth" : "http://localhost:5000/api/v1/auth",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ))..interceptors.add(Logging());

  bool _showRegister = false;
  JWTSession? _currentSession;

  AuthService();

  JWTSession? get session => _currentSession;
  bool get showRegister => _showRegister;

  Future<void> _setLoginSession(JWTSession jwtSession) async {
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        sharedPreferences.remove(key);
      }

      sharedPreferences.setString(key, jwtSession.toJson());
      _currentSession = jwtSession;
      notifyListeners();
    } catch (e) {
      FileryLog.e(e.toString());
      throw e;
    }
  }

  Future<void> logout() async {
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        sharedPreferences.remove(key);
      }

      _currentSession = null;
      notifyListeners();
    } catch (e) {
      FileryLog.e(e.toString());
      throw e;
    }
  }

  Future<void> getLoginSession() async {
    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.containsKey(key)) {
        String? data = sharedPreferences.getString(key);
        if (data != null) {
          _currentSession = JWTSession.fromJson(data);
          String token = _currentSession?.data.refreshToken ?? "";
          if (JwtDecoder.isExpired(token)) {
            _currentSession = null;
          }
          notifyListeners();
        } else {
          _currentSession = null;
          notifyListeners();
        }
      } else {
        _currentSession = null;
        notifyListeners();
      }

      //await _isUserAailable(_currentSession?.data.user.id);
    } catch (e) {
      _currentSession = null;
      notifyListeners();
      FileryLog.e(e.toString());
      throw e;
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, String> body = {"username": username, "password": password};

    try {
      Response response = await authDio.post("/login", data: jsonEncode(body), options: Options(contentType: Headers.jsonContentType));
      JWTSession jwtSession = JWTSession.fromMap(response.data as Map<String, dynamic>);

      _setLoginSession(jwtSession);

      return {"success": true, "msg": ""};
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
        FileryLog.e(e.error.toString());
        return {"success": false, "msg": e.error.toString()};
      }
    }
  }

  Future<Map<String, dynamic>> initAdmin(
      String fullName, String username, String password) async {
    Map<String, String> body = {
      "full_name": fullName,
      "username": username,
      "password": password
    };

    try {
      await authDio.post("/signup", data: jsonEncode(body), options: Options(contentType: Headers.jsonContentType));
      _showRegister = false;
      notifyListeners();
      return {"success": true, "msg": ""};
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
        return {"success": false, "msg": e.error.toString()};
      }
    }
  }

  Future<void> _isUserAailable(String? userId) async {
    Map<String, String> body = {
      "userId": userId ?? "",
    };

    String key = "session";
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Response response = await authDio.post("/isuser", data: jsonEncode(body), options: Options(contentType: Headers.jsonContentType));

      Map<String, dynamic> data = response.data as Map<String, dynamic>;
      FileryLog.v("User availability ==> $data");

      if (!data["data"]["current_user"]) {
        sharedPreferences.remove(key);
        _currentSession = null;
      }

      if (data["data"]["user_count"] == 0) {
        _showRegister = true;
      } else {
        _showRegister = false;
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        FileryLog.w('Dio error!');
        FileryLog.w('STATUS: ${e.response?.statusCode}');
        FileryLog.w('DATA: ${e.response?.data}');
        FileryLog.w('HEADERS: ${e.response?.headers}');
      } else {
        FileryLog.e(e.error);
      }
    }
  }
}
