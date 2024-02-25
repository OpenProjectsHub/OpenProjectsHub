class BrandData {
  BrandData({
    int? id,
    String? title,
    bool? active,
    String? img,
    int? productsCount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _active = active;
    _img = img;
    _productsCount = productsCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  BrandData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _active = json['active'];
    _img = json['img'];
    _productsCount = json['products_count'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _title;
  bool? _active;
  String? _img;
  int? _productsCount;
  String? _createdAt;
  String? _updatedAt;

  BrandData copyWith({
    int? id,
    String? title,
    bool? active,
    String? img,
    int? productsCount,
    String? createdAt,
    String? updatedAt,
  }) =>
      BrandData(
        id: id ?? _id,
        title: title ?? _title,
        active: active ?? _active,
        img: img ?? _img,
        productsCount: productsCount ?? _productsCount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  String? get title => _title;

  bool? get active => _active;

  String? get img => _img;

  int? get productsCount => _productsCount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['active'] = _active;
    map['img'] = _img;
    map['products_count'] = _productsCount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
