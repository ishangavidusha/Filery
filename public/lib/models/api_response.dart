

class ApiResponse {
  bool success;
  String msg;
  bool auth;
  ApiResponse({
    required this.success,
    required this.msg,
    this.auth = true,
  });

  @override
  String toString() => 'ApiResponse(success: $success, msg: $msg, auth: $auth)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApiResponse &&
      other.success == success &&
      other.msg == msg &&
      other.auth == auth;
  }

  @override
  int get hashCode => success.hashCode ^ msg.hashCode ^ auth.hashCode;
}
