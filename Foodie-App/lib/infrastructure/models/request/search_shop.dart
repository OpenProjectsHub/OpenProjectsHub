

import 'package:shoppingapp/infrastructure/services/local_storage.dart';

import '../../services/app_constants.dart';

class SearchShopModel {
  final String text;
  final int? categoryId;

  SearchShopModel({
    required this.text,
    this.categoryId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["search"] = text;
    map["perPage"] = 100;
    if(categoryId != null )  map["category_id"] = categoryId;
    map["lang"] = LocalStorage.instance.getLanguage()?.locale ?? "en";
    map["address"] = {
      "latitude" : LocalStorage.instance.getAddressSelected()?.location?.latitude ?? AppConstants.demoLatitude,
      "longitude" : LocalStorage.instance.getAddressSelected()?.location?.longitude ?? AppConstants.demoLongitude
    };
    return map;
  }
}
