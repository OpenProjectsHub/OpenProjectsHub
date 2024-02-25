import 'package:shoppingapp/infrastructure/services/local_storage.dart';

class CategoryModel {
  final int page;

  CategoryModel({required this.page});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["lang"] = LocalStorage.instance.getLanguage()?.locale ?? "en";
    map["page"] = page;
    map["type"] = "main";
    map["has_products"] = "1";
    if (LocalStorage.instance.getShopId() != 0) {
      map["p_shop_id"] = LocalStorage.instance.getShopId();
    }

    map["perPage"] = 5;
    return map;
  }

  Map<String, dynamic> toJsonShop() {
    final map = <String, dynamic>{};
    map["lang"] = LocalStorage.instance.getLanguage()?.locale ?? "en";
    map["perPage"] = 100;
    return map;
  }
}
