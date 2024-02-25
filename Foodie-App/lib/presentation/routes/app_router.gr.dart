// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AllBranchesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AllBranchesPage(),
      );
    },
    AllGalleriesRoute.name: (routeData) {
      final args = routeData.argsAs<AllGalleriesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AllGalleriesPage(
          key: args.key,
          galleriesModel: args.galleriesModel,
        ),
      );
    },
    CreateShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateShopPage(),
      );
    },
    HelpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HelpPage(),
      );
    },
    LikeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LikePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MapSearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapSearchPage(),
      );
    },
    NoConnectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NoConnectionPage(),
      );
    },
    NotificationListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationListPage(),
      );
    },
    OrderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderPage(),
      );
    },
    OrderProgressRoute.name: (routeData) {
      final args = routeData.argsAs<OrderProgressRouteArgs>(
          orElse: () => const OrderProgressRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OrderProgressPage(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    OrdersListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersListPage(),
      );
    },
    ProductListRoute.name: (routeData) {
      final args = routeData.argsAs<ProductListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductListPage(
          key: args.key,
          title: args.title,
          categoryId: args.categoryId,
        ),
      );
    },
    RecipeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecipeDetailsPage(
          key: args.key,
          recipe: args.recipe,
          shopId: args.shopId,
        ),
      );
    },
    RecommendedRoute.name: (routeData) {
      final args = routeData.argsAs<RecommendedRouteArgs>(
          orElse: () => const RecommendedRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecommendedPage(
          key: args.key,
          isNewsOfPage: args.isNewsOfPage,
          isShop: args.isShop,
        ),
      );
    },
    RegisterConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterConfirmationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterConfirmationPage(
          key: args.key,
          userModel: args.userModel,
          isResetPassword: args.isResetPassword,
          verificationId: args.verificationId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(
          key: args.key,
          isOnlyEmail: args.isOnlyEmail,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResetPasswordPage(),
      );
    },
    ResultFilterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResultFilterPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingPage(),
      );
    },
    ShareReferralFaqRoute.name: (routeData) {
      final args = routeData.argsAs<ShareReferralFaqRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShareReferralFaqPage(
          key: args.key,
          terms: args.terms,
        ),
      );
    },
    ShareReferralRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShareReferralPage(),
      );
    },
    ShopDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ShopDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShopDetailPage(
          key: args.key,
          shop: args.shop,
          workTime: args.workTime,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      final args = routeData.argsAs<ShopRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShopPage(
          key: args.key,
          shopId: args.shopId,
          productId: args.productId,
          shop: args.shop,
        ),
      );
    },
    ShopRecipesRoute.name: (routeData) {
      final args = routeData.argsAs<ShopRecipesRouteArgs>(
          orElse: () => const ShopRecipesRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShopRecipesPage(
          key: args.key,
          categoryId: args.categoryId,
          categoryTitle: args.categoryTitle,
        ),
      );
    },
    ShopsBannerRoute.name: (routeData) {
      final args = routeData.argsAs<ShopsBannerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShopsBannerPage(
          key: args.key,
          bannerId: args.bannerId,
          title: args.title,
        ),
      );
    },
    SingleShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SingleShopPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    StoryListRoute.name: (routeData) {
      final args = routeData.argsAs<StoryListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StoryListPage(
          key: args.key,
          index: args.index,
          controller: args.controller,
        ),
      );
    },
    ViewMapRoute.name: (routeData) {
      final args = routeData.argsAs<ViewMapRouteArgs>(
          orElse: () => const ViewMapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewMapPage(
          key: args.key,
          isShopLocation: args.isShopLocation,
          shopId: args.shopId,
        ),
      );
    },
    WalletHistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletHistoryPage(),
      );
    },
  };
}

/// generated route for
/// [AllBranchesPage]
class AllBranchesRoute extends PageRouteInfo<void> {
  const AllBranchesRoute({List<PageRouteInfo>? children})
      : super(
          AllBranchesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllBranchesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AllGalleriesPage]
class AllGalleriesRoute extends PageRouteInfo<AllGalleriesRouteArgs> {
  AllGalleriesRoute({
    Key? key,
    required GalleriesModel? galleriesModel,
    List<PageRouteInfo>? children,
  }) : super(
          AllGalleriesRoute.name,
          args: AllGalleriesRouteArgs(
            key: key,
            galleriesModel: galleriesModel,
          ),
          initialChildren: children,
        );

  static const String name = 'AllGalleriesRoute';

  static const PageInfo<AllGalleriesRouteArgs> page =
      PageInfo<AllGalleriesRouteArgs>(name);
}

class AllGalleriesRouteArgs {
  const AllGalleriesRouteArgs({
    this.key,
    required this.galleriesModel,
  });

  final Key? key;

  final GalleriesModel? galleriesModel;

  @override
  String toString() {
    return 'AllGalleriesRouteArgs{key: $key, galleriesModel: $galleriesModel}';
  }
}

/// generated route for
/// [CreateShopPage]
class CreateShopRoute extends PageRouteInfo<void> {
  const CreateShopRoute({List<PageRouteInfo>? children})
      : super(
          CreateShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateShopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HelpPage]
class HelpRoute extends PageRouteInfo<void> {
  const HelpRoute({List<PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LikePage]
class LikeRoute extends PageRouteInfo<void> {
  const LikeRoute({List<PageRouteInfo>? children})
      : super(
          LikeRoute.name,
          initialChildren: children,
        );

  static const String name = 'LikeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MapSearchPage]
class MapSearchRoute extends PageRouteInfo<void> {
  const MapSearchRoute({List<PageRouteInfo>? children})
      : super(
          MapSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapSearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NoConnectionPage]
class NoConnectionRoute extends PageRouteInfo<void> {
  const NoConnectionRoute({List<PageRouteInfo>? children})
      : super(
          NoConnectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoConnectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationListPage]
class NotificationListRoute extends PageRouteInfo<void> {
  const NotificationListRoute({List<PageRouteInfo>? children})
      : super(
          NotificationListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderPage]
class OrderRoute extends PageRouteInfo<void> {
  const OrderRoute({List<PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderProgressPage]
class OrderProgressRoute extends PageRouteInfo<OrderProgressRouteArgs> {
  OrderProgressRoute({
    Key? key,
    num? orderId,
    List<PageRouteInfo>? children,
  }) : super(
          OrderProgressRoute.name,
          args: OrderProgressRouteArgs(
            key: key,
            orderId: orderId,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderProgressRoute';

  static const PageInfo<OrderProgressRouteArgs> page =
      PageInfo<OrderProgressRouteArgs>(name);
}

class OrderProgressRouteArgs {
  const OrderProgressRouteArgs({
    this.key,
    this.orderId,
  });

  final Key? key;

  final num? orderId;

  @override
  String toString() {
    return 'OrderProgressRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [OrdersListPage]
class OrdersListRoute extends PageRouteInfo<void> {
  const OrdersListRoute({List<PageRouteInfo>? children})
      : super(
          OrdersListRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProductListPage]
class ProductListRoute extends PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    Key? key,
    required String title,
    required int categoryId,
    List<PageRouteInfo>? children,
  }) : super(
          ProductListRoute.name,
          args: ProductListRouteArgs(
            key: key,
            title: title,
            categoryId: categoryId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static const PageInfo<ProductListRouteArgs> page =
      PageInfo<ProductListRouteArgs>(name);
}

class ProductListRouteArgs {
  const ProductListRouteArgs({
    this.key,
    required this.title,
    required this.categoryId,
  });

  final Key? key;

  final String title;

  final int categoryId;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, title: $title, categoryId: $categoryId}';
  }
}

/// generated route for
/// [RecipeDetailsPage]
class RecipeDetailsRoute extends PageRouteInfo<RecipeDetailsRouteArgs> {
  RecipeDetailsRoute({
    Key? key,
    required RecipeData recipe,
    int? shopId,
    List<PageRouteInfo>? children,
  }) : super(
          RecipeDetailsRoute.name,
          args: RecipeDetailsRouteArgs(
            key: key,
            recipe: recipe,
            shopId: shopId,
          ),
          initialChildren: children,
        );

  static const String name = 'RecipeDetailsRoute';

  static const PageInfo<RecipeDetailsRouteArgs> page =
      PageInfo<RecipeDetailsRouteArgs>(name);
}

class RecipeDetailsRouteArgs {
  const RecipeDetailsRouteArgs({
    this.key,
    required this.recipe,
    this.shopId,
  });

  final Key? key;

  final RecipeData recipe;

  final int? shopId;

  @override
  String toString() {
    return 'RecipeDetailsRouteArgs{key: $key, recipe: $recipe, shopId: $shopId}';
  }
}

/// generated route for
/// [RecommendedPage]
class RecommendedRoute extends PageRouteInfo<RecommendedRouteArgs> {
  RecommendedRoute({
    Key? key,
    bool isNewsOfPage = false,
    bool isShop = false,
    List<PageRouteInfo>? children,
  }) : super(
          RecommendedRoute.name,
          args: RecommendedRouteArgs(
            key: key,
            isNewsOfPage: isNewsOfPage,
            isShop: isShop,
          ),
          initialChildren: children,
        );

  static const String name = 'RecommendedRoute';

  static const PageInfo<RecommendedRouteArgs> page =
      PageInfo<RecommendedRouteArgs>(name);
}

class RecommendedRouteArgs {
  const RecommendedRouteArgs({
    this.key,
    this.isNewsOfPage = false,
    this.isShop = false,
  });

  final Key? key;

  final bool isNewsOfPage;

  final bool isShop;

  @override
  String toString() {
    return 'RecommendedRouteArgs{key: $key, isNewsOfPage: $isNewsOfPage, isShop: $isShop}';
  }
}

/// generated route for
/// [RegisterConfirmationPage]
class RegisterConfirmationRoute
    extends PageRouteInfo<RegisterConfirmationRouteArgs> {
  RegisterConfirmationRoute({
    Key? key,
    required UserModel userModel,
    bool isResetPassword = false,
    required String verificationId,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterConfirmationRoute.name,
          args: RegisterConfirmationRouteArgs(
            key: key,
            userModel: userModel,
            isResetPassword: isResetPassword,
            verificationId: verificationId,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterConfirmationRoute';

  static const PageInfo<RegisterConfirmationRouteArgs> page =
      PageInfo<RegisterConfirmationRouteArgs>(name);
}

class RegisterConfirmationRouteArgs {
  const RegisterConfirmationRouteArgs({
    this.key,
    required this.userModel,
    this.isResetPassword = false,
    required this.verificationId,
  });

  final Key? key;

  final UserModel userModel;

  final bool isResetPassword;

  final String verificationId;

  @override
  String toString() {
    return 'RegisterConfirmationRouteArgs{key: $key, userModel: $userModel, isResetPassword: $isResetPassword, verificationId: $verificationId}';
  }
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    required bool isOnlyEmail,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            isOnlyEmail: isOnlyEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.isOnlyEmail,
  });

  final Key? key;

  final bool isOnlyEmail;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, isOnlyEmail: $isOnlyEmail}';
  }
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResultFilterPage]
class ResultFilterRoute extends PageRouteInfo<void> {
  const ResultFilterRoute({List<PageRouteInfo>? children})
      : super(
          ResultFilterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResultFilterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute({List<PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShareReferralFaqPage]
class ShareReferralFaqRoute extends PageRouteInfo<ShareReferralFaqRouteArgs> {
  ShareReferralFaqRoute({
    Key? key,
    required String terms,
    List<PageRouteInfo>? children,
  }) : super(
          ShareReferralFaqRoute.name,
          args: ShareReferralFaqRouteArgs(
            key: key,
            terms: terms,
          ),
          initialChildren: children,
        );

  static const String name = 'ShareReferralFaqRoute';

  static const PageInfo<ShareReferralFaqRouteArgs> page =
      PageInfo<ShareReferralFaqRouteArgs>(name);
}

class ShareReferralFaqRouteArgs {
  const ShareReferralFaqRouteArgs({
    this.key,
    required this.terms,
  });

  final Key? key;

  final String terms;

  @override
  String toString() {
    return 'ShareReferralFaqRouteArgs{key: $key, terms: $terms}';
  }
}

/// generated route for
/// [ShareReferralPage]
class ShareReferralRoute extends PageRouteInfo<void> {
  const ShareReferralRoute({List<PageRouteInfo>? children})
      : super(
          ShareReferralRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShareReferralRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShopDetailPage]
class ShopDetailRoute extends PageRouteInfo<ShopDetailRouteArgs> {
  ShopDetailRoute({
    Key? key,
    required ShopData shop,
    required String workTime,
    List<PageRouteInfo>? children,
  }) : super(
          ShopDetailRoute.name,
          args: ShopDetailRouteArgs(
            key: key,
            shop: shop,
            workTime: workTime,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopDetailRoute';

  static const PageInfo<ShopDetailRouteArgs> page =
      PageInfo<ShopDetailRouteArgs>(name);
}

class ShopDetailRouteArgs {
  const ShopDetailRouteArgs({
    this.key,
    required this.shop,
    required this.workTime,
  });

  final Key? key;

  final ShopData shop;

  final String workTime;

  @override
  String toString() {
    return 'ShopDetailRouteArgs{key: $key, shop: $shop, workTime: $workTime}';
  }
}

/// generated route for
/// [ShopPage]
class ShopRoute extends PageRouteInfo<ShopRouteArgs> {
  ShopRoute({
    Key? key,
    required int shopId,
    String? productId,
    ShopData? shop,
    List<PageRouteInfo>? children,
  }) : super(
          ShopRoute.name,
          args: ShopRouteArgs(
            key: key,
            shopId: shopId,
            productId: productId,
            shop: shop,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const PageInfo<ShopRouteArgs> page = PageInfo<ShopRouteArgs>(name);
}

class ShopRouteArgs {
  const ShopRouteArgs({
    this.key,
    required this.shopId,
    this.productId,
    this.shop,
  });

  final Key? key;

  final int shopId;

  final String? productId;

  final ShopData? shop;

  @override
  String toString() {
    return 'ShopRouteArgs{key: $key, shopId: $shopId, productId: $productId, shop: $shop}';
  }
}

/// generated route for
/// [ShopRecipesPage]
class ShopRecipesRoute extends PageRouteInfo<ShopRecipesRouteArgs> {
  ShopRecipesRoute({
    Key? key,
    int? categoryId,
    String? categoryTitle,
    List<PageRouteInfo>? children,
  }) : super(
          ShopRecipesRoute.name,
          args: ShopRecipesRouteArgs(
            key: key,
            categoryId: categoryId,
            categoryTitle: categoryTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopRecipesRoute';

  static const PageInfo<ShopRecipesRouteArgs> page =
      PageInfo<ShopRecipesRouteArgs>(name);
}

class ShopRecipesRouteArgs {
  const ShopRecipesRouteArgs({
    this.key,
    this.categoryId,
    this.categoryTitle,
  });

  final Key? key;

  final int? categoryId;

  final String? categoryTitle;

  @override
  String toString() {
    return 'ShopRecipesRouteArgs{key: $key, categoryId: $categoryId, categoryTitle: $categoryTitle}';
  }
}

/// generated route for
/// [ShopsBannerPage]
class ShopsBannerRoute extends PageRouteInfo<ShopsBannerRouteArgs> {
  ShopsBannerRoute({
    Key? key,
    required int bannerId,
    required String title,
    List<PageRouteInfo>? children,
  }) : super(
          ShopsBannerRoute.name,
          args: ShopsBannerRouteArgs(
            key: key,
            bannerId: bannerId,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ShopsBannerRoute';

  static const PageInfo<ShopsBannerRouteArgs> page =
      PageInfo<ShopsBannerRouteArgs>(name);
}

class ShopsBannerRouteArgs {
  const ShopsBannerRouteArgs({
    this.key,
    required this.bannerId,
    required this.title,
  });

  final Key? key;

  final int bannerId;

  final String title;

  @override
  String toString() {
    return 'ShopsBannerRouteArgs{key: $key, bannerId: $bannerId, title: $title}';
  }
}

/// generated route for
/// [SingleShopPage]
class SingleShopRoute extends PageRouteInfo<void> {
  const SingleShopRoute({List<PageRouteInfo>? children})
      : super(
          SingleShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'SingleShopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StoryListPage]
class StoryListRoute extends PageRouteInfo<StoryListRouteArgs> {
  StoryListRoute({
    Key? key,
    required int index,
    required RefreshController controller,
    List<PageRouteInfo>? children,
  }) : super(
          StoryListRoute.name,
          args: StoryListRouteArgs(
            key: key,
            index: index,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryListRoute';

  static const PageInfo<StoryListRouteArgs> page =
      PageInfo<StoryListRouteArgs>(name);
}

class StoryListRouteArgs {
  const StoryListRouteArgs({
    this.key,
    required this.index,
    required this.controller,
  });

  final Key? key;

  final int index;

  final RefreshController controller;

  @override
  String toString() {
    return 'StoryListRouteArgs{key: $key, index: $index, controller: $controller}';
  }
}

/// generated route for
/// [ViewMapPage]
class ViewMapRoute extends PageRouteInfo<ViewMapRouteArgs> {
  ViewMapRoute({
    Key? key,
    bool isShopLocation = false,
    int? shopId,
    List<PageRouteInfo>? children,
  }) : super(
          ViewMapRoute.name,
          args: ViewMapRouteArgs(
            key: key,
            isShopLocation: isShopLocation,
            shopId: shopId,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewMapRoute';

  static const PageInfo<ViewMapRouteArgs> page =
      PageInfo<ViewMapRouteArgs>(name);
}

class ViewMapRouteArgs {
  const ViewMapRouteArgs({
    this.key,
    this.isShopLocation = false,
    this.shopId,
  });

  final Key? key;

  final bool isShopLocation;

  final int? shopId;

  @override
  String toString() {
    return 'ViewMapRouteArgs{key: $key, isShopLocation: $isShopLocation, shopId: $shopId}';
  }
}

/// generated route for
/// [WalletHistoryPage]
class WalletHistoryRoute extends PageRouteInfo<void> {
  const WalletHistoryRoute({List<PageRouteInfo>? children})
      : super(
          WalletHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletHistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
