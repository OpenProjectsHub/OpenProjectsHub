import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/app_style.dart';
import 'maps_list.dart';

class InfoScreen extends StatelessWidget {
  final ShopData? shop;
  final TimeOfDay endTodayTime;
  final TimeOfDay startTodayTime;
  final Set<Marker> shopMarker;

  const InfoScreen(
      {super.key,
      this.shop,
      required this.endTodayTime,
      required this.startTodayTime,
      required this.shopMarker});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 15.r),
      decoration: BoxDecoration(
          color: Style.white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.verticalSpace,
          TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.info)),
          16.verticalSpace,
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
            height: 350.h,
            child: GoogleMap(
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                bearing: 0,
                target: LatLng(shop?.location?.latitude ?? 0,
                    shop?.location?.longitude ?? 0),
                tilt: 0,
                zoom: 17,
              ),
              markers: shopMarker,
            ),
          ),
          16.verticalSpace,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Style.unselectedOrderStatus)),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 20.r),
                itemCount: shop?.shopWorkingDays?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${shop?.shopWorkingDays?[index].day}".toUpperCase(),
                          style: Style.interNormal(size: 14),
                        ),
                        2.verticalSpace,
                        Text(
                            "${shop?.shopWorkingDays?[index].from} - ${shop?.shopWorkingDays?[index].to}"),
                      ],
                    ),
                  );
                }),
          ),
          16.verticalSpace,
          InkWell(
            onTap: (){
              AppHelpers.showCustomModalBottomSheet(
                  context: context,
                  modal: Container(
                    decoration: BoxDecoration(
                      color: Style.bgGrey.withOpacity(0.96),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Padding(
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(40.r))),
                            ),
                          ),
                          24.verticalSpace,
                          MapsList(
                              location: Coords(
                                shop?.location?.latitude ?? 0,
                                shop?.location?.longitude ?? 0,
                              ),
                              title: "Shop"),
                        ],
                      ),
                    ),
                  ),
                  isDarkMode: false);
            },
            child: AnimationButtonEffect(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 14.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Style.unselectedOrderStatus)),
                child: Row(
                  children: [
                    const Icon(FlutterRemix.map_pin_range_line),
                    10.horizontalSpace,
                    Expanded(
                      child: Text(
                        shop?.translation?.address ?? "",
                        style: Style.interNoSemi(size: 14, color: Style.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          16.verticalSpace,
          InkWell(
            onTap: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: shop?.phone ?? "",
              );
              await launchUrl(launchUri);
            },
            child: AnimationButtonEffect(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 14.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Style.unselectedOrderStatus)),
                child: Row(
                  children: [
                    const Icon(FlutterRemix.phone_line),
                    10.horizontalSpace,
                    Expanded(
                      child: Text(
                        shop?.phone ?? "",
                        style: Style.interNoSemi(size: 14, color: Style.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
