import 'translation.dart';

class BlogData {
  BlogData({
    int? id,
    String? uuid,
    int? userId,
    String? type,
    String? publishedAt,
    bool? active,
    String? img,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _uuid = uuid;
    _userId = userId;
    _type = type;
    _publishedAt = publishedAt;
    _active = active;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  BlogData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _userId = json['user_id'];
    _type = json['type'];
    _publishedAt = json['published_at'];
    _active = json['active'];
    _img = json['img'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _uuid;
  int? _userId;
  String? _type;
  String? _publishedAt;
  bool? _active;
  String? _img;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  BlogData copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? type,
    String? publishedAt,
    bool? active,
    String? img,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      BlogData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        userId: userId ?? _userId,
        type: type ?? _type,
        publishedAt: publishedAt ?? _publishedAt,
        active: active ?? _active,
        img: img ?? _img,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  int? get userId => _userId;

  String? get type => _type;

  String? get publishedAt => _publishedAt;

  bool? get active => _active;

  String? get img => _img;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['published_at'] = _publishedAt;
    map['active'] = _active;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}