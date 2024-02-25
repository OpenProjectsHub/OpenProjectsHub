

import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';

import '../data/translation.dart';


class BranchResponse {
  BranchResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<BranchModel>? data;
  Links? links;
  Meta? meta;

  BranchResponse copyWith({
    List<BranchModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      BranchResponse(
        data: data ?? this.data,
        links: links ?? this.links,
        meta: meta ?? this.meta,
      );

  factory BranchResponse.fromJson(Map<String, dynamic> json) => BranchResponse(
    data: json["data"] == null ? [] : List<BranchModel>.from(json["data"]!.map((x) => BranchModel.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class BranchModel {
  BranchModel({
    this.id,
    this.address,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.shop,
    this.translation,
    this.locales,
  });

  int? id;
  Address? address;
  Location? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  ShopData? shop;
  Translation? translation;
  List<String>? locales;

  BranchModel copyWith({
    int? id,
    Address? address,
    Location? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    ShopData? shop,
    Translation? translation,
    List<String>? locales,
  }) =>
      BranchModel(
        id: id ?? this.id,
        address: address ?? this.address,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shop: shop ?? this.shop,
        translation: translation ?? this.translation,
        locales: locales ?? this.locales,
      );

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"])?.toLocal(),
    updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"])?.toLocal(),
    shop: json["shop"] == null ? null : ShopData.fromJson(json["shop"]),
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address?.toJson(),
    "location": location?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "shop": shop?.toJson(),
    "translation": translation?.toJson(),
    "locales": locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
  };
}

class Address {
  Address({
    this.floor,
    this.house,
    this.office,
    this.address,
  });

  dynamic floor;
  dynamic house;
  dynamic office;
  String? address;

  Address copyWith({
    dynamic floor,
    dynamic house,
    dynamic office,
    String? address,
  }) =>
      Address(
        floor: floor ?? this.floor,
        house: house ?? this.house,
        office: office ?? this.office,
        address: address ?? this.address,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    floor: json["floor"],
    house: json["house"],
    office: json["office"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "floor": floor,
    "house": house,
    "office": office,
    "address": address,
  };
}


class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links copyWith({
    String? first,
    String? last,
    dynamic prev,
    dynamic next,
  }) =>
      Links(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Meta copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Link>? links,
    String? path,
    String? perPage,
    int? to,
    int? total,
  }) =>
      Meta(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
