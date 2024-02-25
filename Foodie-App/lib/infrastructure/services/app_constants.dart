import 'tr_keys.dart';

class AppConstants {
  AppConstants._();

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyUserId = 'keyUserId';
  static const String keyUserImage = 'keyUser';
  static const String keyToken = 'keyToken';
  static const String keyShopId = 'keyShopId';
  static const String keyCart = 'keyCart';
  static const String keyLocaleCode = 'keyLocaleCode';
  static const String keyFirstName = 'keyFirstName';
  static const String keyLastName = 'keyLastName';
  static const String keyProfileImage = 'keyProfileImage';
  static const String keySavedStores = 'keySavedStores';
  static const String keySearchStores = 'keySearchStores';
  static const String keyViewedProducts = 'keyViewedProducts';
  static const String keyAddressSelected = 'keyAddressSelected';
  static const String keyAddressInformation = 'keyAddressInformation';
  static const String keyIsGuest = 'keyIsGuest';
  static const String keyLocalAddresses = 'keyLocalAddresses';
  static const String keyActiveAddressTitle = 'keyActiveAddressTitle';
  static const String keyLikedProducts = 'keyLikedProducts';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyCartProducts = 'keyCartProducts';
  static const String keyAppThemeMode = 'keyAppThemeMode';
  static const String keyWalletData = 'keyWalletData';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keySettingsFetched = 'keySettingsFetched';
  static const String keyTranslations = 'keyTranslations';
  static const String keyLanguageData = 'keyLanguageData';
  static const String keyAuthenticatedWithSocial = 'keyAuthenticatedWithSocial';
  static const String keyLangLtr = 'keyLangLtr';

  /// hero tags
  static const String heroTagSelectUser = 'heroTagSelectUser';
  static const String heroTagSelectAddress = 'heroTagSelectAddress';
  static const String heroTagSelectCurrency = 'heroTagSelectCurrency';

  /// app strings
  static const String emptyString = '';

  /// api urls
  static const String drawingBaseUrl = 'https://api.openrouteservice.org';
  static const String baseUrl = 'https://single-api.foodyman.org';
  static const String googleApiKey = 'AIzaSyBgNvtPqsuKcgp26ukVPobjKw0Igx2dp5M';
  static const String privacyPolicyUrl = '$baseUrl/privacy-policy';
  static const String adminPageUrl = 'https://single-admin.foodyman.org/';
  static const String webUrl = 'https://single.foodyman.org/';
  static const String dynamicPrefix = 'https://foodymansingle.page.link';
  static const String firebaseWebKey =
      'AIzaSyBgp-Y1H1fZwwfKuneopikYQcF1Kbcs0cg';
  static const String routingKey =
      '5b3ce3597851110001cf62480384c1db92764d1b8959761ea2510ac8';

  /// locales
  static const String localeCodeEn = 'en';

  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  static const Duration timeRefresh = Duration(seconds: 30);

  static List<String> genderList = [TrKeys.male, TrKeys.female];
}

enum ShopStatus { notRequested, newShop, edited, approved, rejected }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
}

enum PriceFilter { byLow, byHigh }

enum ListAlignment { singleBig, vertically, horizontally }

enum ExtrasType { color, text, image }

enum DeliveryTypeEnum { delivery, pickup }

enum ShippingDeliveryVisibilityType {
  cantOrder,
  onlyDelivery,
  onlyPickup,
  both,
}

enum OrderStatus { open, accepted, ready, onWay, delivered, canceled }

enum CouponType { fix, percent }

enum MessageOwner { you, partner }

enum BannerType { banner, look }

enum LookProductStockStatus { outOfStock, alreadyAdded, notAdded }
