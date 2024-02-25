import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../application/product/product_provider.dart';
import '../../../../../infrastructure/models/data/typed_extra.dart';
import '../../../../../infrastructure/services/app_constants.dart';
import '../../../components/extras/color_extras.dart';
import '../../../components/extras/image_extras.dart';
import '../../../components/extras/text_extras.dart';
import '../../../theme/theme.dart';

class WProductExtras extends ConsumerWidget {
  const WProductExtras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    final notifier = ref.read(productProvider.notifier);

    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: state.typedExtras.isEmpty ? Style.transparent : Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: REdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.typedExtras.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final TypedExtra typedExtra = state.typedExtras[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color:  Style.white,
                ),
                padding: REdgeInsets.symmetric(horizontal: 12, vertical: 14),
                margin: REdgeInsets.only(bottom: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typedExtra.title,
                      style: Style.interNoSemi(
                        size: 16,
                        color:  Style.black ,
                        letterSpacing: -0.4,
                      ),
                    ),
                    16.verticalSpace,
                    typedExtra.type == ExtrasType.text
                        ? TextExtras(
                            uiExtras: typedExtra.uiExtras,
                            groupIndex: typedExtra.groupIndex,
                            onUpdate: (uiExtra) {
                              notifier.updateSelectedIndexes(
                                context,
                                typedExtra.groupIndex,
                                uiExtra.index,
                              );
                            },
                          )
                        : typedExtra.type == ExtrasType.color
                            ? ColorExtras(
                                uiExtras: typedExtra.uiExtras,
                                groupIndex: typedExtra.groupIndex,
                                onUpdate: (uiExtra) {
                                  notifier.updateSelectedIndexes(
                                    context,
                                    typedExtra.groupIndex,
                                    uiExtra.index,
                                  );
                                },
                              )
                            : typedExtra.type == ExtrasType.image
                                ? ImageExtras(
                                    uiExtras: typedExtra.uiExtras,
                                    groupIndex: typedExtra.groupIndex,
                                    updateImage: notifier.changeActiveImageUrl,
                                    onUpdate: (uiExtra) {
                                      notifier.updateSelectedIndexes(
                                        context,
                                        typedExtra.groupIndex,
                                        uiExtra.index,
                                      );
                                    },
                                  )
                                : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
