import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/order/order_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text_fields/outline_bordered_text_field.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).viewInsets,
      decoration: BoxDecoration(
          color: Style.bgGrey.withOpacity(0.96),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          )),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.verticalSpace,
                  Center(
                    child: Container(
                      height: 4.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                          color: Style.dragElement,
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.r))),
                    ),
                  ),
                  14.verticalSpace,
                  TitleAndIcon(
                    title: AppHelpers.getTranslation(TrKeys.reFound),
                    paddingHorizontalSize: 0,
                  ),
                  24.verticalSpace,
                  OutlinedBorderTextField(
                    textController: textEditingController,
                    label: AppHelpers.getTranslation(TrKeys.whyDoYouWant)
                        .toUpperCase(),
                  ),
                  146.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom+24.h,
                    ),
                    child: Consumer(builder: (context, ref, child) {
                      return CustomButton(
                        isLoading: ref.watch(orderProvider).isButtonLoading,
                        title: AppHelpers.getTranslation(TrKeys.send),
                        onPressed: () {
                          ref
                              .read(orderProvider.notifier)
                              .refundOrder(context, textEditingController.text);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
