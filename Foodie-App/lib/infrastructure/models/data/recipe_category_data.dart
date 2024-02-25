import 'recipe_data.dart';
import 'translation.dart';

class RecipeCategoryData {
  RecipeCategoryData({
    int? id,
    String? status,
    String? createdAt,
    String? image,
    int? parentId,
    int? recipesCount,
    List<RecipeCategoryChild>? child,
    List<RecipeData>? recipes,
    Translation? translation,
  }) {
    _id = id;
    _status = status;
    _createdAt = createdAt;
    _image = image;
    _parentId = parentId;
    _recipesCount = recipesCount;
    _child = child;
    _recipes = recipes;
    _translation = translation;
  }

  RecipeCategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _image = json['image'];
    _parentId = json['parent_id'];
    _recipesCount = json['recipes_count'];
    if (json['child'] != null) {
      _child = [];
      json['child'].forEach((v) {
        _child?.add(RecipeCategoryChild.fromJson(v));
      });
    }
    if (json['recipes'] != null) {
      _recipes = [];
      json['recipes'].forEach((v) {
        _recipes?.add(RecipeData.fromJson(v));
      });
    }
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _status;
  String? _createdAt;
  String? _image;
  int? _parentId;
  int? _recipesCount;
  List<RecipeCategoryChild>? _child;
  List<RecipeData>? _recipes;
  Translation? _translation;

  RecipeCategoryData copyWith({
    int? id,
    String? status,
    String? createdAt,
    String? image,
    int? parentId,
    int? recipesCount,
    List<RecipeCategoryChild>? child,
    List<RecipeData>? recipes,
    Translation? translation,
  }) =>
      RecipeCategoryData(
        id: id ?? _id,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        image: image ?? _image,
        parentId: parentId ?? _parentId,
        recipesCount: recipesCount ?? _recipesCount,
        child: child ?? _child,
        recipes: recipes ?? _recipes,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get image => _image;

  int? get parentId => _parentId;

  int? get recipesCount => _recipesCount;

  List<RecipeCategoryChild>? get child => _child;

  List<RecipeData>? get recipes => _recipes;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['image'] = _image;
    map['parent_id'] = _parentId;
    map['recipes_count'] = _recipesCount;
    if (_child != null) {
      map['child'] = _child?.map((v) => v.toJson()).toList();
    }
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class RecipeCategoryChild {
  RecipeCategoryChild({
    int? id,
    String? status,
    String? createdAt,
    String? image,
    int? parentId,
    int? recipesCount,
    List<RecipeData>? recipes,
    Translation? translation,
  }) {
    _id = id;
    _status = status;
    _createdAt = createdAt;
    _image = image;
    _parentId = parentId;
    _recipesCount = recipesCount;
    _recipes = recipes;
    _translation = translation;
  }

  RecipeCategoryChild.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _image = json['image'];
    _parentId = json['parent_id'];
    _recipesCount = json['recipes_count'];
    if (json['recipes'] != null) {
      _recipes = [];
      json['recipes'].forEach((v) {
        _recipes?.add(RecipeData.fromJson(v));
      });
    }
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _status;
  String? _createdAt;
  String? _image;
  int? _parentId;
  int? _recipesCount;
  List<RecipeData>? _recipes;
  Translation? _translation;

  RecipeCategoryChild copyWith({
    int? id,
    String? status,
    String? createdAt,
    String? image,
    int? parentId,
    int? recipesCount,
    List<RecipeData>? recipes,
    Translation? translation,
  }) =>
      RecipeCategoryChild(
        id: id ?? _id,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        image: image ?? _image,
        parentId: parentId ?? _parentId,
        recipesCount: recipesCount ?? _recipesCount,
        recipes: recipes ?? _recipes,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get status => _status;

  String? get createdAt => _createdAt;

  String? get image => _image;

  int? get parentId => _parentId;

  int? get recipesCount => _recipesCount;

  List<RecipeData>? get recipes => _recipes;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['image'] = _image;
    map['parent_id'] = _parentId;
    map['recipes_count'] = _recipesCount;
    if (_recipes != null) {
      map['recipes'] = _recipes?.map((v) => v.toJson()).toList();
    }
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
