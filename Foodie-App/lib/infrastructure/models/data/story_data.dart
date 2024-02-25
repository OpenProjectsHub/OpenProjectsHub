

import 'dart:convert';

List<List<StoryModel?>?>? storyModelFromJson(dynamic str) => str == null ? [] : List<List<StoryModel?>?>.from(str.map((x) => x == null ? [] : List<StoryModel?>.from(x!.map((x) => StoryModel.fromJson(x)))));

String storyModelToJson(List<List<StoryModel?>?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x == null ? [] : List<dynamic>.from(x.map((x) => x!.toJson())))));


class StoryModel {
  StoryModel({
    this.shopId,
    this.logoImg,
    this.title,
    this.productUuid,
    this.productTitle,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  int? shopId;
  String? logoImg;
  String? title;
  String? productUuid;
  String? productTitle;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
    shopId: json["shop_id"],
    logoImg: json["logo_img"],
    title: json["title"],
      productUuid: json["product_uuid"],
    productTitle: json["product_title"],
    url: json["url"],
    createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
  );
  }

  Map<String, dynamic> toJson() => {
    "shop_id": shopId,
    "logo_img": logoImg,
    "title": title,
    "product_id": productUuid,
    "product_title": productTitle,
    "url": url,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
