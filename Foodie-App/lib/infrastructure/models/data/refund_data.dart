import 'shop_data.dart';

class RefundOrdersModel {
  RefundOrdersModel({
    this.data,
  });

  List<RefundModel>? data;

  factory RefundOrdersModel.fromJson(Map<String, dynamic> json) =>
      RefundOrdersModel(
        data: json["data"] == null
            ? []
            : List<RefundModel>.from(json["data"]!.map((x) => RefundModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RefundModel {
  RefundModel({
    this.id,
    this.status,
    this.cause,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.order,
  });

  int? id;
  String? status;
  String? cause;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;
  Order? order;

  factory RefundModel.fromJson(Map<String, dynamic> json) => RefundModel(
        id: json["id"],
        status: json["status"],
        cause: json["cause"],
        answer: json["answer"],
        createdAt: DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json["updated_at"])?.toLocal(),
        order: json["order"] != null ? Order.fromJson(json["order"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "cause": cause,
        "answer": answer,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order": order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.shop
  });

  int? id;
  ShopData? shop;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        shop: json["shop"] != null ? ShopData.fromJson(json["shop"]) : null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
