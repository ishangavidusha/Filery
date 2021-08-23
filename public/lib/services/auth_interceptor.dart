import 'package:dio/dio.dart';
import 'package:fileryapp/services/runtime_auth_service.dart';

class AuthInterceptor extends Interceptor {

  RuntimeAuthService _authService = RuntimeAuthService();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    
    String? accessToken = await _authService.getAccessToken();

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
      return super.onRequest(options, handler);
    }

    Map<String, dynamic> result = await _authService.refreshAccessToken();

    if (result["success"]) {
      accessToken = result["msg"];
      options.headers["Authorization"] = "Bearer $accessToken";
      return super.onRequest(options, handler);
    }

    return handler.reject(DioError(
      requestOptions: options, 
      response: Response(data: {
        "msg": "Authentication failed",
        "data": null,
        "auth": false
      }, 
      requestOptions: options, statusCode: 401
    )));
  }
}