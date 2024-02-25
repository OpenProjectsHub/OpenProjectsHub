import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/home/home_notifier.dart';
import 'package:shoppingapp/application/home/home_state.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/presentation/theme/app_style.dart';

import 'filter/filter_page.dart';
import 'shimmer/category_shimmer.dart';
import 'widgets/tab_bar_item.dart';

class CategoryScreen extends StatelessWidget {
  final HomeState state;
  final HomeNotifier event;
  final RefreshController categoryController;
  final RefreshController restaurantController;

  const CategoryScreen({
    super.key,
    required this.state,
    required this.event,
    required this.categoryController,
    required this.restaurantController,
  });

  @override
  Widget build(BuildContext context) {
    return state.isCategoryLoading
        ? const CategoryShimmer()
        : Container(
            height: state.categories.isNotEmpty ? 80.h : 0,
            margin:
                EdgeInsets.only(bottom: state.categories.isNotEmpty ? 26.h : 0),
            child: SmartRefresher(
              scrollDirection: Axis.horizontal,
              enablePullDown: false,
              enablePullUp: true,
              primary: false,
              controller: categoryController,
              onLoading: () async {
                await event.fetchCategoriesPage(context, categoryController);
              },
              child: AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      state.isCategoryLoading ? 5 : state.categories.length + 1,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: (index == 0
                              ? GestureDetector(
                                  onTap: () {
                                    AppHelpers.showCustomModalBottomDragSheet(
                                      paddingTop:
                                          MediaQuery.of(context).padding.top +
                                              100.h,
                                      context: context,
                                      modal: (c) => FilterPage(controller: c),
                                      isDarkMode: false,
                                      isDrag: false,
                                      radius: 12,
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 4.r, left: 16.r),
                                    width: 38.w,
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: Style.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/svgs/menu.svg",
                                    ),
                                  ),
                                )
                              : CategoryBarItem(
                                  index: index,
                                  image: state.categories[index - 1].img ?? "",
                                  title: state.categories[index - 1].translation
                                          ?.title ??
                                      "",
                                  isActive:
                                      state.selectIndexCategory == index - 1,
                                  onTap: () {
                                    event.setSelectCategory(index - 1, context);
                                    restaurantController.resetNoData();
                                  },
                                )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
