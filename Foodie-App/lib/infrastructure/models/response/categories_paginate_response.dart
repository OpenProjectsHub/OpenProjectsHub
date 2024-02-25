import '../data/meta.dart';
import '../data/translation.dart';

class CategoriesPaginateResponse {
  CategoriesPaginateResponse({
    List<CategoryData>? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  CategoriesPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
    // _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<CategoryData>? _data;

  // Links? _links;
  Meta? _meta;

  CategoriesPaginateResponse copyWith({
    List<CategoryData>? data,
    // Links? links,
    Meta? meta,
  }) =>
      CategoriesPaginateResponse(
        data: data ?? _data,
        // links: links ?? _links,
        meta: meta ?? _meta,
      );

  List<CategoryData>? get data => _data;

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

class CategoryData {
  CategoryData({
    int? id,
    String? uuid,
    String? keywords,
    int? parentId,
    int? receiptsCount,
    String? type,
    String? img,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _uuid = uuid;
    _keywords = keywords;
    _parentId = parentId;
    _receiptsCount = receiptsCount;
    _type = type;
    _img = img;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
    _children = children;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _keywords = json['keywords'];
    _parentId = json['parent_id'];
    _type = json['type'];
    _receiptsCount = json['receipts_count'];
    _img = json['img'];
    _active = json['active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(CategoryData.fromJson(v));
      });
    }
  }

  int? _id;
  String? _uuid;
  String? _keywords;
  int? _parentId;
  int? _receiptsCount;
  String? _type;
  String? _img;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;
  List<CategoryData>? _children;

  CategoryData copyWith({
    int? id,
    String? uuid,
    String? keywords,
    int? parentId,
    int? receiptsCount,
    String? type,
    String? img,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
    List<CategoryData>? children,
  }) =>
      CategoryData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        keywords: keywords ?? _keywords,
        parentId: parentId ?? _parentId,
        receiptsCount: receiptsCount ?? _receiptsCount,
        type: type ?? _type,
        img: img ?? _img,
        active: active ?? _active,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get keywords => _keywords;

  int? get parentId => _parentId;

  int? get receiptsCount => _receiptsCount;

  String? get type => _type;

  String? get img => _img;

  bool? get active => _active;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  List<CategoryData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['keywords'] = _keywords;
    map['parent_id'] = _parentId;
    map['type'] = _type;
    map['img'] = _img;
    map['active'] = _active;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
