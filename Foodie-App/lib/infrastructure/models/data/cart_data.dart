import 'dart:convert';

import 'addons_data.dart';
import 'product_data.dart';

CartModel cartFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.timestamp,
    this.status,
    this.message,
    this.data,
  });

  DateTime? timestamp;
  bool? status;
  String? message;
  Cart? data;

  CartModel copyWith({
    DateTime? timestamp,
    bool? status,
    String? message,
    Cart? data,
  }) =>
      CartModel(
        timestamp: timestamp ?? this.timestamp,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      CartModel(
        timestamp: DateTime.tryParse(json["timestamp"])?.toLocal(),
        status: json["status"].runtimeType == int
            ? (json["status"] == 1)
            : json["status"],
        message: json["message"],
        data: Cart.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "timestamp": timestamp?.toIso8601String(),
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Cart {
  Cart({this.id,
    this.ownerId,
    this.shopId,
    this.status,
    this.totalPrice,
    this.totalDiscount,
    this.currencyId,
    this.rate,
    this.createdAt,
    this.updatedAt,
    this.userCarts,
    this.shopTax,
    this.group});

  int? id;
  int? ownerId;
  int? shopId;
  bool? status;
  bool? group;
  num? totalPrice;
  num? totalDiscount;
  int? currencyId;
  num? rate;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? shopTax;
  List<UserCart>? userCarts;

  Cart copyWith({
    int? id,
    int? ownerId,
    int? shopId,
    bool? status,
    bool? group,
    num? totalPrice,
    num? totalDiscount,
    int? currencyId,
    num? rate,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<UserCart>? userCarts,
  }) =>
      Cart(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        shopId: shopId ?? this.shopId,
        status: status ?? this.status,
        group: group ?? this.group,
        totalPrice: totalPrice ?? this.totalPrice,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        currencyId: currencyId ?? this.currencyId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rate: rate ?? this.rate,
        userCarts: userCarts ?? this.userCarts,
      );

  factory Cart.fromJson(Map<String, dynamic> json) =>
      Cart(
        id: json["id"],
        ownerId: json["owner_id"],
        shopId: json["shop_id"],
        status: json["status"].runtimeType == int
            ? (json["status"] == 1)
            : json["status"],
        group: json["group"].runtimeType == int
            ? (json["group"] == 1)
            : json["group"],
        totalPrice: json["total_price"],
        totalDiscount: json["receipt_discount"],
        currencyId: json["currency_id"],
        rate: json["rate"],
        createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
        shopTax: json["shop"] != null ? json["shop"]["avg_rate"] : null,
        userCarts: List<UserCart>.from(
            json["user_carts"].map((x) => UserCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "owner_id": ownerId,
        "shop_id": shopId,
        "status": status,
        "total_price": totalPrice,
        "receipt_discount": totalDiscount,
        "currency_id": currencyId,
        "rate": rate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_carts": List<dynamic>.from(userCarts!.map((x) => x.toJson())),
      };
}

class UserCart {
  UserCart({
    this.id,
    this.cartId,
    this.userId,
    this.status,
    this.name,
    this.uuid,
    this.cartDetails,
  });

  int? id;
  int? cartId;
  int? userId;
  bool? status;
  String? name;
  String? uuid;
  List<CartDetail>? cartDetails;

  UserCart copyWith({
    int? id,
    int? cartId,
    int? userId,
    bool? status,
    String? name,
    String? uuid,
    List<CartDetail>? cartDetails,
  }) =>
      UserCart(
        id: id ?? this.id,
        cartId: cartId ?? this.cartId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        name: name ?? this.name,
        uuid: uuid ?? this.uuid,
        cartDetails: cartDetails ?? this.cartDetails,
      );

  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
      id: json["id"],
      cartId: json["cart_id"],
      userId: json["user_id"],
      status: json["status"].runtimeType == int
          ? (json["status"] == 1)
          : json["status"],
      name: json["name"],
      uuid: json["uuid"],
      cartDetails: json["cartDetails"] != null
          ? List<CartDetail>.from(
          json["cartDetails"].map((x) => CartDetail.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "cart_id": cartId,
        "user_id": userId,
        "status": status,
        "name": name,
        "uuid": uuid,
        "cartDetails": List<dynamic>.from(cartDetails!.map((x) => x.toJson())),
      };
}

class CartDetail {
  CartDetail({
    this.id,
    this.quantity,
    this.bonus,
    this.discount,
    this.price,
    this.updatedAt,
    this.stock,
    this.addons
  });

  int? id;
  int? quantity;
  bool? bonus;
  num? price;
  num? discount;
  DateTime? updatedAt;
  Stocks? stock;
  List<Addons>? addons;

  CartDetail copyWith({
    int? id,
    int? quantity,
    bool? bonus,
    int? price,
    DateTime? updatedAt,
    Stocks? stock,
    List<Addons>? addons,
  }) =>
      CartDetail(
          id: id ?? this.id,
          quantity: quantity ?? this.quantity,
          bonus: bonus ?? this.bonus,
          price: price ?? this.price,
          updatedAt: updatedAt ?? this.updatedAt,
          stock: stock ?? this.stock,
          addons: addons ?? this.addons
      );

  factory CartDetail.fromJson(Map<String, dynamic> json) =>
      CartDetail(
        id: json["id"],
        quantity: json["quantity"],
        bonus: json["bonus"].runtimeType == int
            ? (json["bonus"] == 1)
            : json["bonus"],
        discount: json["discount"],
        price: json["price"],
        updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
        addons: json['addons'] != null
            ? List<Addons>.from(json["addons"]
            .map((x) {
          if (x["product"] != null || x["stock"] != null || x != null) {
            return Addons.fromJson(x);
          }
        })) : null,

        stock: json["stock"] != null ? Stocks.fromJson(json["stock"]) : null,
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "quantity": quantity,
        "bonus": bonus,
        "price": price,
        "updated_at": updatedAt?.toIso8601String(),
        "stock": stock?.toJson(),
      };
}
