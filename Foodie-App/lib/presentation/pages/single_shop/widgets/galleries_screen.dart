import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/infrastructure/models/response/Galleries_response.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/custom_network_image.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';


import '../../../theme/app_style.dart';

class GalleriesScreen extends StatelessWidget {
  final GalleriesModel? galleriesModel;

  const GalleriesScreen({super.key, required this.galleriesModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.verticalSpace,
        TitleAndIcon(
          title: AppHelpers.getTranslation(TrKeys.galleries),
          rightTitle: AppHelpers.getTranslation(TrKeys.seeAll),
          onRightTap: (){
            context.pushRoute(AllGalleriesRoute(galleriesModel: galleriesModel));
          },
        ),
        8.verticalSpace,
        SizedBox(
          height: 160,
          child: ListView.builder(
              itemCount: galleriesModel?.galleries?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.r,bottom: 24.r,top: 8.r),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Style.borderColor)
                  ),
                  margin:  EdgeInsets.only(right: 16.r),
                  child: CustomNetworkImage(
                      url: galleriesModel?.galleries?[index].path ?? "",
                      height: 100,
                      width: MediaQuery.of(context).size.width/2+32.w,
                      radius: 8),
                );
              }),
        )
      ],
    );
  }
}
