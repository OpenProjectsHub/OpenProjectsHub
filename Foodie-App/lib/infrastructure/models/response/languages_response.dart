class LanguagesResponse {
  LanguagesResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<LanguageData>? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  LanguagesResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LanguageData.fromJson(v));
      });
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  List<LanguageData>? _data;

  LanguagesResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    List<LanguageData>? data,
  }) =>
      LanguagesResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  List<LanguageData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LanguageData {
  LanguageData({
    int? id,
    String? title,
    String? locale,
    int? backward,
    int? isDefault,
    int? active,
    String? img,
  }) {
    _id = id;
    _title = title;
    _locale = locale;
    _backward = backward;
    _default = isDefault;
    _active = active;
    _img = img;
  }

  LanguageData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _locale = json['locale'];
    _backward = json['backward'];
    _default = json['default'];
    _active = json['active'];
    _img = json['img'];
  }

  int? _id;
  String? _title;
  String? _locale;
  int? _backward;
  int? _default;
  int? _active;
  String? _img;

  LanguageData copyWith({
    int? id,
    String? title,
    String? locale,
    int? backward,
    int? isDefault,
    int? active,
    String? img,
  }) =>
      LanguageData(
        id: id ?? _id,
        title: title ?? _title,
        locale: locale ?? _locale,
        backward: backward ?? _backward,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
        img: img ?? _img,
      );

  int? get id => _id;

  String? get title => _title;

  String? get locale => _locale;

  int? get backward => _backward;

  int? get isDefault => _default;

  int? get active => _active;

  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['locale'] = _locale;
    map['backward'] = _backward;
    map['default'] = _default;
    map['active'] = _active;
    map['img'] = _img;
    return map;
  }
}
