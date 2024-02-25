import '../data/recipe_category_data.dart';

class RecipeCategoriesPaginate {
  RecipeCategoriesPaginate({List<RecipeCategoryData>? data}) {
    _data = data;
  }

  RecipeCategoriesPaginate.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RecipeCategoryData.fromJson(v));
      });
    }
  }

  List<RecipeCategoryData>? _data;

  RecipeCategoriesPaginate copyWith({List<RecipeCategoryData>? data}) =>
      RecipeCategoriesPaginate(data: data ?? _data);

  List<RecipeCategoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
