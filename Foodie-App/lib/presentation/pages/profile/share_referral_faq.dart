import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../infrastructure/services/local_storage.dart';
import '../../components/buttons/pop_button.dart';

@RoutePage()
class ShareReferralFaqPage extends StatefulWidget {
  final String terms;
  const ShareReferralFaqPage({super.key, required this.terms});

  @override
  State<ShareReferralFaqPage> createState() => _ShareReferralFaqPageState();
}

class _ShareReferralFaqPageState extends State<ShareReferralFaqPage> {
  final bool isLtr = LocalStorage.instance.getLangLtr();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Style.bgGrey,
        body: Column(
          children: [
            CommonAppBar(
              child: Text(
                AppHelpers.getTranslation(TrKeys.referralFaq),
                style: Style.interNoSemi(
                  size: 18,
                  color: Style.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                widget.terms,
                style: Style.interNoSemi(
                  size: 20,
                  color: Style.black,
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const PopButton(),
        ),
      ),
    );
  }
}
