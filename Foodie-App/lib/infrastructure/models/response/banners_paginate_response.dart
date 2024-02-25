import 'package:shoppingapp/infrastructure/models/data/product_data.dart';

import '../data/meta.dart';
import '../data/translation.dart';

class BannersPaginateResponse {
  BannersPaginateResponse({List<BannerData>? data, Meta? meta}) {
    _data = data;
    _meta = meta;
  }

  BannersPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<BannerData>? _data;
  Meta? _meta;

  BannersPaginateResponse copyWith({List<BannerData>? data, Meta? meta}) =>
      BannersPaginateResponse(data: data ?? _data, meta: meta ?? _meta);

  List<BannerData>? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class BannerData {
  BannerData({
    int? id,
    int? shopId,
    String? url,
    List<ProductData>? products,
    String? img,
    int? active,
    int? likes,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _shopId = shopId;
    _url = url;
    _products = products;
    _img = img;
    _active = active;
    _likes = likes;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  BannerData.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _url = json['url'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(ProductData.fromJson(v));
      });
    }
    _img = json['img'];
    _active = json['active'];
    _likes = json['likes'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  int? _shopId;
  String? _url;
  List<ProductData>? _products;
  String? _img;
  int? _active;
  int? _likes;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  BannerData copyWith({
    int? id,
    int? shopId,
    String? url,
    List<ProductData>? products,
    String? img,
    int? active,
    int? likes,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      BannerData(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        url: url ?? _url,
        products: products ?? _products,
        img: img ?? _img,
        active: active ?? _active,
        likes: likes ?? _likes,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  String? get url => _url;

  List<ProductData>? get products => _products;

  String? get img => _img;

  int? get active => _active;

  int? get likes => _likes;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['url'] = _url;
    map['shops'] = _products;
    map['img'] = _img;
    map['active'] = _active;
    map['likes'] = _likes;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
