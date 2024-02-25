

import 'dart:convert';


GetCalculateModel getCalculateModelFromJson(String str) => GetCalculateModel.fromJson(json.decode(str));

String getCalculateModelToJson(GetCalculateModel data) => json.encode(data.toJson());

class GetCalculateModel {
  GetCalculateModel({
    this.totalTax,
    this.price,
    this.totalShopTax,
    this.totalPrice,
    this.totalDiscount,
    this.bonusShop,
    this.deliveryFee,
    this.rate,
    this.couponPrice,
  });

  num? totalTax;
  num? price;
  num? totalShopTax;
  num? totalPrice;
  num? totalDiscount;
  dynamic bonusShop;
  num? deliveryFee;
  num? rate;
  num? couponPrice;

  factory GetCalculateModel.fromJson(Map<String, dynamic> json) => GetCalculateModel(
    totalTax: json["total_tax"],
    price: json["price"],
    totalShopTax: json["total_shop_tax"],
    totalPrice: json["total_price"],
    totalDiscount: json["total_discount"],
    bonusShop: json["bonus_shop"],
    deliveryFee: json["delivery_fee"],
    rate: json["rate"],
    couponPrice: json["coupon_price"],
  );

  Map<String, dynamic> toJson() => {
    "total_tax": totalTax,
    "price": price,
    "total_shop_tax": totalShopTax,
    "total_price": totalPrice,
    "total_discount": totalDiscount,
    "bonus_shop": bonusShop,
    "delivery_fee": deliveryFee,
    "rate": rate,
    "coupon_price": couponPrice,
  };
}


