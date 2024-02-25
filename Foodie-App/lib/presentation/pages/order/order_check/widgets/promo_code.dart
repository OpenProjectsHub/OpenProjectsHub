import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/order/order_provider.dart';
import 'package:shoppingapp/application/promo_code/promo_code_state.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import '../../../../../../application/promo_code/promo_code_notifier.dart';
import '../../../../../../application/promo_code/promo_code_provider.dart';
import '../../../../../application/shop_order/shop_order_provider.dart';
import '../../../../../infrastructure/services/app_constants.dart';
import '../../../../../infrastructure/services/local_storage.dart';
import '../../../../../infrastructure/services/tpying_delay.dart';

class PromoCodeScreen extends ConsumerStatefulWidget {
  const PromoCodeScreen({super.key});

  @override
  ConsumerState<PromoCodeScreen> createState() => _PromoCodeState();
}

class _PromoCodeState extends ConsumerState<PromoCodeScreen> {
  late PromoCodeNotifier event;
  late PromoCodeState state;
  late TextEditingController promoCodeController = TextEditingController();
  final _delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(promoCodeProvider.notifier).change(false);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(promoCodeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    state = ref.watch(promoCodeProvider);
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
                      title: AppHelpers.getTranslation(TrKeys.addPromoCode),
                      paddingHorizontalSize: 0,
                      rightTitle: AppHelpers.getTranslation(TrKeys.clear),
                      rightTitleColor: Style.red,
                      onRightTap: () {
                        promoCodeController.clear();
                      }),
                  24.verticalSpace,
                  OutlinedBorderTextField(
                    textController: promoCodeController,
                    label: AppHelpers.getTranslation(TrKeys.promoCode)
                        .toUpperCase(),
                    onChanged: (s) {
                      _delayed.run(() {
                        event.checkPromoCode(context, s,
                            ref.read(orderProvider).shopData?.id ?? 0);
                      });
                    },
                    suffixIcon: state.isActive
                        ? Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Style.brandGreen),
                            child: Icon(
                              Icons.done_all,
                              color: Style.black,
                              size: 16.r,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  146.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 24.h,
                    ),
                    child: CustomButton(
                      isLoading: state.isLoading,
                      background:
                          state.isActive ? Style.brandGreen : Style.borderColor,
                      textColor: state.isActive ? Style.black : Style.textGrey,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: () {
                        if (state.isActive) {
                          ref
                              .read(orderProvider.notifier)
                              .setPromoCode(promoCodeController.text);
                          ref.read(orderProvider.notifier).getCalculate(
                              context: context,
                              isLoading: false,
                              cartId: ref.read(shopOrderProvider).cart?.id ?? 0,
                              long: LocalStorage.instance
                                      .getAddressSelected()
                                      ?.location
                                      ?.longitude ??
                                  AppConstants.demoLongitude,
                              lat: LocalStorage.instance
                                      .getAddressSelected()
                                      ?.location
                                      ?.latitude ??
                                  AppConstants.demoLatitude,
                              type: ref.read(orderProvider).tabIndex == 1
                                  ? DeliveryTypeEnum.pickup
                                  : DeliveryTypeEnum.delivery);
                          Navigator.pop(context);
                        }
                      },
                    ),
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
