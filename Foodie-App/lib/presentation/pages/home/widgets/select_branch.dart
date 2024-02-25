import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/select_item.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';

import '../../../theme/app_style.dart';

class SelectBranch extends ConsumerStatefulWidget {
  const SelectBranch({super.key});

  @override
  ConsumerState<SelectBranch> createState() => _SelectBranchState();
}

class _SelectBranchState extends ConsumerState<SelectBranch> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).setInitBranchId();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final event = ref.read(homeProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            8.verticalSpace,
            Center(
              child: Container(
                height: 4.h,
                width: 48.w,
                decoration: BoxDecoration(
                  color: Style.dragElement,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.r),
                  ),
                ),
              ),
            ),
            14.verticalSpace,
            TitleAndIcon(
              title: AppHelpers.getTranslation(TrKeys.chooseBranch),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ref.watch(homeProvider).branches?.length ?? 0,
              itemBuilder: (context, index) {
                return SelectItem(
                  onTap: () {
                    event.changeBranch(state.branches?[index].id ?? 0);
                  },
                  isActive: state.branches?[index].id == state.changeBranchId,
                  title: state.branches?[index].translation?.title ?? "",
                  desc: state.branches?[index].translation?.address ?? "",
                );
              },
              shrinkWrap: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  onPressed: () {
                    event.setBranchId(context);
                  }),
            ),
            16.verticalSpace
          ],
        ),
      ),
    );
  }
}
