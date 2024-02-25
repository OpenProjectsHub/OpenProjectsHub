import '../data/meta.dart';
import '../data/shop_data.dart';

class ShopsPaginateResponse {
  ShopsPaginateResponse({
    List<ShopData>? data,
    // Links? links,
    Meta? meta,
  }) {
    _data = data;
    // _links = links;
    _meta = meta;
  }

  ShopsPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ShopData.fromJson(v));
      });
    }
    // _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<ShopData>? _data;
  // Links? _links;
  Meta? _meta;

  ShopsPaginateResponse copyWith({
    List<ShopData>? data,
    // Links? links,
    Meta? meta,
  }) =>
      ShopsPaginateResponse(
        data: data ?? _data,
        // links: links ?? _links,
        meta: meta ?? _meta,
      );

  List<ShopData>? get data => _data;

  // Links? get links => _links;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    // if (_links != null) {
    //   map['links'] = _links?.toJson();
    // }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}
