
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/language/language_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/components/select_item.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  final VoidCallback onSave;
  const LanguageScreen({
    super.key,
   required this.onSave
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguageScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languageProvider.notifier).getLanguages(context);
    });
  }



  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final event = ref.read(languageProvider.notifier);
    final state = ref.watch(languageProvider);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDismisser(
        child: Container(
          decoration: BoxDecoration(
              color: Style.bgGrey.withOpacity(0.96),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              )),
          width: double.infinity,
          child: state.isLoading
              ? const Loading()
              : Padding(
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
                      24.verticalSpace,
                      TitleAndIcon(
                        title: AppHelpers.getTranslation(TrKeys.language),
                        paddingHorizontalSize: 0,
                        titleSize: 18,
                      ),
                      24.verticalSpace,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return SelectItem(
                              onTap: () {
                                event.change(index);
                              },
                              isActive: state.index == index,
                              title: state.list[index].title ?? "",
                            );
                          }),
                      CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.save),
                          onPressed: () {
                              ref.read(languageProvider.notifier)
                                  .makeSelectedLang(context);
                              widget.onSave();
                          }),
                      24.verticalSpace,
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
