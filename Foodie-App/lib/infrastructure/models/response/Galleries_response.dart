


// ignore_for_file: file_names

class GalleriesResponse {
  GalleriesResponse({
    this.data,
  });

  GalleriesModel? data;

  GalleriesResponse copyWith({
    GalleriesModel? data,
  }) =>
      GalleriesResponse(
        data: data ?? this.data,
      );

  factory GalleriesResponse.fromJson(Map<String, dynamic> json) => GalleriesResponse(
    data: json["data"] == null ? null : GalleriesModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class GalleriesModel {
  GalleriesModel({
    this.id,
    this.active,
    this.shopId,
    this.galleries,
  });

  int? id;
  int? active;
  int? shopId;
  List<Gallery>? galleries;

  GalleriesModel copyWith({
    int? id,
    int? active,
    int? shopId,
    List<Gallery>? galleries,
  }) =>
      GalleriesModel(
        id: id ?? this.id,
        active: active ?? this.active,
        shopId: shopId ?? this.shopId,
        galleries: galleries ?? this.galleries,
      );

  factory GalleriesModel.fromJson(Map<String, dynamic> json) => GalleriesModel(
    id: json["id"],
    active: json["active"],
    shopId: json["shop_id"],
    galleries: json["galleries"] == null ? [] : List<Gallery>.from(json["galleries"]!.map((x) => Gallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "shop_id": shopId,
    "galleries": galleries == null ? [] : List<dynamic>.from(galleries!.map((x) => x.toJson())),
  };
}

class Gallery {
  Gallery({
    this.id,
    this.title,
    this.type,
    this.loadableType,
    this.loadableId,
    this.path,
    this.basePath,
  });

  int? id;
  String? title;
  String? type;
  String? loadableType;
  int? loadableId;
  String? path;
  String? basePath;

  Gallery copyWith({
    int? id,
    String? title,
    String? type,
    String? loadableType,
    int? loadableId,
    String? path,
    String? basePath,
  }) =>
      Gallery(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        loadableType: loadableType ?? this.loadableType,
        loadableId: loadableId ?? this.loadableId,
        path: path ?? this.path,
        basePath: basePath ?? this.basePath,
      );

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    loadableType: json["loadable_type"],
    loadableId: json["loadable_id"],
    path: json["path"],
    basePath: json["base_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "loadable_type": loadableType,
    "loadable_id": loadableId,
    "path": path,
    "base_path": basePath,
  };
}
