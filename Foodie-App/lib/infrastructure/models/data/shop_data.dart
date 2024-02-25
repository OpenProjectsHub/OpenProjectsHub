// To parse this JSON data, do
//
//     final shopData = shopDataFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'bonus_data.dart';
import 'translation.dart';

ShopData shopDataFromJson(String str) => ShopData.fromJson(json.decode(str));

String shopDataToJson(ShopData data) => json.encode(data.toJson());

class ShopData {
  ShopData({
    this.id,
    this.userId,
    this.tax,
    this.deliveryRange,
    this.percentage,
    this.phone,
    this.visibility,
    this.openTime,
    this.open,
    this.closeTime,
    this.backgroundImg,
    this.logoImg,
    this.minAmount,
    this.status,
    this.type,
    this.deliveryTime,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.productsCount,
    this.translation,
    this.locales,
    this.seller,
    this.bonus,
    this.avgRate,
    this.rateCount,
    this.shopWorkingDays,
    this.isRecommend,
    this.isDiscount,
    this.tags,
    this.shopClosedDate,
    this.shopPayments,
  });

  int? id;
  int? userId;
  num? tax;
  num? deliveryRange;
  num? percentage;
  String? avgRate;
  String? rateCount;
  String? phone;
  num? visibility;
  bool? isRecommend;
  bool? isDiscount;
  bool? open;
  String? openTime;
  String? closeTime;
  String? backgroundImg;
  String? logoImg;
  num? minAmount;
  String? status;
  String? type;
  DeliveryTime? deliveryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  Location? location;
  num? productsCount;
  Translation? translation;
  List<String>? locales;
  List<TagsModel>? tags;
  Seller? seller;
  BonusModel? bonus;
  List<ShopWorkingDay>? shopWorkingDays;
  List<ShopClosedDate>? shopClosedDate;
  List<ShopPayment?>? shopPayments;

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
      id: json["id"] ?? 0,
      // uuid: json["uuid"] ?? 0,
      userId: json["user_id"] ?? 0,
      tax: json["tax"] ?? 0,
      deliveryRange: json["price_per_km"] ?? 0,
      percentage: json["percentage"] ?? 0,
      phone: json["phone"].toString() ,
      visibility: json["visibility"] ?? 0,
      open: (json["open"].runtimeType == int ? (json["open"] == 1) : json["open"]) ?? true,
      openTime: json["open_time"] ?? "00:00",
      closeTime: json["close_time"] ?? "00:00",
      backgroundImg: json["background_img"] ?? "",
      logoImg: json["logo_img"] ?? "",
      minAmount: json["min_amount"] ?? 0,
      status: json["status"] ?? "",
      type: json["type"].runtimeType == int ? (json["type"] == 1 ? "shop" : "restaurant") : json["type"],
      isRecommend: json["is_recommended"] ?? false,
      isDiscount:
          json["discount"] == null ? false : json["discount"].isNotEmpty,
      deliveryTime: json["delivery_time"] == null
          ? null
          : DeliveryTime.fromJson(json["delivery_time"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.tryParse(json["created_at"])?.toLocal(),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"])?.toLocal(),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      productsCount: json["products_count"] ?? 0,
      translation: json["translation"] == null
          ? null
          : Translation.fromJson(json["translation"]),
      tags: json["tags"] == null
          ? null
          : List<TagsModel>.from(
          json["tags"].map((x) => TagsModel.fromJson(x))),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      avgRate: (double.tryParse(json["rating_avg"].toString()) ?? 0.0).toStringAsFixed(1),
      rateCount: (double.tryParse(json["reviews_count"].toString()) ?? 0.0).toStringAsFixed(0),
      bonus: json["bonus"] != null ? BonusModel.fromJson(json["bonus"]) : null,
      shopWorkingDays: json["shop_working_days"] != null
          ? List<ShopWorkingDay>.from(
              json["shop_working_days"].map((x) => ShopWorkingDay.fromJson(x)))
          : [],
      shopClosedDate: json["shop_closed_date"] != null
          ? List<ShopClosedDate>.from(
              json["shop_closed_date"].map((x) => ShopClosedDate.fromJson(x)))
          : [],
      shopPayments: json["shop_payments"] == null
          ? []
          : List<ShopPayment?>.from(json["shop_payments"]!.map((x) {
              if (x["payment"]["active"]) {
                return ShopPayment.fromJson(x);
              }
            })),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,

        "user_id": userId,
        "tax": tax,
        "delivery_range": deliveryRange,
        "percentage": percentage,
        "phone": phone,
        "visibility": visibility,
        "open_time": openTime,
        "close_time": closeTime,
        "background_img": backgroundImg,
        "logo_img": logoImg,
        "min_amount": minAmount,
        "status": status,
        "type": type,
        "delivery_time": deliveryTime == null ? null : deliveryTime?.toJson(),
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "location": location == null ? null : location?.toJson(),
        "products_count": productsCount,
        "translation": translation == null ? null : translation?.toJson(),
        "locales":
            locales == null ? null : List<dynamic>.from(locales!.map((x) => x)),
        "seller": seller == null ? null : seller?.toJson(),
        "bonus": bonus,
      };
}

class DeliveryTime {
  DeliveryTime({
    this.to,
    this.from,
    this.type,
  });

  String? to;
  String? from;
  String? type;

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
        to: json["to"].toString(),
        from: json["from"].toString(),
        type: json["type"] ?? "min",
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "from": from,
        "type": type,
      };
}

class Location {
  Location({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: double.tryParse(json["latitude"].toString()),
        longitude: double.tryParse(json["longitude"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Seller {
  Seller({
    this.id,
    this.firstname,
    this.lastname,
    this.active,
    this.role,
  });

  num? id;
  String? firstname;
  String? lastname;
  bool? active;
  String? role;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        active: json["active"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "active": active,
        "role": role,
      };
}

class ShopClosedDate {
  ShopClosedDate({
    this.id,
    this.day,
    this.createdAt,
    this.updatedAt,
  });

  num? id;
  DateTime? day;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShopClosedDate.fromJson(Map<String, dynamic>? json) => ShopClosedDate(
        id: json?["id"],
        day: DateTime.tryParse(json?["day"])?.toLocal(),
        createdAt: DateTime.tryParse(json?["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json?["updated_at"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ShopWorkingDay {
  ShopWorkingDay({
    this.id,
    this.day,
    this.from,
    this.to,
    this.disabled,
    this.createdAt,
    this.updatedAt,
  });

  num? id;
  String? day;
  String? from;
  bool? disabled;
  String? to;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShopWorkingDay.fromJson(Map<String, dynamic>? json) => ShopWorkingDay(
        id: json?["id"],
        day: json?["day"],
        from: json?["from"],
        disabled: json?["disabled"],
        to: json?["to"],
        createdAt: DateTime.tryParse(json?["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json?["updated_at"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ShopPayment {
  ShopPayment({
    this.id,
    this.shopId,
    this.status,
    this.clientId,
    this.secretId,
    this.payment,
  });

  int? id;
  int? shopId;
  int? status;
  dynamic clientId;
  dynamic secretId;
  Payment? payment;

  factory ShopPayment.fromJson(Map<String, dynamic> json) {
    return ShopPayment(
        id: json["id"],
        shopId: json["shop_id"],
        status: json["status"],
        clientId: json["client_id"],
        secretId: json["secret_id"],
        payment: Payment.fromJson(json["payment"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "status": status,
        "client_id": clientId,
        "secret_id": secretId,
        "payment": payment!.toJson(),
      };
}

class Payment {
  Payment({
    this.id,
    this.tag,
    this.active,
    this.translation,
    this.locales,
  });

  int? id;
  String? tag;
  bool? active;
  dynamic translation;
  List<dynamic>? locales;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        tag: json["tag"],
        active: json["active"],
        translation: json["translation"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "active": active,
        "translation": translation,
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
      };
}

class TagsModel {
  int? id;
  String? img;
  Translation? translation;
  List<String>? locales;

  TagsModel({this.id, this.img, this.translation, this.locales});

  TagsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    if (translation != null) {
      data['translation'] = translation!.toJson();
    }
    data['locales'] = locales;
    return data;
  }
}


