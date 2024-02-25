import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/application/order/order_provider.dart';
import 'package:shoppingapp/application/order/order_state.dart';
import 'package:shoppingapp/application/order_time/time_state.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/custom_tab_bar.dart';
import 'package:shoppingapp/presentation/components/select_item.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';

import '../../../../../../application/order_time/time_notifier.dart';
import '../../../../../../application/order_time/time_provider.dart';

class TimeDelivery extends ConsumerStatefulWidget {
  const TimeDelivery({super.key});

  @override
  ConsumerState<TimeDelivery> createState() => _TimeDeliveryState();
}

class _TimeDeliveryState extends ConsumerState<TimeDelivery>
    with TickerProviderStateMixin {
  late TimeNotifier event;
  late TimeState state;
  late OrderState stateOrder;
  late TabController _tabController;
  final _tabs = [
    Tab(text: AppHelpers.getTranslation(TrKeys.today)),
    Tab(text: AppHelpers.getTranslation(TrKeys.tomorrow)),
  ];

  Iterable list = [];

  List<String> listOfTime = [];
  List<String> listOfTimeTomorrow = [];

  getTimeList() {
    TimeOfDay time =
        (ref.read(orderProvider).startTodayTime.hour > TimeOfDay.now().hour
            ? ref.read(orderProvider).startTodayTime
            : TimeOfDay.now());

    if (time.hour == 0 && ref.read(orderProvider).endTodayTime.hour == 0) {
      while (time.hour <=
          (ref.read(orderProvider).endTodayTime.hour == 0
              ? 24
              : ref.read(orderProvider).endTodayTime.hour - 1)) {
        listOfTime.add(
            "${time.hour}:${time.minute.toString().padLeft(2, '0')} - ${time.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour}:${time.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute > 30 ? time.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute : "00"}");
        time = time.addHour(1);
        if (time.hour == 0) {
          break;
        }
      }
    } else {
      final deliveryTime = (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0);
      while (time.hour <= (ref.read(orderProvider).endTodayTime.hour == 0
              ? 24
              : ref.read(orderProvider).endTodayTime.hour - 1)) {
        final hour = (time.minute + deliveryTime) ~/ 60;
        final minute = (time.minute + deliveryTime) % 60;
        final nextTime = TimeOfDay(hour: hour + time.hour, minute: minute);

        listOfTime.add(
            "${time.hour}:${time.minute.toString().padLeft(2, '0')} - ${nextTime.hour}:${nextTime.minute < 10 ? '0' : ""}${nextTime.minute}");
        time = time.addHour(1);
        if (time.hour == 0) {
          break;
        }
      }
    }

    TimeOfDay timeTomorrow = ref.read(orderProvider).startTomorrowTime;
    if (timeTomorrow.hour == 0 &&
        ref.read(orderProvider).endTomorrowTime.hour == 0) {
      while (timeTomorrow.hour <=
          (ref.read(orderProvider).endTomorrowTime.hour == 0
              ? 24
              : ref.read(orderProvider).endTomorrowTime.hour - 1)) {
        listOfTimeTomorrow.add(
            "${timeTomorrow.hour}:${timeTomorrow.minute.toString().padLeft(2, '0')} - ${timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24 ? "00" : timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24}:${timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute.toString().padLeft(2, "0")}");
        timeTomorrow = timeTomorrow.addHour(1);
        if (timeTomorrow.hour == 0) {
          break;
        }
      }
    } else {
      while (timeTomorrow.hour <=
          (ref.read(orderProvider).endTomorrowTime.hour == 0
              ? 24
              : ref.read(orderProvider).endTomorrowTime.hour - 1)) {
        listOfTimeTomorrow.add(
            "${timeTomorrow.hour}:${timeTomorrow.minute.toString().padLeft(2, '0')} - ${timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24 ? "00" : timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour + 1}:${timeTomorrow.replacing(minute: time.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute.toString().padLeft(2, "0")}");
        timeTomorrow = timeTomorrow.addHour(1);
        if (timeTomorrow.hour == 0) {
          break;
        }
      }
    }

    if (listOfTime.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(timeProvider.notifier).changeOne(1);
        _tabController.animateTo(1);
      });
    }
  }

  List<String> getSingleDayTime(
      String? startTimeString, String? endTimeString) {
    TimeOfDay startTime = TimeOfDay(
      hour: int.tryParse(
              startTimeString?.substring(0, startTimeString.indexOf("-")) ??
                  "") ??
          0,
      minute: int.tryParse(
              startTimeString?.substring((startTimeString.indexOf("-")) + 1) ??
                  "") ??
          0,
    );
    TimeOfDay endTime = TimeOfDay(
      hour: int.tryParse(
              endTimeString?.substring(0, endTimeString.indexOf("-")) ?? "") ??
          0,
      minute: int.tryParse(
              endTimeString?.substring((endTimeString.indexOf("-")) + 1) ??
                  "") ??
          0,
    );
    List<String> listOfTime = [];
    if (startTime.hour == 0 && endTime.hour == 0) {
      while (startTime.hour <= (endTime.hour == 0 ? 24 : endTime.hour - 1)) {
        listOfTime.add(
            "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')} - ${startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24 ? "00" : startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24}:${startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute.toString().padLeft(2, "0")}");
        startTime = startTime.addHour(1);
        if (startTime.hour == 0) {
          break;
        }
      }
    } else {
      while (startTime.hour <= (endTime.hour == 0 ? 24 : endTime.hour - 1)) {
        listOfTime.add(
            "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')} - ${startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour == 24 ? "00" : startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).hour + 1}:${startTime.replacing(minute: startTime.minute + (int.tryParse(ref.read(orderProvider).shopData?.deliveryTime?.to ?? "40") ?? 0)).minute.toString().padLeft(2, "0")}");
        startTime = startTime.addHour(1);
        if (startTime.hour == 0) {
          break;
        }
      }
    }
    return listOfTime;
  }

  isCheckCloseDay(String? dateFormat) {
    DateTime date = DateFormat("EEEE, MMM dd").parse(dateFormat ?? "");
    return ref
        .read(orderProvider)
        .shopData
        ?.shopClosedDate
        ?.map((e) => e.day!.day)
        .contains(date.day);
  }

  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      _tabs.add(
        Tab(
          text: AppHelpers.getTranslation(
            DateFormat("EEEE, MMM dd").format(
              DateTime.now().add(
                Duration(days: i + 2),
              ),
            ),
          ),
        ),
      );
    }
    _tabController = TabController(
        length: 7,
        vsync: this,
        initialIndex: ref.read(orderProvider).isTodayWorkingDay ? 0 : 1);
    list = [
      "${AppHelpers.getTranslation(TrKeys.today)} — ${ref.read(orderProvider).shopData?.deliveryTime?.to ?? 40} ${AppHelpers.getTranslation(TrKeys.min)}",
      AppHelpers.getTranslation(TrKeys.other)
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timeProvider.notifier).reset();
    });
    getTimeList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(timeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stateOrder = ref.watch(orderProvider);
    state = ref.watch(timeProvider);
    return Container(
      decoration: BoxDecoration(
          color: Style.bgGrey.withOpacity(0.96),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          )),
      width: double.infinity,
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
                    Radius.circular(40.r),
                  ),
                ),
              ),
            ),
            14.verticalSpace,
            TitleAndIcon(
              title: state.currentIndexOne == 0
                  ? AppHelpers.getTranslation(TrKeys.deliveryTime)
                  : AppHelpers.getTranslation(TrKeys.timeSchedule),
              paddingHorizontalSize: 0,
              rightTitle: state.currentIndexOne == 0
                  ? ""
                  : AppHelpers.getTranslation(TrKeys.clear),
              rightTitleColor: Style.red,
              onRightTap: state.currentIndexOne == 0
                  ? () {}
                  : () {
                      event.changeOne(0);
                    },
            ),
            24.verticalSpace,
            state.currentIndexOne == 0 &&
                    ref.watch(orderProvider).isTodayWorkingDay
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return SelectItem(
                        onTap: () {
                          event.changeOne(index);
                        },
                        isActive: state.currentIndexOne == index,
                        title: list.elementAt(index),
                      );
                    })
                : Expanded(
                    child: Column(
                      children: [
                        CustomTabBar(
                          isScrollable: true,
                          tabController: _tabController,
                          tabs: _tabs,
                        ),
                        Expanded(
                          child:
                              TabBarView(controller: _tabController, children: [
                            stateOrder.isTodayWorkingDay
                                ? listOfTime.isNotEmpty
                                    ? ListView.builder(
                                        padding: EdgeInsets.only(
                                            top: 24.h, bottom: 16.h),
                                        itemCount: listOfTime.length,
                                        itemBuilder: (context, index) {
                                          return SelectItem(
                                            onTap: () {
                                              event.selectIndex(index);
                                              ref.read(orderProvider.notifier).setTimeAndDay(
                                                  TimeOfDay(
                                                      hour: int.tryParse(listOfTime[
                                                                  index]
                                                              .substring(
                                                                  0,
                                                                  listOfTime[
                                                                          index]
                                                                      .indexOf(
                                                                          ":"))) ??
                                                          0,
                                                      minute: 0),
                                                  DateTime.now());
                                            },
                                            isActive:
                                                state.selectIndex == index,
                                            title: listOfTime.elementAt(index),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 32.r, vertical: 48.r),
                                        child: Text(
                                          AppHelpers.getTranslation(
                                              TrKeys.notWorkTodayTime),
                                          style: Style.interNormal(size: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32.r, vertical: 48.r),
                                    child: Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.notWorkToday),
                                      style: Style.interNormal(size: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            stateOrder.isTomorrowWorkingDay
                                ? ListView.builder(
                                    padding: EdgeInsets.only(
                                        top: 24.h, bottom: 16.h),
                                    itemCount: listOfTimeTomorrow.length,
                                    itemBuilder: (context, index) {
                                      return SelectItem(
                                        onTap: () {
                                          event.selectIndex(index);
                                          ref.read(orderProvider.notifier).setTimeAndDay(
                                              TimeOfDay(
                                                  hour: int.tryParse(
                                                          listOfTimeTomorrow[
                                                                  index]
                                                              .substring(
                                                                  0,
                                                                  listOfTimeTomorrow[
                                                                          index]
                                                                      .indexOf(
                                                                          ":"))) ??
                                                      0,
                                                  minute: 0),
                                              DateTime.now().add(
                                                  const Duration(days: 1)));
                                        },
                                        isActive: state.selectIndex == index,
                                        title:
                                            listOfTimeTomorrow.elementAt(index),
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32.r, vertical: 48.r),
                                    child: Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.notWorkTomorrow),
                                      style: Style.interNormal(size: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            ...List.generate(5, (indexTab) {
                              for (int i = 0;
                                  (i <
                                      (stateOrder.shopData?.shopWorkingDays
                                              ?.length ??
                                          0));
                                  i++) {
                                if (stateOrder.shopData?.shopWorkingDays?[i].day
                                            ?.toLowerCase() ==
                                        _tabs[indexTab + 2]
                                            .text
                                            ?.toLowerCase()
                                            .substring(
                                              0,
                                              _tabs[indexTab + 2]
                                                  .text!
                                                  .toLowerCase()
                                                  .indexOf(","),
                                            ) &&
                                    !(stateOrder.shopData?.shopWorkingDays?[i]
                                            .disabled ??
                                        false) &&
                                    !isCheckCloseDay(
                                        _tabs[indexTab + 2].text)) {
                                  return ListView.builder(
                                    padding: EdgeInsets.only(
                                        top: 24.h, bottom: 16.h),
                                    itemCount: getSingleDayTime(
                                            stateOrder.shopData
                                                ?.shopWorkingDays?[i].from,
                                            stateOrder.shopData
                                                ?.shopWorkingDays?[i].to)
                                        .length,
                                    itemBuilder: (context, index) {
                                      return SelectItem(
                                        onTap: () {
                                          event.selectIndex(index);
                                          ref.read(orderProvider.notifier).setTimeAndDay(
                                              TimeOfDay(
                                                  hour: int.tryParse(getSingleDayTime(
                                                              stateOrder
                                                                  .shopData
                                                                  ?.shopWorkingDays?[
                                                                      i]
                                                                  .from,
                                                              stateOrder
                                                                  .shopData
                                                                  ?.shopWorkingDays?[
                                                                      i]
                                                                  .to)[index]
                                                          .substring(
                                                              0,
                                                              getSingleDayTime(
                                                                      stateOrder
                                                                          .shopData
                                                                          ?.shopWorkingDays?[i]
                                                                          .from,
                                                                      stateOrder.shopData?.shopWorkingDays?[i].to)[index]
                                                                  .indexOf(":"))) ??
                                                      0,
                                                  minute: 0),
                                              DateFormat("EEEE, MMM dd").parse(_tabs[indexTab + 2].text ?? ""));
                                        },
                                        isActive: state.selectIndex == index,
                                        title: getSingleDayTime(
                                                stateOrder.shopData
                                                    ?.shopWorkingDays?[i].from,
                                                stateOrder.shopData
                                                    ?.shopWorkingDays?[i].to)
                                            .elementAt(index),
                                      );
                                    },
                                  );
                                }
                              }
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32.r, vertical: 48.r),
                                child: Text(
                                  "${AppHelpers.getTranslation(TrKeys.notWork)} ${_tabs[indexTab + 2].text}",
                                  style: Style.interNormal(size: 20),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }),
                          ]),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
