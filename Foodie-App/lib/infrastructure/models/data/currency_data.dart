class CurrencyData {
  CurrencyData({
    int? id,
    String? symbol,
    String? title,
    num? rate,
    bool? isDefault,
    bool? active,
    String? updatedAt,
  }) {
    _id = id;
    _symbol = symbol;
    _title = title;
    _rate = rate;
    _default = isDefault;
    _active = active;
    _updatedAt = updatedAt;
  }

  CurrencyData.fromJson(dynamic json) {
    _id = json['id'];
    _symbol = json['symbol'];
    _title = json['title'];
    _rate = json['rate'];
    _default = json['default'];
    _active = json['active'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _symbol;
  String? _title;
  num? _rate;
  bool? _default;
  bool? _active;
  String? _updatedAt;

  CurrencyData copyWith({
    int? id,
    String? symbol,
    String? title,
    num? rate,
    bool? isDefault,
    bool? active,
    String? updatedAt,
  }) =>
      CurrencyData(
        id: id ?? _id,
        symbol: symbol ?? _symbol,
        title: title ?? _title,
        rate: rate ?? _rate,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  String? get symbol => _symbol;

  String? get title => _title;

  num? get rate => _rate;

  bool? get isDefault => _default;

  bool? get active => _active;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['symbol'] = _symbol;
    map['title'] = _title;
    map['rate'] = _rate;
    map['default'] = _default;
    map['active'] = _active;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
