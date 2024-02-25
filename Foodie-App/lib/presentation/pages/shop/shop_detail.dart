import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/application/shop/shop_provider.dart';
import 'package:shoppingapp/infrastructure/models/data/shop_data.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/pages/order/order_type/widgets/order_map.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import '../../../infrastructure/services/app_constants.dart';
import '../../../infrastructure/services/local_storage.dart';
import '../../components/buttons/pop_button.dart';


@RoutePage()
class ShopDetailPage extends ConsumerStatefulWidget {
  final ShopData shop;
  final String workTime;

  const ShopDetailPage({super.key, required this.shop, required this.workTime});

  @override
  ConsumerState<ShopDetailPage> createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends ConsumerState<ShopDetailPage> {
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shopProvider.notifier)
        ..getMarker()
        ..getRoutingAll(
            context: context,
            start: LatLng(
              widget.shop.location?.latitude ?? AppConstants.demoLatitude,
              widget.shop.location?.longitude ?? AppConstants.demoLongitude,
            ),
            end: LatLng(
              LocalStorage.instance.getAddressSelected()?.location?.latitude ??
                  AppConstants.demoLatitude,
              LocalStorage.instance.getAddressSelected()?.location?.longitude ??
                  AppConstants.demoLongitude,
            ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.instance.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Style.bgGrey,
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 32.r),
          children: [
            OrderMap(
                markers: ref.watch(shopProvider).shopMarkers,
                latLng: LatLng(
                  widget.shop.location?.latitude ?? AppConstants.demoLatitude,
                  widget.shop.location?.longitude ?? AppConstants.demoLongitude,
                ),
                polylineCoordinates:
                    ref.watch(shopProvider).polylineCoordinates,
                isLoading: ref.watch(shopProvider).isMapLoading),
            16.verticalSpace,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: Text(
                "${widget.shop.translation?.title ?? ""}(${widget.shop.translation?.address ?? ""})",
                style: Style.interBold(),
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: SizedBox(
                height: 18.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.shop.tags?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          "${widget.shop.tags?[index].translation?.title ?? ""} • ",
                          style: Style.interNormal(color: Style.textGrey),
                        );
                      },
                    ),
                    Text(
                      LocalStorage.instance.getSelectedCurrency().symbol ?? "",
                      style:
                          Style.interRegular(color: Style.textGrey, size: 14),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Divider(
                color: Style.hintColor,
                thickness: 1.5.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(
                      text: widget.shop.translation?.address ?? ""));
                },
                child: Row(
                  children: [
                    const Icon(Icons.place_rounded),
                    24.horizontalSpace,
                    Expanded(
                        child: Text(widget.shop.translation?.address ?? "")),
                    const Spacer(),
                    const Icon(
                      FlutterRemix.file_copy_fill,
                      color: Style.textGrey,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: const Divider(
                color: Style.hintColor,
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(FlutterRemix.time_fill),
                        24.horizontalSpace,
                        Text(
                            "${AppHelpers.getTranslation(TrKeys.openUntil)} ${widget.workTime}"),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            ref.watch(shopProvider).showWeekTime
                                ? FlutterRemix.subtract_fill
                                : FlutterRemix.add_fill,
                            color: Style.textGrey,
                          ),
                          onPressed: () {
                            ref.read(shopProvider.notifier).showWeekTime();
                          },
                        ),
                      ],
                    ),
                    ref.watch(shopProvider).showWeekTime
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 48.r),
                            itemCount: widget.shop.shopWorkingDays?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.shop.shopWorkingDays?[index].day}"
                                          .toUpperCase(),
                                      style: Style.interNoSemi(size: 14),
                                    ),
                                    2.verticalSpace,
                                    Text(
                                        "${widget.shop.shopWorkingDays?[index].from} - ${widget.shop.shopWorkingDays?[index].to}"),
                                  ],
                                ),
                              );
                            })
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Divider(
                color: Style.hintColor,
                thickness: 1.5.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Row(
                children: [
                  const Icon(FlutterRemix.star_fill),
                  24.horizontalSpace,
                  Text(
                      "${widget.shop.avgRate} (${widget.shop.rateCount}+ ${AppHelpers.getTranslation(TrKeys.ratings)})"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: const PopButton(),
        ),
      ),
    );
  }
}
