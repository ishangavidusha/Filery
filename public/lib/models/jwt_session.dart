import 'dart:convert';

class JWTSession {
  String msg;
  Data data;
  JWTSession({
    required this.msg,
    required this.data,
  });

  JWTSession copyWith({
    String? msg,
    Data? data,
  }) {
    return JWTSession(
      msg: msg ?? this.msg,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'data': data.toMap(),
    };
  }

  factory JWTSession.fromMap(Map<String, dynamic> map) {
    return JWTSession(
      msg: map['msg'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory JWTSession.fromJson(String source) => JWTSession.fromMap(jsonDecode(source));

  @override
  String toString() => 'JWTSession(msg: $msg, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is JWTSession &&
      other.msg == msg &&
      other.data == data;
  }

  @override
  int get hashCode => msg.hashCode ^ data.hashCode;
}

class Data {
  User user;
  String accessToken;
  String refreshToken;
  Data({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  Data copyWith({
    User? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return Data(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      user: User.fromMap(map['user']),
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(jsonDecode(source));

  @override
  String toString() => 'Data(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Data &&
      other.user == user &&
      other.accessToken == accessToken &&
      other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => user.hashCode ^ accessToken.hashCode ^ refreshToken.hashCode;
}

class User {
  String id;
  String username;
  String fullName;
  User({
    required this.id,
    required this.username,
    required this.fullName,
  });

  User copyWith({
    String? id,
    String? username,
    String? fullName,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      fullName: map['fullName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(jsonDecode(source));

  @override
  String toString() => 'User(id: $id, username: $username, fullName: $fullName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.username == username &&
      other.fullName == fullName;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ fullName.hashCode;
}
