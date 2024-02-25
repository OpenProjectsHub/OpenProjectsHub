class ProductCalculateResponse {
  ProductCalculateResponse({
    String? timestamp,
    bool? status,
    String? message,
    CalculatedData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  ProductCalculateResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? CalculatedData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  CalculatedData? _data;

  ProductCalculateResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    CalculatedData? data,
  }) =>
      ProductCalculateResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  CalculatedData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class CalculatedData {
  CalculatedData({
    List<CalculatedProduct>? products,
    num? productTax,
    num? productTotal,
    num? orderTax,
    num? orderTotal,
  }) {
    _products = products;
    _productTax = productTax;
    _productTotal = productTotal;
    _orderTax = orderTax;
    _orderTotal = orderTotal;
  }

  CalculatedData.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(CalculatedProduct.fromJson(v));
      });
    }
    _productTax = json['product_tax'];
    _productTotal = json['product_total'];
    _orderTax = json['order_tax'];
    _orderTotal = json['order_total'];
  }

  List<CalculatedProduct>? _products;
  num? _productTax;
  num? _productTotal;
  num? _orderTax;
  num? _orderTotal;

  CalculatedData copyWith({
    List<CalculatedProduct>? products,
    num? productTax,
    num? productTotal,
    num? orderTax,
    num? orderTotal,
  }) =>
      CalculatedData(
        products: products ?? _products,
        productTax: productTax ?? _productTax,
        productTotal: productTotal ?? _productTotal,
        orderTax: orderTax ?? _orderTax,
        orderTotal: orderTotal ?? _orderTotal,
      );

  List<CalculatedProduct>? get products => _products;

  num? get productTax => _productTax;

  num? get productTotal => _productTotal;

  num? get orderTax => _orderTax;

  num? get orderTotal => _orderTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['product_tax'] = _productTax;
    map['product_total'] = _productTotal;
    map['order_tax'] = _orderTax;
    map['order_total'] = _orderTotal;
    return map;
  }
}

class CalculatedProduct {
  CalculatedProduct({
    int? id,
    num? price,
    int? qty,
    num? tax,
    num? shopTax,
    num? discount,
    num? priceWithoutTax,
    num? totalPrice,
  }) {
    _id = id;
    _price = price;
    _qty = qty;
    _tax = tax;
    _shopTax = shopTax;
    _discount = discount;
    _priceWithoutTax = priceWithoutTax;
    _totalPrice = totalPrice;
  }

  CalculatedProduct.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _qty = json['qty'];
    _tax = json['tax'];
    _shopTax = json['shop_tax'];
    _discount = json['discount'];
    _priceWithoutTax = json['price_without_tax'];
    _totalPrice = json['total_price'];
  }

  int? _id;
  num? _price;
  int? _qty;
  num? _tax;
  num? _shopTax;
  num? _discount;
  num? _priceWithoutTax;
  num? _totalPrice;

  CalculatedProduct copyWith({
    int? id,
    num? price,
    int? qty,
    num? tax,
    num? shopTax,
    num? discount,
    num? priceWithoutTax,
    num? totalPrice,
  }) =>
      CalculatedProduct(
        id: id ?? _id,
        price: price ?? _price,
        qty: qty ?? _qty,
        tax: tax ?? _tax,
        shopTax: shopTax ?? _shopTax,
        discount: discount ?? _discount,
        priceWithoutTax: priceWithoutTax ?? _priceWithoutTax,
        totalPrice: totalPrice ?? _totalPrice,
      );

  int? get id => _id;

  num? get price => _price;

  int? get qty => _qty;

  num? get tax => _tax;

  num? get shopTax => _shopTax;

  num? get discount => _discount;

  num? get priceWithoutTax => _priceWithoutTax;

  num? get totalPrice => _totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['qty'] = _qty;
    map['tax'] = _tax;
    map['shop_tax'] = _shopTax;
    map['discount'] = _discount;
    map['price_without_tax'] = _priceWithoutTax;
    map['total_price'] = _totalPrice;
    return map;
  }
}
