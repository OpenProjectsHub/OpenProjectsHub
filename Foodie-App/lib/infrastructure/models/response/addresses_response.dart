import '../data/address_data.dart';

class AddressesResponse {
  AddressesResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<AddressData>? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  AddressesResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AddressData.fromJson(v));
      });
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  List<AddressData>? _data;

  AddressesResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    List<AddressData>? data,
  }) =>
      AddressesResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  List<AddressData>? get data => _data;

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