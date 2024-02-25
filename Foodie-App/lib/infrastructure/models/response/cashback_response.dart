class CashbackResponse {
  CashbackResponse({
    String? timestamp,
    bool? status,
    String? message,
    CashbackData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  CashbackResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? CashbackData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  CashbackData? _data;

  CashbackResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    CashbackData? data,
  }) =>
      CashbackResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  CashbackData? get data => _data;

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

class CashbackData {
  CashbackData({num? price}) {
    _price = price;
  }

  CashbackData.fromJson(dynamic json) {
    _price = json['price'];
  }

  num? _price;

  CashbackData copyWith({num? price}) => CashbackData(price: price ?? _price);

  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    return map;
  }
}
