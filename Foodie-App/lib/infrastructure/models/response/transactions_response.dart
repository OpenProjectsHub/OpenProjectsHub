class TransactionsResponse {
  TransactionsResponse({
    String? timestamp,
    bool? status,
    String? message,
    TransactionData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  TransactionsResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? TransactionData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  TransactionData? _data;

  TransactionsResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    TransactionData? data,
  }) =>
      TransactionsResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  TransactionData? get data => _data;

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

class TransactionData {
  TransactionData({
    int? id,
    int? userId,
    num? price,
    num? currencyPrice,
    num? rate,
    String? createdAt,
    String? updatedAt,
    List<TransactionDetails>? details,
  }) {
    _id = id;
    _userId = userId;
    _price = price;
    _currencyPrice = currencyPrice;
    _rate = rate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _details = details;
  }

  TransactionData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _price = json['price'];
    _currencyPrice = json['currency_price'];
    _rate = json['rate'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(TransactionDetails.fromJson(v));
      });
    }
  }

  int? _id;
  int? _userId;
  num? _price;
  num? _currencyPrice;
  num? _rate;
  String? _createdAt;
  String? _updatedAt;
  List<TransactionDetails>? _details;

  TransactionData copyWith({
    int? id,
    int? userId,
    num? price,
    num? currencyPrice,
    num? rate,
    String? createdAt,
    String? updatedAt,
    List<TransactionDetails>? details,
  }) =>
      TransactionData(
        id: id ?? _id,
        userId: userId ?? _userId,
        price: price ?? _price,
        currencyPrice: currencyPrice ?? _currencyPrice,
        rate: rate ?? _rate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        details: details ?? _details,
      );

  int? get id => _id;

  int? get userId => _userId;

  num? get price => _price;

  num? get currencyPrice => _currencyPrice;

  num? get rate => _rate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<TransactionDetails>? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['price'] = _price;
    map['currency_price'] = _currencyPrice;
    map['rate'] = _rate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TransactionDetails {
  TransactionDetails({
    int? id,
    int? shopId,
    num? deliveryFee,
    num? price,
    num? tax,
    String? status,
    String? deliveryDate,
    String? deliveryTime,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _shopId = shopId;
    _deliveryFee = deliveryFee;
    _price = price;
    _tax = tax;
    _status = status;
    _deliveryDate = deliveryDate;
    _deliveryTime = deliveryTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  TransactionDetails.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _deliveryFee = json['delivery_fee'];
    _price = json['price'];
    _tax = json['tax'];
    _status = json['status'];
    _deliveryDate = json['delivery_date'];
    _deliveryTime = json['delivery_time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _shopId;
  num? _deliveryFee;
  num? _price;
  num? _tax;
  String? _status;
  String? _deliveryDate;
  String? _deliveryTime;
  String? _createdAt;
  String? _updatedAt;

  TransactionDetails copyWith({
    int? id,
    int? shopId,
    num? deliveryFee,
    num? price,
    num? tax,
    String? status,
    String? deliveryDate,
    String? deliveryTime,
    String? createdAt,
    String? updatedAt,
  }) =>
      TransactionDetails(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        deliveryFee: deliveryFee ?? _deliveryFee,
        price: price ?? _price,
        tax: tax ?? _tax,
        status: status ?? _status,
        deliveryDate: deliveryDate ?? _deliveryDate,
        deliveryTime: deliveryTime ?? _deliveryTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  num? get deliveryFee => _deliveryFee;

  num? get price => _price;

  num? get tax => _tax;

  String? get status => _status;

  String? get deliveryDate => _deliveryDate;

  String? get deliveryTime => _deliveryTime;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['delivery_fee'] = _deliveryFee;
    map['price'] = _price;
    map['tax'] = _tax;
    map['status'] = _status;
    map['delivery_date'] = _deliveryDate;
    map['delivery_time'] = _deliveryTime;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
