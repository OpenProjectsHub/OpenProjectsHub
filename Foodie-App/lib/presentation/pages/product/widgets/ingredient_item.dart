import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:shoppingapp/application/product/product_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/addons_data.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:intl/intl.dart' as intl;

import '../../../components/custom_checkbox.dart';

class IngredientItem extends ConsumerWidget {
  final VoidCallback onTap;
  final VoidCallback add;
  final VoidCallback remove;
  final Addons addon;

  const IngredientItem({
    required this.add,
    required this.remove,
    super.key,
    required this.onTap,
    required this.addon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.read(productProvider);
    return GestureDetector(
      onTap: () {
        onTap();
        Vibrate.feedback(FeedbackType.selection);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCheckbox(
                  isActive: addon.active ?? false,
                  onTap: onTap,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          addon.product?.translation?.title ?? "",
                          style: Style.interNormal(
                            size: 16,
                            color: Style.black,
                          ),
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "+${intl.NumberFormat.currency(
                          symbol: LocalStorage.instance
                              .getSelectedCurrency()
                              .symbol,
                        ).format(addon.product?.stock?.totalPrice ?? 0)}",
                        style: Style.interNoSemi(
                          size: 14,
                          color: Style.textGrey,
                        ),
                      )
                    ],
                  ),
                ),

                ((addon.active ?? false) || !productState.isLoading)
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: remove,
                            icon: Icon(
                              Icons.remove,
                              color: (addon.quantity ?? 1) == 1
                                  ? Style.outlineButtonBorder
                                  : Style.black,
                            ),
                          ),
                          Text(
                            "${addon.quantity ?? 1}",
                            style: Style.interNormal(
                              size: 16.sp,
                            ),
                          ),
                          IconButton(
                            onPressed: add,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
            Divider(
              color: Style.textGrey.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }
}
