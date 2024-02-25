import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';

import '../../../../application/home/home_notifier.dart';
import '../../../../application/home/home_provider.dart';
import '../../../../infrastructure/services/app_helpers.dart';
import '../../../components/app_bars/common_app_bar.dart';
import '../../../components/buttons/pop_button.dart';
import '../../../theme/app_style.dart';
import 'recommended_item.dart';

@RoutePage()
class RecommendedPage extends ConsumerStatefulWidget {
  final bool isNewsOfPage;
  final bool isShop;

  const RecommendedPage({
    super.key,
    this.isNewsOfPage = false,
    this.isShop = false,
  });

  @override
  ConsumerState<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends ConsumerState<RecommendedPage> {
  late HomeNotifier event;
  final RefreshController _recommendedController = RefreshController();

  @override
  void didChangeDependencies() {
    event = ref.read(homeProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    return Scaffold(
      body: Column(
        children: [
          CommonAppBar(
            child: Text(
              AppHelpers.getTranslation(TrKeys.recipes),
              style: Style.interNoSemi(size: 18.sp),
            ),
          ),
          Expanded(
              child: state.recipesCategory.isNotEmpty
                  ? SmartRefresher(
                      controller: _recommendedController,
                      enablePullDown: true,
                      enablePullUp: false,
                      primary: false,
                      onLoading: () async {
                        await event.fetchRecipeCategoryPage(
                            context, _recommendedController);
                      },
                      onRefresh: () async {
                        await event.fetchRecipeCategoryPage(
                            context, _recommendedController,
                            isRefresh: true);
                      },
                      child: GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.recipesCategory.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 24.h),
                        itemBuilder: (context, index) => RecommendedItem(
                          recipeCategory: state.recipesCategory[index],
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.66.r,
                            crossAxisCount: 2,
                            mainAxisExtent: 190.h,
                            mainAxisSpacing: 10.h),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: SvgPicture.asset(
                            "assets/svgs/empty.svg",
                          ),
                        ),
                        16.verticalSpace,
                        Text(AppHelpers.getTranslation(TrKeys.noRestaurant))
                      ],
                    ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: const PopButton(),
      ),
    );
  }
}
