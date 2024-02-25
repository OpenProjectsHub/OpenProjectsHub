import 'user.dart';

class ReviewData {
  ReviewData({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    String? updatedAt,
    List<Galleries>? galleries,
    UserModel? user,
  }) {
    _id = id;
    _reviewableId = reviewableId;
    _rating = rating;
    _comment = comment;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _galleries = galleries;
    _user = user;
  }

  ReviewData.fromJson(dynamic json) {
    _id = json['id'];
    _reviewableId = json['reviewable_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _img = json['img'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['galleries'] != null) {
      _galleries = [];
      json['galleries'].forEach((v) {
        _galleries?.add(Galleries.fromJson(v));
      });
    }
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  int? _id;
  int? _reviewableId;
  String? _rating;
  String? _comment;
  String? _img;
  String? _createdAt;
  String? _updatedAt;
  List<Galleries>? _galleries;
  UserModel? _user;

  ReviewData copyWith({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    String? updatedAt,
    List<Galleries>? galleries,
    UserModel? user,
  }) =>
      ReviewData(
        id: id ?? _id,
        reviewableId: reviewableId ?? _reviewableId,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        img: img ?? _img,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        galleries: galleries ?? _galleries,
        user: user ?? _user,
      );

  int? get id => _id;

  int? get reviewableId => _reviewableId;

  String? get rating => _rating;

  String? get comment => _comment;

  String? get img => _img;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Galleries>? get galleries => _galleries;

  UserModel? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reviewable_id'] = _reviewableId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_galleries != null) {
      map['galleries'] = _galleries?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class Galleries {
  Galleries({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? basePath,
  }) {
    _id = id;
    _title = title;
    _type = type;
    _loadableId = loadableId;
    _path = path;
    _basePath = basePath;
  }

  Galleries.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _type = json['type'];
    _loadableId = json['loadable_id'];
    _path = json['path'];
    _basePath = json['base_path'];
  }

  int? _id;
  String? _title;
  String? _type;
  int? _loadableId;
  String? _path;
  String? _basePath;

  Galleries copyWith({
    int? id,
    String? title,
    String? type,
    int? loadableId,
    String? path,
    String? basePath,
  }) =>
      Galleries(
        id: id ?? _id,
        title: title ?? _title,
        type: type ?? _type,
        loadableId: loadableId ?? _loadableId,
        path: path ?? _path,
        basePath: basePath ?? _basePath,
      );

  int? get id => _id;

  String? get title => _title;

  String? get type => _type;

  int? get loadableId => _loadableId;

  String? get path => _path;

  String? get basePath => _basePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['type'] = _type;
    map['loadable_id'] = _loadableId;
    map['path'] = _path;
    map['base_path'] = _basePath;
    return map;
  }
}