import '../data/translation.dart';

class PaymentsResponse {
  PaymentsResponse({List<PaymentData>? data}) {
    _data = data;
  }

  PaymentsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PaymentData.fromJson(v));
      });
    }
  }

  List<PaymentData>? _data;

  PaymentsResponse copyWith({List<PaymentData>? data}) =>
      PaymentsResponse(data: data ?? _data);

  List<PaymentData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PaymentData {
  PaymentData({
    int? id,
    String? tag,
    int? input,
    bool? sandbox,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _tag = tag;
    _input = input;
    _sandbox = sandbox;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  PaymentData.fromJson(dynamic json) {
    _id = json['id'];
    _tag = json['tag'];
    _input = json['input'];
    _sandbox = json['sandbox'];
    _active = json['active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _tag;
  int? _input;
  bool? _sandbox;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  PaymentData copyWith({
    int? id,
    String? tag,
    int? input,
    bool? sandbox,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      PaymentData(
        id: id ?? _id,
        tag: tag ?? _tag,
        input: input ?? _input,
        sandbox: sandbox ?? _sandbox,
        active: active ?? _active,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get tag => _tag;

  int? get input => _input;

  bool? get sandbox => _sandbox;

  bool? get active => _active;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tag'] = _tag;
    map['input'] = _input;
    map['sandbox'] = _sandbox;
    map['active'] = _active;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
