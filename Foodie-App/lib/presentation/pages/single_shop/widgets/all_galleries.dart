import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';

import '../../../components/buttons/pop_button.dart';
import '../../../theme/app_style.dart';

@RoutePage()
class AllGalleriesPage extends StatelessWidget {
  final GalleriesModel? galleriesModel;

  const AllGalleriesPage({super.key, required this.galleriesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgGrey,
      body: Column(
        children: [
          CommonAppBar(
            child: Text(
              AppHelpers.getTranslation(TrKeys.allGalleries),
              style: Style.interNoSemi(
                size: 18,
                color: Style.black,
              ),
            ),
          ),
          galleriesModel?.galleries?.isNotEmpty ?? false
              ? Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      shrinkWrap: true,
                      itemCount: galleriesModel?.galleries?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.66.r,
                          crossAxisCount: 2,
                          mainAxisExtent: 250.r),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                              border: Border.all(color: Style.borderColor),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: CustomNetworkImage(
                              url: galleriesModel?.galleries?[index].path ?? "",
                              height: 60,
                              width: 60,
                              radius: 8),
                        );
                      }),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 64.r),
                  child: Text(
                    AppHelpers.getTranslation(TrKeys.noGalleries),
                    style: Style.interNoSemi(size: 16),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const PopButton(),
        ),
      ),
    );
  }
}
