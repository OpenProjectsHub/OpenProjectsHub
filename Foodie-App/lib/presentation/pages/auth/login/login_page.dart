// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/language/language_provider.dart';
import 'package:shoppingapp/application/main/main_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/pages/auth/register/register_page.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:upgrader/upgrader.dart';
import '../../../theme/theme.dart';
import '../../profile/language_page.dart';
import 'login_screen.dart';
import '../../../../application/login/login_provider.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).checkLanguage(context);
    });
    initDynamicLinks();
    super.initState();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      String link = dynamicLinkData.link
          .toString()
          .substring(dynamicLinkData.link.toString().indexOf("shop") + 4);
      if (link.toString().contains("product") ||
          link.toString().contains("shop") ||
          link.toString().contains("restaurant")) {
        context.pushRoute(
          const MainRoute(),
        );
      }
    }).onError((error) {
      debugPrint(error.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink.toString().contains("product") ||
        deepLink.toString().contains("shop") ||
        deepLink.toString().contains("restaurant")) {
      context.pushRoute(
        const MainRoute(),
      );
    }
  }

  void selectLanguage() {
    AppHelpers.showCustomModalBottomSheet(
        isDismissible: false,
        isDrag: false,
        context: context,
        modal: LanguageScreen(
          onSave: () {
            Navigator.pop(context);
          },
        ),
        isDarkMode: false);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(languageProvider);
    ref.listen(loginProvider, (previous, next) {
      if (!next.isSelectLanguage &&
          !((previous?.isSelectLanguage ?? false) == next.isSelectLanguage)) {
        selectLanguage();
      }
    });

    final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return UpgradeAlert(
      child: Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:
              isDarkMode ? Style.dontHaveAnAccBackDark : Style.white,
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/splash.png",
              ),
              fit: BoxFit.fill,
            )),
            child: SafeArea(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppHelpers.getAppName() ?? "",
                            style: Style.interSemi(color: Style.white),
                          ),
                        ),
                        8.horizontalSpace,
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            ref.read(mainProvider.notifier).selectIndex(0);
                            context.replaceRoute(const MainRoute());
                          },
                          child: Text(
                            AppHelpers.getTranslation(TrKeys.skip),
                            style: Style.interSemi(
                              size: 16.sp,
                              color: Style.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.login),
                          onPressed: () {
                            AppHelpers.showCustomModalBottomSheet(
                              context: context,
                              modal: const LoginScreen(),
                              isDarkMode: isDarkMode,
                            );
                          },
                        ),
                        10.verticalSpace,
                        CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.register),
                          onPressed: () {
                            AppHelpers.showCustomModalBottomSheet(
                                context: context,
                                modal: const RegisterPage(
                                  isOnlyEmail: true,
                                ),
                                isDarkMode: isDarkMode,
                                paddingTop: MediaQuery.of(context).padding.top);
                          },
                          background: Style.transparent,
                          textColor: Style.white,
                          borderColor: Style.white,
                        ),
                        22.verticalSpace,
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
