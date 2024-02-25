import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';

class BannersRequest {
  final int page;


  BannersRequest({
    required this.page
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["page"] = page;
    if (LocalStorage.instance.getShopId() != 0){
      map["shop_id"] = LocalStorage.instance.getShopId();
    }
    map["perPage"] = 5;
    map["lang"] = LocalStorage.instance.getLanguage()?.locale ?? "en";
    map["address"] = {
      "latitude" : LocalStorage.instance.getAddressSelected()?.location?.latitude ?? AppConstants.demoLatitude,
      "longitude" : LocalStorage.instance.getAddressSelected()?.location?.longitude ?? AppConstants.demoLongitude
    };
    return map;
  }
}
