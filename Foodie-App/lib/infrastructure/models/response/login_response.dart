import '../data/user.dart';

class LoginResponse {
  LoginResponse({
    String? timestamp,
    bool? status,
    String? message,
    UserData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  LoginResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  UserData? _data;

  LoginResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    UserData? data,
  }) =>
      LoginResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  UserData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class UserData {
  UserData({
    String? accessToken,
    String? tokenType,
    UserModel? user,
  }) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _user = user;
  }

  UserData.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _tokenType = json['token_type'];
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  String? _accessToken;
  String? _tokenType;
  UserModel? _user;

  UserData copyWith({
    String? accessToken,
    String? tokenType,
    UserModel? user,
  }) =>
      UserData(
        accessToken: accessToken ?? _accessToken,
        tokenType: tokenType ?? _tokenType,
        user: user ?? _user,
      );

  String? get accessToken => _accessToken;

  String? get tokenType => _tokenType;

  UserModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
