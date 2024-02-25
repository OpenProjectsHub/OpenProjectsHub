import 'product_data.dart';

class CartProductData {
  CartProductData({
    num? shopId,
    num? id,
    num? price,
    int? quantity,
    String? imageUrl,
    String? title,
    Stocks? selectedStock,
  }) {
    _shopId = shopId;
    _id = id;
    _price = price;
    _quantity = quantity;
    _imageUrl = imageUrl;
    _title = title;
    _selectedStock = selectedStock;
  }

  CartProductData.fromJson(dynamic json) {
    _shopId = json["shop_id"];
    _id = json["id"];
    _price = json["price"];
    _quantity = json['quantity'];
    _imageUrl = json['image_url'];
    _title = json['title'];
    _selectedStock = json['selected_stock'] != null
        ? Stocks.fromJson(json['selected_stock'])
        : null;
  }

  num? _price;
  int? _quantity;
  num? _shopId;
  num? _id;
  String? _imageUrl;
  String? _title;
  Stocks? _selectedStock;

  CartProductData copyWith({
    num? shopId,
    num? id,
    int? quantity,
    String? imageUrl,
    String? title,
    Stocks? selectedStock,
  }) {
    return CartProductData(
        shopId: shopId ?? _shopId,
        quantity: quantity ?? _quantity,
        imageUrl: imageUrl ?? _imageUrl,
        title: title ?? _title,
        selectedStock: selectedStock ?? _selectedStock,
        price: price ?? _price,
        id: id ?? _id);
  }

  num? get price => _price;

  num? get id => _id;

  num? get shopId => _shopId;

  int? get quantity => _quantity;

  String? get imageUrl => _imageUrl;

  String? get title => _title;

  Stocks? get selectedStock => _selectedStock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["shop_id"] = _shopId;
    map['id'] = _id;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['image_url'] = _imageUrl;
    map['title'] = _title;
    if (_selectedStock != null) {
      map['selected_stock'] = selectedStock?.toJson();
    }
    return map;
  }
}
