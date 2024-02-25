import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/data/addons_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import 'ingredient_item.dart';

class WIngredientScreen extends StatelessWidget {
  final List<Addons> list;
  final ValueChanged<int> onChange;
  final ValueChanged<int> add;
  final ValueChanged<int> remove;

  const WIngredientScreen(
      {required this.list,
      super.key,
      required this.onChange,
      required this.add,
      required this.remove});

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? const SizedBox.shrink()
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: list.isEmpty ? Style.transparent : Style.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: REdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleAndIcon(
                  title: AppHelpers.getTranslation(TrKeys.ingredients),
                ),
                16.verticalSpace,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return IngredientItem(
                      onTap: () {
                        onChange(index);
                      },
                      addon: list[index],
                      add: () {
                        add(index);
                      },
                      remove: () {
                        remove(index);
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }
}
