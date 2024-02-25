// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/add_card/add_card_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'widgets/add_card.dart';
import 'widgets/card_clear_dialog.dart';

class AddToScreen extends ConsumerStatefulWidget {
  const AddToScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddToPageState();
}

class _AddToPageState extends ConsumerState<AddToScreen> {
  TextEditingController cardNumberTextController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  TextEditingController expirationDateTextController =
      MaskedTextController(mask: '00/00');
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController cvcTextController = MaskedTextController(mask: '000');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(addCardProvider);
    });
    super.initState();
  }

  @override
  void dispose() {
    cardNumberTextController.dispose();
    expirationDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final state = ref.watch(addCardProvider);
    final event = ref.read(addCardProvider.notifier);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDismisser(
        child: Container(
          margin: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
              color: Style.bgGrey.withOpacity(0.96),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              )),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
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
                          borderRadius: BorderRadius.all(Radius.circular(40.r))),
                    ),
                  ),
                  24.verticalSpace,
                  TitleAndIcon(
                    title: AppHelpers.getTranslation(TrKeys.addNewCart),
                    paddingHorizontalSize: 0,
                    titleSize: 18,
                    rightTitle: AppHelpers.getTranslation(TrKeys.clear),
                    rightTitleColor: Style.red,
                    onRightTap: () {
                      ref.refresh(addCardProvider);
                      cardNumberTextController.clear();
                      expirationDateTextController.clear();
                      fullNameTextController.clear();
                      cvcTextController.clear();
                    },
                  ),
                  24.verticalSpace,
                  AddCardWidget(
                    number: state.cardNumber,
                    startDate: state.date,
                    name: state.cardName,
                    isActive: state.isActiveCard,
                  ),
                  34.verticalSpace,
                  OutlinedBorderTextField(
                    label: AppHelpers.getTranslation(TrKeys.cardNumber)
                        .toUpperCase(),
                    onChanged: (s) =>
                        event.setCardNumber(cardNumberTextController.text),
                    textController: cardNumberTextController,
                    inputType: TextInputType.number,
                  ),
                  34.verticalSpace,
                  OutlinedBorderTextField(
                    label:
                        AppHelpers.getTranslation(TrKeys.fullName).toUpperCase(),
                    onChanged: (s) => event.setCardName(s),
                    textController: fullNameTextController,
                  ),
                  34.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: OutlinedBorderTextField(
                          label: AppHelpers.getTranslation(TrKeys.expiredDate)
                              .toUpperCase(),
                          onChanged: (s) =>
                              event.setDate(expirationDateTextController.text),
                          textController: expirationDateTextController,
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: OutlinedBorderTextField(
                          label:
                              AppHelpers.getTranslation(TrKeys.cvc).toUpperCase(),
                          onChanged: (s) => event.setCvc(s),
                          textController: cvcTextController,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  60.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom),
                    child: CustomButton(
                      background: state.isActiveCard
                          ? Style.brandGreen
                          : Style.white,
                      textColor: state.isActiveCard
                          ? Style.black
                          : Style.textGrey,
                      title: AppHelpers.getTranslation(TrKeys.save),
                      onPressed: state.isActiveCard
                          ? () {
                              AppHelpers.showAlertDialog(
                                context: context,
                                child: CardClearDialog(
                                  cancel: () {
                                    Navigator.pop(context);
                                  },
                                  clear: () {
                                    //TODO clear
                                    Navigator.pop(context);
                                  },
                                  cardName: '8600 14 ** **** 7514',
                                ),
                                radius: 10,
                              );

                              //TODO save
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
