import 'currency_data.dart';
import 'user.dart';
import 'product_data.dart';
import 'address_data.dart';
import 'shop_data.dart';
import 'translation.dart';
import 'review_data.dart';
import 'coupon_data.dart';

class OrderData {
  OrderData({
    int? id,
    int? userId,
    num? price,
    num? currencyPrice,
    num? rate,
    int? orderDetailsCount,
    String? createdAt,
    String? updatedAt,
    CurrencyData? currency,
    UserModel? user,
    List<ShopOrderDetails>? details,
    ReviewData? review,
  }) {
    _id = id;
    _userId = userId;
    _price = price;
    _currencyPrice = currencyPrice;
    _rate = rate;
    _orderDetailsCount = orderDetailsCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _currency = currency;
    _user = user;
    _details = details;
    _review = review;
  }

  OrderData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _price = json['price'];
    _currencyPrice = json['currency_price'];
    _rate = json['rate'];
    _orderDetailsCount = json['order_details_count'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _currency = json['currency'] != null
        ? CurrencyData.fromJson(json['currency'])
        : null;
    _user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['details'] != null) {
      _details = [];
      json['details'].forEach((v) {
        _details?.add(ShopOrderDetails.fromJson(v));
      });
    }
    _review =
        json['review'] != null ? ReviewData.fromJson(json['review']) : null;
  }

  int? _id;
  int? _userId;
  num? _price;
  num? _currencyPrice;
  num? _rate;
  int? _orderDetailsCount;
  String? _createdAt;
  String? _updatedAt;
  CurrencyData? _currency;
  UserModel? _user;
  List<ShopOrderDetails>? _details;
  ReviewData? _review;

  OrderData copyWith({
    int? id,
    int? userId,
    num? price,
    num? currencyPrice,
    num? rate,
    int? orderDetailsCount,
    String? createdAt,
    String? updatedAt,
    CurrencyData? currency,
    UserModel? user,
    List<ShopOrderDetails>? details,
    ReviewData? review,
  }) =>
      OrderData(
        id: id ?? _id,
        userId: userId ?? _userId,
        price: price ?? _price,
        currencyPrice: currencyPrice ?? _currencyPrice,
        rate: rate ?? _rate,
        orderDetailsCount: orderDetailsCount ?? _orderDetailsCount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        currency: currency ?? _currency,
        user: user ?? _user,
        details: details ?? _details,
        review: review ?? _review,
      );

  int? get id => _id;

  num? get userId => _userId;

  num? get price => _price;

  num? get currencyPrice => _currencyPrice;

  num? get rate => _rate;

  int? get orderDetailsCount => _orderDetailsCount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  CurrencyData? get currency => _currency;

  UserModel? get user => _user;

  List<ShopOrderDetails>? get details => _details;

  ReviewData? get review => _review;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['price'] = _price;
    map['currency_price'] = _currencyPrice;
    map['rate'] = _rate;
    map['order_details_count'] = _orderDetailsCount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_details != null) {
      map['details'] = _details?.map((v) => v.toJson()).toList();
    }
    if (_review != null) {
      map['review'] = _review?.toJson();
    }
    return map;
  }
}

class ShopOrderDetails {
  ShopOrderDetails({
    int? id,
    int? shopId,
    num? deliveryFee,
    num? price,
    num? tax,
    String? status,
    String? deliveryDate,
    String? deliveryTime,
    String? createdAt,
    String? updatedAt,
    List<OrderStocks>? orderStocks,
    CouponData? coupon,
    AddressData? deliveryAddress,
    dynamic deliveryman,
    DeliveryType? deliveryType,
    // List<dynamic>? transactions,
    ShopData? shop,
  }) {
    _id = id;
    _shopId = shopId;
    _deliveryFee = deliveryFee;
    _price = price;
    _tax = tax;
    _status = status;
    _deliveryDate = deliveryDate;
    _deliveryTime = deliveryTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _orderStocks = orderStocks;
    _coupon = coupon;
    _deliveryAddress = deliveryAddress;
    _deliveryman = deliveryman;
    _deliveryType = deliveryType;
    // _transactions = transactions;
    _shop = shop;
  }

  ShopOrderDetails.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _deliveryFee = json['delivery_fee'];
    _price = json['price'];
    _tax = json['tax'];
    _status = json['status'];
    _deliveryDate = json['delivery_date'];
    _deliveryTime = json['delivery_time'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['order_stocks'] != null) {
      _orderStocks = [];
      json['order_stocks'].forEach((v) {
        _orderStocks?.add(OrderStocks.fromJson(v));
      });
    }
    _coupon = json['coupon'] != null ? CouponData.fromJson(json['coupon']) : null;
    _deliveryAddress = json['delivery_address'] != null
        ? AddressData.fromJson(json['delivery_address'])
        : null;
    _deliveryman = json['deliveryman'];
    _deliveryType = json['delivery_type'] != null
        ? DeliveryType.fromJson(json['delivery_type'])
        : null;
    // if (json['transactions'] != null) {
    //   _transactions = [];
    //   json['transactions'].forEach((v) {
    //     _transactions?.add(Dynamic.fromJson(v));
    //   });
    // }
    _shop = json['shop'] != null ? ShopData.fromJson(json['shop']) : null;
  }

  int? _id;
  int? _shopId;
  num? _deliveryFee;
  num? _price;
  num? _tax;
  String? _status;
  String? _deliveryDate;
  String? _deliveryTime;
  String? _createdAt;
  String? _updatedAt;
  List<OrderStocks>? _orderStocks;
  CouponData? _coupon;
  AddressData? _deliveryAddress;
  dynamic _deliveryman;
  DeliveryType? _deliveryType;

  // List<dynamic>? _transactions;
  ShopData? _shop;

  ShopOrderDetails copyWith({
    int? id,
    int? shopId,
    num? deliveryFee,
    num? price,
    num? tax,
    String? status,
    String? deliveryDate,
    String? deliveryTime,
    String? createdAt,
    String? updatedAt,
    List<OrderStocks>? orderStocks,
    CouponData? coupon,
    AddressData? deliveryAddress,
    dynamic deliveryman,
    DeliveryType? deliveryType,
    // List<dynamic>? transactions,
    ShopData? shop,
  }) =>
      ShopOrderDetails(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        deliveryFee: deliveryFee ?? _deliveryFee,
        price: price ?? _price,
        tax: tax ?? _tax,
        status: status ?? _status,
        deliveryDate: deliveryDate ?? _deliveryDate,
        deliveryTime: deliveryTime ?? _deliveryTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        orderStocks: orderStocks ?? _orderStocks,
        coupon: coupon ?? _coupon,
        deliveryAddress: deliveryAddress ?? _deliveryAddress,
        deliveryman: deliveryman ?? _deliveryman,
        deliveryType: deliveryType ?? _deliveryType,
        // transactions: transactions ?? _transactions,
        shop: shop ?? _shop,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  num? get deliveryFee => _deliveryFee;

  num? get price => _price;

  num? get tax => _tax;

  String? get status => _status;

  String? get deliveryDate => _deliveryDate;

  String? get deliveryTime => _deliveryTime;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<OrderStocks>? get orderStocks => _orderStocks;

  CouponData? get coupon => _coupon;

  AddressData? get deliveryAddress => _deliveryAddress;

  dynamic get deliveryman => _deliveryman;

  DeliveryType? get deliveryType => _deliveryType;

  // List<dynamic>? get transactions => _transactions;
  ShopData? get shop => _shop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['delivery_fee'] = _deliveryFee;
    map['price'] = _price;
    map['tax'] = _tax;
    map['status'] = _status;
    map['delivery_date'] = _deliveryDate;
    map['delivery_time'] = _deliveryTime;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_orderStocks != null) {
      map['order_stocks'] = _orderStocks?.map((v) => v.toJson()).toList();
    }
    if (_deliveryAddress != null) {
      map['delivery_address'] = _deliveryAddress?.toJson();
    }
    map['deliveryman'] = _deliveryman;
    if (_deliveryType != null) {
      map['delivery_type'] = _deliveryType?.toJson();
    }
    // if (_transactions != null) {
    //   map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    // }
    if (_shop != null) {
      map['shop'] = _shop?.toJson();
    }
    return map;
  }
}

class OrderStocks {
  OrderStocks({
    int? id,
    int? stockId,
    num? originPrice,
    num? tax,
    num? discount,
    int? quantity,
    num? totalPrice,
    String? createdAt,
    String? updatedAt,
    Stocks? stock,
  }) {
    _id = id;
    _stockId = stockId;
    _originPrice = originPrice;
    _tax = tax;
    _discount = discount;
    _quantity = quantity;
    _totalPrice = totalPrice;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _stock = stock;
  }

  OrderStocks.fromJson(dynamic json) {
    _id = json['id'];
    _stockId = json['stock_id'];
    _originPrice = json['origin_price'];
    _tax = json['tax'];
    _discount = json['discount'];
    _quantity = json['quantity'];
    _totalPrice = json['total_price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _stock = json['stock'] != null ? Stocks.fromJson(json['stock']) : null;
  }

  int? _id;
  int? _stockId;
  num? _originPrice;
  num? _tax;
  num? _discount;
  int? _quantity;
  num? _totalPrice;
  String? _createdAt;
  String? _updatedAt;
  Stocks? _stock;

  OrderStocks copyWith({
    int? id,
    int? stockId,
    num? originPrice,
    num? tax,
    num? discount,
    int? quantity,
    num? totalPrice,
    String? createdAt,
    String? updatedAt,
    Stocks? stock,
  }) =>
      OrderStocks(
        id: id ?? _id,
        stockId: stockId ?? _stockId,
        originPrice: originPrice ?? _originPrice,
        tax: tax ?? _tax,
        discount: discount ?? _discount,
        quantity: quantity ?? _quantity,
        totalPrice: totalPrice ?? _totalPrice,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        stock: stock ?? _stock,
      );

  int? get id => _id;

  num? get stockId => _stockId;

  num? get originPrice => _originPrice;

  num? get tax => _tax;

  num? get discount => _discount;

  int? get quantity => _quantity;

  num? get totalPrice => _totalPrice;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Stocks? get stock => _stock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['stock_id'] = _stockId;
    map['origin_price'] = _originPrice;
    map['tax'] = _tax;
    map['discount'] = _discount;
    map['quantity'] = _quantity;
    map['total_price'] = _totalPrice;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_stock != null) {
      map['stock'] = _stock?.toJson();
    }
    return map;
  }
}



class DeliveryType {
  DeliveryType({
    int? id,
    int? shopId,
    String? type,
    int? price,
    List<String>? times,
    String? note,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _shopId = shopId;
    _type = type;
    _price = price;
    _times = times;
    _note = note;
    _active = active;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  DeliveryType.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _type = json['type'];
    _price = json['price'];
    _times = json['times'] != null ? json['times'].cast<String>() : [];
    _note = json['note'];
    _active = json['active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  int? _shopId;
  String? _type;
  int? _price;
  List<String>? _times;
  String? _note;
  bool? _active;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  DeliveryType copyWith({
    int? id,
    int? shopId,
    String? type,
    int? price,
    List<String>? times,
    String? note,
    bool? active,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      DeliveryType(
        id: id ?? _id,
        shopId: shopId ?? _shopId,
        type: type ?? _type,
        price: price ?? _price,
        times: times ?? _times,
        note: note ?? _note,
        active: active ?? _active,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  int? get shopId => _shopId;

  String? get type => _type;

  int? get price => _price;

  List<String>? get times => _times;

  String? get note => _note;

  bool? get active => _active;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['type'] = _type;
    map['price'] = _price;
    map['times'] = _times;
    map['note'] = _note;
    map['active'] = _active;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
