import 'cart_product_data.dart';
import 'shop_data.dart';

class ShopTotalData {
  final ShopData shopData;
  final double shopTax;
  final double onlyShopTax;
  final double discount;
  final double totalPrice;
  final List<CartProductData> cartProducts;

  ShopTotalData(
    this.shopData, {
    required this.shopTax,
    required this.onlyShopTax,
    required this.discount,
    required this.totalPrice,
    required this.cartProducts,
  });
}
