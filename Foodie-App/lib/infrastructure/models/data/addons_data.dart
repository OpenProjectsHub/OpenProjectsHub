import 'package:shoppingapp/infrastructure/models/data/translation.dart';

import 'product_data.dart';

// To parse this JSON data, do
//
//     final addons = addonsFromJson(jsonString);

import 'dart:convert';

Addons addonsFromJson(String str) => Addons.fromJson(json.decode(str));

String addonsToJson(Addons data) => json.encode(data.toJson());

class Addons {
  Addons({
    required this.id,
    required this.stockId,
    required this.addonId,
    required this.product,
    required this.price,
    required this.quantity,
    required this.stocks,
    this.active,
  });

  int? id;
  int? stockId;
  int? addonId;
  int? quantity;
  num? price;
  bool? active;
  Product? product;
  Stocks? stocks;

  factory Addons.fromJson(Map<String, dynamic>? json) {
    return Addons(
      id: json?["id"],
      stockId: json?["stock_id"],
      addonId: json?["addon_id"],
      active: false,
      product: (json?["product"] == null) ? null : Product.fromJson(json?["product"]),
      stocks: json?["stock"] == null ? null : Stocks.fromJson(json?["stock"]),
      quantity: json?["quantity"] ?? json?["product"]["min_qty"] ?? 0,
      price: json?["price"] ?? json?["total_price"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "stock_id": stockId,
        "addon_id": addonId,
        "product": product?.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.uuid,
    this.shopId,
    this.categoryId,
    this.brandId,
    this.tax,
    this.barCode,
    this.status,
    this.active,
    this.addon,
    this.img,
    this.minQty,
    this.maxQty,
    this.createdAt,
    this.updatedAt,
    this.ratingPercent,
    this.translation,
    this.locales,
    this.stock,
    this.reviews,
  });

  int? id;
  String? uuid;
  int? shopId;
  int? categoryId;
  int? brandId;
  num? tax;
  String? barCode;
  String? status;
  bool? active;
  bool? addon;
  String? img;
  int? minQty;
  int? maxQty;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic ratingPercent;
  Translation? translation;
  List<String>? locales;
  Stocks? stock;
  List<dynamic>? reviews;

  factory Product.fromJson(Map<String, dynamic>? json) {
    return Product(
      id: json?["id"],
      uuid: json?["uuid"],
      shopId: json?["shop_id"],
      categoryId: json?["category_id"],
      brandId: json?["brand_id"],
      tax: json?["tax"],
      barCode: json?["bar_code"],
      status: json?["status"],
      active: json?["active"],
      addon: json?["addon"],
      img: json?["img"],
      minQty: json?["min_qty"],
      maxQty: json?["max_qty"],
      translation: Translation.fromJson(json?["translation"]),
      stock: json?["stock"] == null ? null : Stocks.fromJson(json?["stock"]),
      reviews: [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "shop_id": shopId,
        "category_id": categoryId,
        "brand_id": brandId,
        "tax": tax,
        "bar_code": barCode,
        "status": status,
        "active": active,
        "addon": addon,
        "img": img,
        "min_qty": minQty,
        "max_qty": maxQty,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rating_percent": ratingPercent,
        "translation": translation?.toJson(),
      };
}
