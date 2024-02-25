
import 'package:shoppingapp/infrastructure/models/data/product_data.dart';

import '../../../infrastructure/models/data/translation.dart';


class NewProductPagination {
  DateTime? timestamp;
  bool? status;
  String? message;
  List<AllModel>? data;

  NewProductPagination({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  NewProductPagination copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    List<AllModel>? data,
  }) =>
      NewProductPagination(
        timestamp: timestamp ?? this.timestamp,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NewProductPagination.fromJson(Map<String, dynamic> json) =>
      NewProductPagination(
        data: json["data"] == null
            ? []
            : List<AllModel>.from(json["data"]!.map((x) => AllModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "status": status,
        "message": message,
      };
}


class AllModel {
  int? id;
  String? uuid;
  String? type;
  dynamic img;
  bool? active;
  Translation? translation;
  List<String>? locales;
  List<ProductData>? products;

  AllModel({
    this.id,
    this.uuid,
    this.type,
    this.img,
    this.active,
    this.translation,
    this.locales,
    this.products,
  });

  AllModel copyWith({
    int? id,
    String? uuid,
    String? type,
    dynamic img,
    bool? active,
    Translation? translation,
    List<String>? locales,
    List<ProductData>? products,
  }) =>
      AllModel(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        type: type ?? this.type,
        img: img ?? this.img,
        active: active ?? this.active,
        translation: translation ?? this.translation,
        locales: locales ?? this.locales,
        products: products ?? this.products,
      );

  factory AllModel.fromJson(Map<String, dynamic> json) => AllModel(
        id: json["id"],
        uuid: json["uuid"],
        type: json["type"],
        img: json["img"],
        active: json["active"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
        products: json["products"] == null
            ? []
            : List<ProductData>.from(
                json["products"]!.map((x) => ProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "type": type,
        "img": img,
        "active": active,
        "translation": translation?.toJson(),
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
