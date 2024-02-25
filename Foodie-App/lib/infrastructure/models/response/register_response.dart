class RegisterResponse {
  RegisterResponse({
    String? timestamp,
    bool? status,
    String? message,
    RegisterData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  RegisterResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  RegisterData? _data;

  RegisterResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    RegisterData? data,
  }) =>
      RegisterResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  RegisterData? get data => _data;

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

class RegisterData {
  RegisterData({
    String? verifyId,
    String? phone,
  }) {
    _verifyId = verifyId;
    _phone = phone;
  }

  RegisterData.fromJson(dynamic json) {
    _verifyId = json['verifyId'];
    _phone = json['phone'];
  }

  String? _verifyId;
  String? _phone;

  RegisterData copyWith({
    String? verifyId,
    String? phone,
  }) =>
      RegisterData(
        verifyId: verifyId ?? _verifyId,
        phone: phone ?? _phone,
      );

  String? get verifyId => _verifyId;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verifyId'] = _verifyId;
    map['phone'] = _phone;
    return map;
  }
}
