import '../data/recipe_data.dart';

class RecipesPaginateResponse {
  RecipesPaginateResponse({List<RecipeData>? data}) {
    _data = data;
  }

  RecipesPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RecipeData.fromJson(v));
      });
    }
  }

  List<RecipeData>? _data;

  RecipesPaginateResponse copyWith({List<RecipeData>? data}) =>
      RecipesPaginateResponse(data: data ?? _data);

  List<RecipeData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
