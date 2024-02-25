import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/infrastructure/models/data/recipe_data.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/models/data/user.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/presentation/pages/auth/login/login_page.dart';
import 'package:shoppingapp/presentation/pages/auth/confirmation/register_confirmation_page.dart';
import 'package:shoppingapp/presentation/pages/auth/register/register_page.dart';
import 'package:shoppingapp/presentation/pages/auth/reset/reset_password_page.dart';
import 'package:shoppingapp/presentation/pages/branches/all_branches.dart';
import 'package:shoppingapp/presentation/pages/home/widgets/product_list_screen.dart';
import 'package:shoppingapp/presentation/pages/initial/no_connection/no_connection_page.dart';
import 'package:shoppingapp/presentation/pages/initial/splash/splash_page.dart';
import 'package:shoppingapp/presentation/pages/like/like_page.dart';
import 'package:shoppingapp/presentation/pages/main/main_page.dart';
import 'package:shoppingapp/presentation/pages/order/order_screen/order_screen.dart';
import 'package:shoppingapp/presentation/pages/order/orders_page.dart';
import 'package:shoppingapp/presentation/pages/profile/become_seller/create_shop.dart';
import 'package:shoppingapp/presentation/pages/profile/notification_page.dart';
import 'package:shoppingapp/presentation/pages/profile/wallet_history.dart';
import 'package:shoppingapp/presentation/pages/recipe_details/recipe_details_page.dart';
import 'package:shoppingapp/presentation/pages/setting/setting_page.dart';
import 'package:shoppingapp/presentation/pages/shop/shop_detail.dart';
import 'package:shoppingapp/presentation/pages/shop/shop_page.dart';
import 'package:shoppingapp/presentation/pages/single_shop/single_shop_page.dart';
import 'package:shoppingapp/presentation/pages/single_shop/widgets/all_galleries.dart';
import 'package:shoppingapp/presentation/pages/story_page/story_page.dart';
import 'package:shoppingapp/presentation/pages/view_map/map_search_page.dart';
import 'package:shoppingapp/presentation/pages/view_map/view_map_page.dart';

import '../pages/home/filter/result_filter.dart';
import '../pages/home/widgets/shops_banner_page.dart';
import '../pages/order/order_screen/order_progress_screen.dart';
import '../pages/profile/help_page.dart';
import '../pages/home/widgets/recommended_screen.dart';
import '../pages/profile/share_referral_faq.dart';
import '../pages/profile/share_referral_page.dart';
import '../pages/recipe/recipes_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        MaterialRoute(path: '/', page: SplashRoute.page),
        MaterialRoute(path: '/main', page: MainRoute.page),
        MaterialRoute(path: '/no-connection', page: NoConnectionRoute.page),
        MaterialRoute(path: '/login', page: LoginRoute.page),
        MaterialRoute(path: '/reset', page: ResetPasswordRoute.page),
        MaterialRoute(
            path: '/register-confirmation',
            page: RegisterConfirmationRoute.page),
        MaterialRoute(path: '/register', page: RegisterRoute.page),
        MaterialRoute(path: '/shop', page: ShopRoute.page),
        MaterialRoute(path: '/order', page: OrdersListRoute.page),
        MaterialRoute(path: '/setting', page: SettingRoute.page),
        MaterialRoute(path: '/orderScreen', page: OrderRoute.page),
        MaterialRoute(path: '/map', page: ViewMapRoute.page),
        MaterialRoute(path: "/storyList", page: StoryListRoute.page),
        MaterialRoute(path: '/recommended', page: RecommendedRoute.page),
        MaterialRoute(path: '/map_search', page: MapSearchRoute.page),
        MaterialRoute(path: '/help', page: HelpRoute.page),
        MaterialRoute(path: '/order_progress', page: OrderProgressRoute.page),
        MaterialRoute(path: '/result_filter', page: ResultFilterRoute.page),
        MaterialRoute(path: '/wallet_history', page: WalletHistoryRoute.page),
        MaterialRoute(path: '/create_shop', page: CreateShopRoute.page),
        MaterialRoute(path: '/shops_banner', page: ShopsBannerRoute.page),
        MaterialRoute(path: '/shops_detail', page: ShopDetailRoute.page),
        MaterialRoute(path: '/share_referral', page: ShareReferralRoute.page),
        MaterialRoute(
            path: '/share_referral_faq', page: ShareReferralFaqRoute.page),
        MaterialRoute(path: '/shop_recipe_page', page: ShopRecipesRoute.page),
        MaterialRoute(
            path: '/recipe_details_page', page: RecipeDetailsRoute.page),
        MaterialRoute(path: '/single_shop_page', page: SingleShopRoute.page),
        MaterialRoute(
            path: '/all_galleries_page', page: AllGalleriesRoute.page),
        MaterialRoute(path: '/like_page', page: LikeRoute.page),
        MaterialRoute(path: '/all_branches_page', page: AllBranchesRoute.page),
        MaterialRoute(
            path: '/product_list_screen', page: ProductListRoute.page),
        MaterialRoute(
            path: '/notification_list_page', page: NotificationListRoute.page),
      ];
}

