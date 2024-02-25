class TakeModel {
  int? id;
  String? img;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Translation? translation;

  TakeModel(
      {this.id,
        this.img,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.translation});

  TakeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (translation != null) {
      data['translation'] = translation!.toJson();
    }
    return data;
  }
}

class Translation {
  int? id;
  int? shopTagId;
  String? title;
  String? locale;
  String? deletedAt;

  Translation(
      {this.id, this.shopTagId, this.title, this.locale, this.deletedAt});

  Translation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopTagId = json['shop_tag_id'];
    title = json['title'];
    locale = json['locale'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_tag_id'] = shopTagId;
    data['title'] = title;
    data['locale'] = locale;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
