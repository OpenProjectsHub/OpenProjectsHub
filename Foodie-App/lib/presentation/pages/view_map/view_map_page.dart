// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppingapp/application/app_widget/app_provider.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';
import 'package:shoppingapp/infrastructure/models/data/address_information.dart';
import 'package:shoppingapp/infrastructure/models/models.dart';
import 'package:shoppingapp/infrastructure/services/app_constants.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/local_storage.dart';
import 'package:shoppingapp/infrastructure/services/tpying_delay.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/buttons/animation_button_effect.dart';
import 'package:shoppingapp/presentation/components/buttons/custom_button.dart';
import 'package:shoppingapp/presentation/components/buttons/pop_button.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/components/loading.dart';
import 'package:shoppingapp/presentation/components/text_fields/outline_bordered_text_field.dart';
import 'package:shoppingapp/presentation/components/text_fields/search_text_field.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/routes/app_router.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../application/map/view_map_notifier.dart';
import '../../../../application/map/view_map_provider.dart';
import 'shop_item_in_map.dart';

@RoutePage()
class ViewMapPage extends ConsumerStatefulWidget {
  final bool isShopLocation;
  final int? shopId;

  const ViewMapPage({
    super.key,
    this.isShopLocation = false,
    this.shopId,
  });

  @override
  ConsumerState<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends ConsumerState<ViewMapPage> {
  late ViewMapNotifier event;
  late TextEditingController controller;
  late TextEditingController office;
  late TextEditingController house;
  late TextEditingController floor;
  late CarouselController carouselController;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  GoogleMapController? googleMapController;

  CameraPosition? cameraPosition;
  dynamic check;
  late LatLng latLng;

  @override
  void initState() {
    controller = TextEditingController();
    office = TextEditingController();
    house = TextEditingController();
    floor = TextEditingController();
    carouselController = CarouselController();
    latLng = LatLng(
      LocalStorage.instance.getAddressSelected()?.location?.latitude ??
          (AppHelpers.getInitialLatitude() ?? AppConstants.demoLatitude),
      LocalStorage.instance.getAddressSelected()?.location?.longitude ??
          (AppHelpers.getInitialLongitude() ?? AppConstants.demoLongitude),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(viewMapProvider.notifier).fetchBranches(context);
      ref
          .read(homeProvider.notifier)
          .fetchBranchesFilter(context, TrKeys.allShops, null);
    });
    checkPermission();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(viewMapProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    office.dispose();
    house.dispose();
    floor.dispose();
    super.dispose();
  }

  List<String> listOfFilter = [
    TrKeys.filter,
    TrKeys.allShops,
    TrKeys.nearYou,
    TrKeys.work247,
    TrKeys.newShops,
  ];

  checkPermission() async {
    check = await _geolocatorPlatform.checkPermission();
  }

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
      if (check != LocationPermission.denied &&
          check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!
            .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!
            .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    }
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    if (markers.isEmpty) {
      return LatLngBounds(
          southwest: const LatLng(0, 0), northeast: const LatLng(0, 0));
    }
    return _createBounds(markers.map((m) => m.position).toList());
  }

  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northeastLon = positions
        .map((p) => p.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final eventHome = ref.watch(homeProvider.notifier);
    final stateMap = ref.watch(viewMapProvider);
    final bool isLtr = LocalStorage.instance.getLangLtr();
    final bool isDarkMode = ref.watch(appProvider).isDarkMode;
    return KeyboardDismisser(
      child: Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: isDarkMode ? Style.mainBackDark : Style.mainBack,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SlidingUpPanel(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  minHeight: 100.h,
                  maxHeight: 400.h,
                  defaultPanelState: PanelState.OPEN,
                  color: isDarkMode ? Style.dontHaveAnAccBackDark : Style.white,
                  body: Padding(
                    padding: REdgeInsets.only(bottom: 0),
                    child: Stack(
                      children: [
                        GoogleMap(
                          padding: REdgeInsets.only(bottom: 100.h),
                          markers: state.shopMarkers,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            bearing: 0,
                            target: latLng,
                            tilt: 0,
                            zoom: 17,
                          ),
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: true,
                          onTap: (position) {
                            event.updateActive();
                            Delayed(milliseconds: 700).run(() async {
                              try {
                                final List<Placemark> placemarks = await placemarkFromCoordinates(
                                  cameraPosition?.target.latitude ??
                                      latLng.latitude,
                                  cameraPosition
                                      ?.target.longitude ??
                                      latLng.longitude,
                                );

                                if (placemarks.isNotEmpty) {
                                  final Placemark pos = placemarks[0];
                                  final List<String> addressData = [];
                                  addressData.add(pos.locality!);
                                  if (pos.subLocality != null && pos.subLocality!.isNotEmpty) {
                                    addressData.add(pos.subLocality!);
                                  }
                                  if (pos.thoroughfare != null && pos.thoroughfare!.isNotEmpty) {
                                    addressData.add(pos.thoroughfare!);
                                  }
                                  addressData.add(pos.name!);
                                  final String placeName = addressData.join(', ');
                                  controller.text = placeName;
                                }
                              } catch (e) {
                                controller.text = '';
                              }
                              event
                                ..checkDriverZone(
                                    context: context,
                                    location: LatLng(
                                      cameraPosition?.target.latitude ??
                                          latLng.latitude,
                                      cameraPosition?.target.longitude ??
                                          latLng.longitude,
                                    ),
                                    shopId: widget.shopId)
                                ..changePlace(
                                  AddressData(
                                    title: controller.text,
                                    address: controller.text,
                                    location: LocationModel(
                                      latitude:
                                          cameraPosition?.target.latitude ??
                                              latLng.latitude,
                                      longitude:
                                          cameraPosition?.target.longitude ??
                                              latLng.longitude,
                                    ),
                                  ),
                                );
                              if (state.shopFilter == TrKeys.nearYou) {
                                eventHome.fetchBranchesFilter(context,
                                    TrKeys.nearYou, cameraPosition?.target);
                              }
                            });
                            googleMapController!.animateCamera(
                                CameraUpdate.newLatLngZoom(position, 15));
                          },
                          onCameraIdle: () {
                            event.updateActive();
                            Delayed(milliseconds: 700).run(() async {
                              try {
                                final List<Placemark> placemarks = await placemarkFromCoordinates(
                                  cameraPosition?.target.latitude ??
                                      latLng.latitude,
                                  cameraPosition
                                      ?.target.longitude ??
                                      latLng.longitude,
                                );

                                if (placemarks.isNotEmpty) {
                                  final Placemark pos = placemarks[0];
                                  final List<String> addressData = [];
                                  addressData.add(pos.locality!);
                                  if (pos.subLocality != null && pos.subLocality!.isNotEmpty) {
                                    addressData.add(pos.subLocality!);
                                  }
                                  if (pos.thoroughfare != null && pos.thoroughfare!.isNotEmpty) {
                                    addressData.add(pos.thoroughfare!);
                                  }
                                  addressData.add(pos.name!);
                                  final String placeName = addressData.join(', ');
                                  controller.text = placeName;
                                }
                              } catch (e) {
                                controller.text = '';
                              }
                              if (!widget.isShopLocation) {
                                event
                                  ..checkDriverZone(
                                      context: context,
                                      location: LatLng(
                                        cameraPosition?.target.latitude ??
                                            latLng.latitude,
                                        cameraPosition?.target.longitude ??
                                            latLng.longitude,
                                      ),
                                      shopId: widget.shopId)
                                  ..changePlace(
                                    AddressData(
                                      title:  controller.text,
                                      address:  controller.text,
                                      location: LocationModel(
                                        latitude:
                                            cameraPosition?.target.latitude ??
                                                latLng.latitude,
                                        longitude:
                                            cameraPosition?.target.longitude ??
                                                latLng.longitude,
                                      ),
                                    ),
                                  );
                              } else {
                                event.changePlace(
                                  AddressData(
                                    title:  controller.text,
                                    address:  controller.text,
                                    location: LocationModel(
                                      latitude:
                                          cameraPosition?.target.latitude ??
                                              latLng.latitude,
                                      longitude:
                                          cameraPosition?.target.longitude ??
                                              latLng.longitude,
                                    ),
                                  ),
                                );
                              }
                            });
                            if (state.shopFilter == TrKeys.nearYou) {
                              eventHome.fetchBranchesFilter(context,
                                  TrKeys.nearYou, cameraPosition?.target);
                            }
                          },
                          onCameraMove: (position) {
                            cameraPosition = position;
                          },
                          onMapCreated: (controller) {
                            controller.animateCamera(
                                CameraUpdate.newLatLngBounds(
                                    _bounds(state.shopMarkers), 50));
                            googleMapController = controller;
                          },
                        ),
                        SafeArea(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 32.w,
                            padding: EdgeInsets.all(4.r),
                            margin: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                                color: Style.white,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: SearchTextField(
                              isRead: true,
                              isBorder: true,
                              textEditingController: controller,
                              onTap: () async {
                                final placeId =
                                await context.pushRoute(const MapSearchRoute());
                                if (placeId != null) {
                                  final res = await googlePlace.details
                                      .get(placeId.toString());
                                  try {
                                    final List<Placemark> placemarks = await placemarkFromCoordinates(
                                      res?.result?.geometry?.location?.lat ??
                                          latLng.latitude,
                                      res?.result?.geometry?.location?.lng ??
                                          latLng.longitude,
                                    );

                                    if (placemarks.isNotEmpty) {
                                      final Placemark pos = placemarks[0];
                                      final List<String> addressData = [];
                                      addressData.add(pos.locality!);
                                      if (pos.subLocality != null && pos.subLocality!.isNotEmpty) {
                                        addressData.add(pos.subLocality!);
                                      }
                                      if (pos.thoroughfare != null && pos.thoroughfare!.isNotEmpty) {
                                        addressData.add(pos.thoroughfare!);
                                      }
                                      addressData.add(pos.name!);
                                      final String placeName = addressData.join(', ');
                                      controller.text = placeName;
                                    }
                                  } catch (e) {
                                    controller.text = '';
                                  }

                                  googleMapController!.animateCamera(
                                      CameraUpdate.newLatLngZoom(
                                          LatLng(
                                              res?.result?.geometry?.location?.lat ??
                                                  latLng.latitude,
                                              res?.result?.geometry?.location?.lng ??
                                                  latLng.longitude),
                                          15));
                                  event.changePlace(
                                    AddressData(
                                      title:  controller.text,
                                      address:  controller.text,
                                      location: LocationModel(
                                        latitude:   res?.result?.geometry?.location?.lat ??
                                            latLng.latitude,
                                        longitude: res?.result?.geometry?.location?.lng ??
                                            latLng.longitude,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 110.r),
                            child: Image.asset(
                              "assets/images/marker.png",
                              width: 46.w,
                              height: 46.h,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 120.h,
                          right: 16.w,
                          child: InkWell(
                            onTap: () async {
                              await getMyLocation();
                            },
                            child: Container(
                              width: 50.r,
                              height: 50.r,
                              decoration: BoxDecoration(
                                  color: Style.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Style.shimmerBase,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2))
                                  ]),
                              child: const Center(
                                  child: Icon(FlutterRemix.navigation_line)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  panel: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      8.verticalSpace,
                      Container(
                        width: 49.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          color: Style.dragElement,
                        ),
                      ),
                      14.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleAndIcon(
                            title: AppHelpers.getTranslation(
                                TrKeys.enterADeliveryAddress),
                          ),
                          10.verticalSpace,
                          SizedBox(
                            height: 40.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: listOfFilter.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (index != 0) {
                                        if (state.shopFilter !=
                                            listOfFilter[index]) {
                                          eventHome.changeFilter(
                                              listOfFilter[index]);
                                          eventHome.fetchBranchesFilter(
                                              context,
                                              listOfFilter[index],
                                              cameraPosition?.target);
                                        }
                                      }
                                    },
                                    child: AnimationButtonEffect(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 6.r),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                            color: state.shopFilter ==
                                                    listOfFilter[index]
                                                ? Style.brandGreen
                                                : Style.iconButtonBack),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.r),
                                        child: index != 0
                                            ? Center(
                                                child: Text(
                                                    AppHelpers.getTranslation(
                                                        listOfFilter[index])),
                                              )
                                            : Row(
                                                children: [
                                                  Icon(
                                                    FlutterRemix
                                                        .sound_module_line,
                                                    size: 18.r,
                                                  ),
                                                  6.horizontalSpace,
                                                  Text(
                                                      AppHelpers.getTranslation(
                                                          listOfFilter[index]))
                                                ],
                                              ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      state.isBranchesLoading
                          ? SizedBox(height: 188.h, child: const Loading())
                          : state.branches?.isNotEmpty ?? false
                              ? SizedBox(
                                  height: 188.h,
                                  child: CarouselSlider.builder(
                                    options: CarouselOptions(
                                        enableInfiniteScroll: true,
                                        enlargeCenterPage: false,
                                        disableCenter: false,
                                        padEnds: false,
                                        viewportFraction: 0.52,
                                        initialPage: 0,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, s) {
                                          if (state.shopFilter !=
                                              TrKeys.nearYou) {
                                            googleMapController?.animateCamera(
                                                CameraUpdate.newLatLngZoom(
                                                    LatLng(
                                                        (state
                                                                    .branches?[
                                                                        index]
                                                                    .location
                                                                    ?.latitude ??
                                                                AppConstants
                                                                    .demoLatitude) -
                                                            0.0002,
                                                        state
                                                                .branches?[
                                                                    index]
                                                                .location
                                                                ?.longitude ??
                                                            AppConstants
                                                                .demoLongitude),
                                                    15));
                                          }
                                        },
                                    ),
                                    carouselController: carouselController,
                                    itemCount: state.branches?.length ?? 0,
                                    itemBuilder: (BuildContext context, int index, int realIndex) {
                                      return AnimationButtonEffect(
                                        child: ShopItemInMap(
                                          onTap: (){
                                            context.popRoute();
                                            eventHome.setBranchId(context,
                                                shopId: state.branches?[index].id);
                                          },
                                          shop: state.branches?[index] ??
                                              ShopData(),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: 188.h,
                                  child: Center(
                                    child: Text(AppHelpers.getTranslation(
                                        TrKeys.noRestaurant)),
                                  ),
                                ),
                      14.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const PopButton(),
                            24.horizontalSpace,
                            Expanded(
                              child: CustomButton(
                                isLoading: !widget.isShopLocation
                                    ? stateMap.isLoading
                                    : false,
                                background: !widget.isShopLocation
                                    ? (stateMap.isActive
                                        ? Style.brandGreen
                                        : Style.bgGrey)
                                    : Style.brandGreen,
                                textColor: !widget.isShopLocation
                                    ? (stateMap.isActive
                                        ? Style.black
                                        : Style.textGrey)
                                    : Style.black,
                                title: !widget.isShopLocation
                                    ? (stateMap.isActive
                                        ? AppHelpers.getTranslation(
                                            TrKeys.apply)
                                        : AppHelpers.getTranslation(
                                            TrKeys.noDriverZone))
                                    : AppHelpers.getTranslation(TrKeys.apply),
                                onPressed: () {
                                  if (widget.isShopLocation) {
                                    Navigator.pop(context, stateMap.place);
                                  } else {
                                    if (stateMap.isActive) {
                                      eventHome
                                        ..fetchBanner(context)
                                        ..fetchStore(context)
                                        ..fetchCategories(context);
                                      LocalStorage.instance.setAddressSelected(
                                          stateMap.place ?? AddressData());
                                      eventHome
                                          .setAddress();
                                      AppHelpers.showAlertDialog(
                                          context: context,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TitleAndIcon(
                                                  title: AppHelpers
                                                      .getTranslation(TrKeys
                                                          .addAddressInformation),
                                                  paddingHorizontalSize: 0,
                                                ),
                                                24.verticalSpace,
                                                OutlinedBorderTextField(
                                                  textController: office,
                                                  label:
                                                      AppHelpers.getTranslation(
                                                              TrKeys.office)
                                                          .toUpperCase(),
                                                ),
                                                24.verticalSpace,
                                                OutlinedBorderTextField(
                                                  textController: house,
                                                  label:
                                                      AppHelpers.getTranslation(
                                                              TrKeys.house)
                                                          .toUpperCase(),
                                                ),
                                                24.verticalSpace,
                                                OutlinedBorderTextField(
                                                  textController: floor,
                                                  label:
                                                      AppHelpers.getTranslation(
                                                              TrKeys.floor)
                                                          .toUpperCase(),
                                                ),
                                                32.verticalSpace,
                                                CustomButton(
                                                    title: AppHelpers
                                                        .getTranslation(
                                                            TrKeys.save),
                                                    onPressed: () {
                                                      AddressInformation data =
                                                          AddressInformation(
                                                              house: house.text,
                                                              office:
                                                                  office.text,
                                                              floor:
                                                                  floor.text);
                                                      LocalStorage.instance
                                                          .setAddressInformation(
                                                              data);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context,true);
                                                    }),
                                                16.verticalSpace,
                                                CustomButton(
                                                    borderColor: Style.black,
                                                    textColor: Style.black,
                                                    background:
                                                        Style.transparent,
                                                    title: AppHelpers
                                                        .getTranslation(
                                                            TrKeys.skip),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context,true);
                                                    }),
                                              ],
                                            ),
                                          ));
                                    } else {
                                      AppHelpers.showCheckTopSnackBarInfo(
                                        context,
                                        AppHelpers.getTranslation(
                                            TrKeys.noDriverZone),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
