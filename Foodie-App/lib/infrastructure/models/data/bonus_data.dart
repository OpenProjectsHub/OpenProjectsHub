

import 'package:shoppingapp/infrastructure/models/data/product_data.dart';


class BonusModel {
  BonusModel({
    this.bonusableType,
    this.bonusableId,
    this.bonusQuantity,
    this.bonusStockId,
    this.value,
    this.type,
    this.status,
    this.expiredAt,
    this.bonusStock,
   
  });

  String? bonusableType;
  num? bonusableId;
  num? bonusQuantity;
  num? bonusStockId;
  num? value;
  String? type;
  bool? status;
  DateTime? expiredAt;
  BonusStock? bonusStock;
 

  factory BonusModel.fromJson(Map<String, dynamic>? json) {
    return BonusModel(
    bonusableType: json?["bonusable_type"],
    bonusableId: json?["bonusable_id"],
    bonusQuantity: json?["bonus_quantity"],
    bonusStockId: json?["bonus_stock_id"],
    value: json?["value"],
    type: json?["type"],
    expiredAt: DateTime.tryParse(json?["expired_at"])?.toLocal(),
    bonusStock: json?["bonusStock"] != null ? BonusStock.fromJson(json?["bonusStock"]) : null,
  );
  }

  Map<String, dynamic> toJson() => {
    "bonusable_type": bonusableType,
    "bonusable_id": bonusableId,
    "bonus_quantity": bonusQuantity,
    "bonus_stock_id": bonusStockId,
    "value": value,
    "type": type,
    "status": status,
    "expired_at": "${expiredAt?.year.toString().padLeft(4, '0')}-${expiredAt?.month.toString().padLeft(2, '0')}-${expiredAt?.day.toString().padLeft(2, '0')}",
    "bonusStock": bonusStock?.toJson(),
  };
}

class BonusStock {
  BonusStock({
    this.id,
    this.countableId,
    this.price,
    this.quantity,
    this.tax,
    this.totalPrice,
    this.product,
  });

  num? id;
  num? countableId;
  num? price;
  num? quantity;
  num? tax;
  num? totalPrice;
  ProductData? product;

  factory BonusStock.fromJson(Map<String, dynamic> json) => BonusStock(
    id: json["id"] ,
    countableId: json["countable_id"],
    price: json["price"],
    quantity: json["quantity"],
    tax: json["tax"],
    totalPrice: json["total_price"],
    product: json["product"] != null ? ProductData.fromJson(json["product"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countable_id": countableId,
    "price": price,
    "quantity": quantity,
    "tax": tax,
    "total_price": totalPrice,
  };
}


