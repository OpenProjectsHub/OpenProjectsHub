import 'package:shoppingapp/infrastructure/models/data/addons_data.dart';
import 'package:shoppingapp/infrastructure/models/data/bonus_data.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';

import 'review_data.dart';
import 'translation.dart';

class ProductData {
  ProductData({
    int? id,
    String? uuid,
    int? shopId,
    int? categoryId,
    String? keywords,
    int? brandId,
    num? tax,
    int? minQty,
    int? maxQty,
    bool? active,
    String? img,
    String? createdAt,
    String? updatedAt,
    num? ratingAvg,
    dynamic ordersCount,
    Translation? translation,
    List<Properties>? properties,
    List<Stocks>? stocks,
    Stocks? stock,
    ShopData? shop,
    Category? category,
    Brand? brand,
    Unit? unit,
    List<ReviewData>? reviews,
    List<Galleries>? galleries,
    int? count,
  }) {
    _id = id;
    _uuid = uuid;
    _shopId = shopId;
    _categoryId = categoryId;
    _keywords = keywords;
    _brandId = brandId;
    _tax = tax;
    _minQty = minQty;
    _maxQty = maxQty;
    _active = active;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _ratingAvg = ratingAvg;
    _ordersCount = ordersCount;
    _translation = translation;
    _properties = properties;
    _stocks = stocks;
    _shop = shop;
    _category = category;
    _brand = brand;
    _unit = unit;
    _reviews = reviews;
    _galleries = galleries;
    _count = count;
    _stock = stock;
  }

  ProductData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _shopId = json['shop_id'];
    _categoryId = json['category_id'];
    _keywords = json['keywords'];
    _brandId = json['brand_id'];
    _tax = json['tax'];
    _active = false;
    _minQty = json['min_qty'];
    _maxQty = json['max_qty'];
    _img = json['img'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _ratingAvg = json['rating_avg'];
    _stock = json['stock'] != null ? Stocks.fromJson(json["stock"]) : null;
    _ordersCount = json['orders_count'];
    _count = 0;
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['properties'] != null) {
      _properties = [];
      json['properties'].forEach((v) {
        _properties?.add(Properties.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      _stocks = [];
      json['stocks'].forEach((v) {
        _stocks?.add(Stocks.fromJson(v));
      });
    }
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    _unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(ReviewData.fromJson(v));
      });
    }

    if (json['galleries'] != null) {
      _galleries = [];
      json['galleries'].forEach((v) {
        _galleries?.add(Galleries.fromJson(v));
      });
    }
  }

  int? _id;
  String? _uuid;
  int? _shopId;
  int? _categoryId;
  String? _keywords;
  int? _brandId;
  num? _tax;
  int? _minQty;
  int? _maxQty;
  bool? _active;
  String? _img;
  String? _createdAt;
  String? _updatedAt;
  num? _ratingAvg;
  dynamic _ordersCount;
  Translation? _translation;
  List<Properties>? _properties;
  List<Stocks>? _stocks;
  Stocks? _stock;
  ShopData? _shop;
  Category? _category;
  Brand? _brand;
  Unit? _unit;
  List<ReviewData>? _reviews;
  List<Galleries>? _galleries;

  int? _count;

  ProductData copyWith({
    int? id,
    String? uuid,
    int? shopId,
    int? categoryId,
    String? keywords,
    int? brandId,
    num? tax,
    int? minQty,
    int? maxQty,
    bool? active,
    String? img,
    String? createdAt,
    String? updatedAt,
    num? ratingAvg,
    dynamic ordersCount,
    Translation? translation,
    List<Properties>? properties,
    List<Stocks>? stocks,
    Stocks? stock,
    ShopData? shop,
    Category? category,
    Brand? brand,
    Unit? unit,
    List<ReviewData>? reviews,
    List<Galleries>? galleries,
  }) =>
      ProductData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        shopId: shopId ?? _shopId,
        categoryId: categoryId ?? _categoryId,
        keywords: keywords ?? _keywords,
        brandId: brandId ?? _brandId,
        tax: tax ?? _tax,
        minQty: minQty ?? _minQty,
        maxQty: maxQty ?? _maxQty,
        active: active ?? _active,
        img: img ?? _img,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        ratingAvg: ratingAvg ?? _ratingAvg,
        ordersCount: ordersCount ?? _ordersCount,
        translation: translation ?? _translation,
        properties: properties ?? _properties,
        stocks: stocks ?? _stocks,
        stock: stock ?? _stock,
        shop: shop ?? _shop,
        category: category ?? _category,
        brand: brand ?? _brand,
        unit: unit ?? _unit,
        reviews: reviews ?? _reviews,
        galleries: galleries ?? _galleries,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  int? get shopId => _shopId;

  int? get categoryId => _categoryId;

  String? get keywords => _keywords;

  int? get brandId => _brandId;

  num? get tax => _tax;

  int? get minQty => _minQty;

  int? get maxQty => _maxQty;

  bool? get active => _active;

  String? get img => _img;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get ratingAvg => _ratingAvg;

  dynamic get ordersCount => _ordersCount;

  Translation? get translation => _translation;

  List<Properties>? get properties => _properties;

  List<Stocks>? get stocks => _stocks;

  Stocks? get stock => _stock;

  ShopData? get shop => _shop;

  Category? get category => _category;

  Brand? get brand => _brand;

  Unit? get unit => _unit;

  int? get count => _count;

  List<ReviewData>? get reviews => _reviews;

  List<Galleries>? get galleries => _galleries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['shop_id'] = _shopId;
    map['category_id'] = _categoryId;
    map['keywords'] = _keywords;
    map['brand_id'] = _brandId;
    map['tax'] = _tax;
    map['min_qty'] = _minQty;
    map['max_qty'] = _maxQty;
    map['active'] = _active;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rating_avg'] = _ratingAvg;
    map['orders_count'] = _ordersCount;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_properties != null) {
      map['properties'] = _properties?.map((v) => v.toJson()).toList();
    }
    if (_stocks != null) {
      map['stocks'] = _stocks?.map((v) => v.toJson()).toList();
    }
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_brand != null) {
      map['brand'] = _brand?.toJson();
    }
    if (_unit != null) {
      map['unit'] = _unit?.toJson();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    if (_galleries != null) {
      map['galleries'] = _galleries?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Unit {
  Unit({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _active = active;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  Unit.fromJson(dynamic json) {
    _id = json['id'];
    _active = json['active'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  bool? _active;
  String? _position;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  Unit copyWith({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      Unit(
        id: id ?? _id,
        active: active ?? _active,
        position: position ?? _position,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  bool? get active => _active;

  String? get position => _position;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['active'] = _active;
    map['position'] = _position;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class Brand {
  Brand({
    int? id,
    String? uuid,
    String? title,
  }) {
    _id = id;
    _uuid = uuid;
    _title = title;
  }

  Brand.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _title = json['title'];
  }

  int? _id;
  String? _uuid;
  String? _title;

  Brand copyWith({
    int? id,
    String? uuid,
    String? title,
  }) =>
      Brand(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        title: title ?? _title,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['title'] = _title;
    return map;
  }
}

class Category {
  Category({
    int? id,
    String? uuid,
    int? parentId,
    Translation? translation,
  }) {
    _id = id;
    _uuid = uuid;
    _parentId = parentId;
    _translation = translation;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _parentId = json['parent_id'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _uuid;
  int? _parentId;
  Translation? _translation;

  Category copyWith({
    int? id,
    String? uuid,
    int? parentId,
    Translation? translation,
  }) =>
      Category(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        parentId: parentId ?? _parentId,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  int? get parentId => _parentId;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['parent_id'] = _parentId;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class Stocks {
  Stocks({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    int? minQuantity,
    num? discount,
    num? tax,
    num? totalPrice,
    BonusModel? bonus,
    List<Extras>? extras,
    List<Addons>? addons,
    ProductData? product,
  }) {
    _bonus = bonus;
    _id = id;
    _countableId = countableId;
    _price = price;
    _quantity = quantity;
    _minQuantity = minQuantity;
    _discount = discount;
    _tax = tax;
    _totalPrice = totalPrice;
    _extras = extras;
    _addons = addons;
    _product = product;
  }

  Stocks.fromJson(dynamic json) {
    _bonus = json?["bonus"] != null ? BonusModel.fromJson(json["bonus"]) : null;
    _id = json?['id'];
    _countableId = json?['countable_id'];
    _price = json?['price'];
    _quantity =
        json?[json?['min_quantity'] == null ? 'quantity' : 'min_quantity'];
    _minQuantity = json?['min_quantity'];
    _discount = json?['discount'];
    _tax = json?['tax'];
    _totalPrice = json?['total_price'];
    if (json?['extras'] != null) {
      _extras = [];
      if (json?['extras'].runtimeType != bool) {
        json?['extras'].forEach((v) {
          _extras?.add(Extras.fromJson(v));
        });
      }
    }
    if (json?['addons'] != null) {
      _addons = [];
      json?['addons'].forEach((v) {
        if (v["product"] != null || v["stock"] != null) {
          _addons?.add(Addons.fromJson(v));
        }
      });
    }
    _product =
        json?['product'] != null ? ProductData.fromJson(json['product']) : null;
  }

  int? _id;
  int? _countableId;
  num? _price;
  int? _quantity;
  int? _minQuantity;
  num? _discount;
  num? _tax;
  BonusModel? _bonus;
  num? _totalPrice;
  List<Extras>? _extras;
  ProductData? _product;
  List<Addons>? _addons;

  Stocks copyWith({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    int? minQuantity,
    num? discount,
    num? tax,
    BonusModel? bonus,
    num? totalPrice,
    List<Extras>? extras,
    List<Addons>? addons,
    ProductData? product,
  }) =>
      Stocks(
          bonus: bonus ?? _bonus,
          id: id ?? _id,
          countableId: countableId ?? _countableId,
          price: price ?? _price,
          quantity: quantity ?? _quantity,
          minQuantity: minQuantity ?? _minQuantity,
          discount: discount ?? _discount,
          tax: tax ?? _tax,
          totalPrice: totalPrice ?? _totalPrice,
          extras: extras ?? _extras,
          product: product ?? _product,
          addons: addons ?? _addons);

  int? get id => _id;

  int? get countableId => _countableId;

  num? get price => _price;

  int? get quantity => _quantity;

  int? get minQuantity => _minQuantity;

  num? get discount => _discount;

  num? get tax => _tax;

  num? get totalPrice => _totalPrice;

  BonusModel? get bonus => _bonus;

  List<Addons>? get addons => _addons;

  List<Extras>? get extras => _extras;

  ProductData? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countable_id'] = _countableId;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['discount'] = _discount;
    map['tax'] = _tax;
    map['total_price'] = _totalPrice;
    if (_extras != null) {
      map['extras'] = _extras?.map((v) => v.toJson()).toList();
    }
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

class Extras {
  Extras({
    int? id,
    int? extraGroupId,
    String? value,
    Group? group,
  }) {
    _id = id;
    _extraGroupId = extraGroupId;
    _value = value;
    _active = active;
    _group = group;
  }

  Extras.fromJson(dynamic json) {
    _id = json['id'];
    _extraGroupId = json['extra_group_id'];
    _value = json['value'];
    _group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  int? _id;
  int? _extraGroupId;
  String? _value;
  bool? _active;
  Group? _group;

  Extras copyWith({
    int? id,
    int? extraGroupId,
    String? value,
    bool? active,
    Group? group,
  }) =>
      Extras(
        id: id ?? _id,
        extraGroupId: extraGroupId ?? _extraGroupId,
        value: value ?? _value,
        group: group ?? _group,
      );

  int? get id => _id;

  int? get extraGroupId => _extraGroupId;

  String? get value => _value;

  bool? get active => _active;

  Group? get group => _group;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['extra_group_id'] = _extraGroupId;
    map['value'] = _value;
    map['active'] = _active;
    if (_group != null) {
      map['group'] = _group?.toJson();
    }
    return map;
  }
}

class Group {
  Group({
    int? id,
    String? type,
    bool? active,
    Translation? translation,
  }) {
    _id = id;
    _type = type;
    _active = active;
    _translation = translation;
  }

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _type;
  bool? _active;
  Translation? _translation;

  Group copyWith({
    int? id,
    String? type,
    bool? active,
    Translation? translation,
  }) =>
      Group(
        id: id ?? _id,
        type: type ?? _type,
        active: active ?? _active,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get type => _type;

  bool? get active => _active;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['active'] = _active;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class Properties {
  Properties({
    String? locale,
    String? key,
    String? value,
  }) {
    _locale = locale;
    _key = key;
    _value = value;
  }

  Properties.fromJson(dynamic json) {
    _locale = json['locale'];
    _key = json['key'];
    _value = json['value'];
  }

  String? _locale;
  String? _key;
  String? _value;

  Properties copyWith({
    String? locale,
    String? key,
    String? value,
  }) =>
      Properties(
        locale: locale ?? _locale,
        key: key ?? _key,
        value: value ?? _value,
      );

  String? get locale => _locale;

  String? get key => _key;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['locale'] = _locale;
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }
}
