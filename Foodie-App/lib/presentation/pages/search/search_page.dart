import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingapp/application/home/home_provider.dart';
import 'package:shoppingapp/application/search/search_state.dart';
import 'package:shoppingapp/infrastructure/services/app_helpers.dart';
import 'package:shoppingapp/infrastructure/services/tpying_delay.dart';
import 'package:shoppingapp/infrastructure/services/tr_keys.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import 'package:shoppingapp/presentation/components/keyboard_dismisser.dart';
import 'package:shoppingapp/presentation/components/tab_bar_item.dart';
import 'package:shoppingapp/presentation/components/text_fields/search_text_field.dart';
import 'package:shoppingapp/presentation/components/title_icon.dart';
import 'package:shoppingapp/presentation/theme/theme.dart';
import '../../../../application/search/search_notifier.dart';
import '../../../../application/search/search_provider.dart';
import 'shimmer/category_shimmer.dart';
import 'shimmer/search_product_shimmer.dart';
import 'widgets/product_item.dart';
import 'widgets/search_result.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late SearchNotifier event;
  late RefreshController _categoryController;
  late RefreshController _categoryControllerTwo;
  late RefreshController _productController;
  late TextEditingController _searchController;
  final _delayed = Delayed(milliseconds: 700);

  @override
  void initState() {
    _categoryController = RefreshController();
    _categoryControllerTwo = RefreshController();
    _productController = RefreshController();

    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchProvider.notifier).init();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(searchProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _productController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Style.bgGrey,
        body: Column(
          children: [
            CommonAppBar(
                isSearchPage: true,
                child: SearchTextField(
                  textEditingController: _searchController,
                  onChanged: (s) {
                    _delayed.run(() {
                      if (s.trim().isNotEmpty) {
                        event
                          ..changeSearch(s)
                          ..searchProduct(context, s,
                              categoryId: state.selectIndexCategory >= 0
                                  ? ref
                                      .watch(homeProvider)
                                      .categories[state.selectIndexCategory]
                                      .id
                                  : null);
                      }
                    });
                  },
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  170.h -
                  ((MediaQuery.of(context).padding.top > 34)
                      ? 34.h
                      : MediaQuery.of(context).padding.top),
              child: state.search.isEmpty
                  ? _categoryAndSearchHistory(state, context)
                  : _searchResultBody(context, state),
            )
          ],
        ),
      ),
    );
  }

  Widget _resultEmpty() {
    return Column(
      children: [
        Lottie.asset("assets/lottie/not-found.json", height: 200.h),
        Text(
          AppHelpers.getTranslation(TrKeys.nothingFound),
          style: Style.interSemi(size: 18.sp),
        ),
      ],
    );
  }

  Widget _searchResultBody(BuildContext context, SearchState state) {
    return SmartRefresher(
      scrollDirection: Axis.vertical,
      enablePullDown: false,
      enablePullUp: true,
      controller: _productController,
      onLoading: () async {
        await event.searchProductPage(context, state.search,
            categoryId: state.selectIndexCategory >= 0
                ? ref
                    .watch(homeProvider)
                    .categories[state.selectIndexCategory]
                    .id
                : null);
        _productController.loadComplete();
      },
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          16.verticalSpace,
          ref.watch(homeProvider).isCategoryLoading
              ? const SearchCategoryShimmer()
              : ref.watch(homeProvider).categories.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 36.h,
                          child: SmartRefresher(
                            scrollDirection: Axis.horizontal,
                            enablePullDown: false,
                            primary: false,
                            enablePullUp: true,
                            controller: _categoryController,
                            onLoading: () async {
                              await ref
                                  .read(homeProvider.notifier)
                                  .fetchCategoriesPage(
                                      context, _categoryController);
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    ref.watch(homeProvider).categories.length,
                                padding: EdgeInsets.only(left: 16.w),
                                itemBuilder: (context, index) {
                                  return TabBarItem(
                                    isShopTabBar: true,
                                    title: ref
                                            .watch(homeProvider)
                                            .categories[index]
                                            .translation
                                            ?.title ??
                                        "",
                                    currentIndex: state.selectIndexCategory,
                                    index: index,
                                    onTap: () => event.setSelectCategory(
                                        index, context,
                                        categoryId: ref
                                            .watch(homeProvider)
                                            .categories[index]
                                            .id),
                                  );
                                }),
                          ),
                        ),
                        30.verticalSpace,
                      ],
                    )
                  : const SizedBox.shrink(),
          22.verticalSpace,
          state.isProductLoading
              ? const SearchProductShimmer()
              : Column(
                  children: [
                    TitleAndIcon(
                        title: AppHelpers.getTranslation(TrKeys.products),
                        rightTitle:
                            "${AppHelpers.getTranslation(TrKeys.found)} ${state.products.length} ${AppHelpers.getTranslation(TrKeys.results)}"),
                    20.verticalSpace,
                    state.products.isNotEmpty
                        ? AnimationLimiter(
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                    right: 16.w,
                                    left: 16.w,
                                    bottom:
                                        MediaQuery.of(context).padding.bottom),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: ProductItem(
                                            product: state.products[index]),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : _resultEmpty()
                  ],
                ),
        ],
      ),
    );
  }

  Widget _categoryAndSearchHistory(SearchState state, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 100.h),
      children: [
        16.verticalSpace,
        ref.watch(homeProvider).isCategoryLoading
            ? const SearchCategoryShimmer()
            : ref.watch(homeProvider).categories.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 36.h,
                        child: SmartRefresher(
                          scrollDirection: Axis.horizontal,
                          enablePullDown: false,
                          primary: false,
                          enablePullUp: true,
                          controller: _categoryControllerTwo,
                          onLoading: () async {
                            await ref
                                .read(homeProvider.notifier)
                                .fetchCategoriesPage(
                                    context, _categoryControllerTwo);
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    ref.watch(homeProvider).categories.length,
                                padding: EdgeInsets.only(left: 16.w),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: TabBarItem(
                                          isShopTabBar: true,
                                          title: ref
                                                  .watch(homeProvider)
                                                  .categories[index]
                                                  .translation
                                                  ?.title ??
                                              "",
                                          index: index,
                                          currentIndex:
                                              state.selectIndexCategory,
                                          onTap: () => event.setSelectCategory(
                                              index, context,
                                              categoryId: ref
                                                  .watch(homeProvider)
                                                  .categories[index]
                                                  .id),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                    ],
                  )
                : const SizedBox.shrink(),
        TitleAndIcon(
          title: "Recently",
          rightTitle: "Clear",
          rightTitleColor: Style.red,
          onRightTap: () {
            event.clearAllHistory();
          },
        ),
        30.verticalSpace,
        AnimationLimiter(
          child: ListView.builder(
              padding: EdgeInsets.only(
                  right: 16.w,
                  left: 16.w,
                  bottom: MediaQuery.of(context).padding.bottom),
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.searchHistory.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: SearchResultText(
                        title: state.searchHistory[index],
                        canceled: () {
                          event.clearHistory(index);
                        },
                        onTap: () {
                          _searchController.text = state.searchHistory[index];
                          event
                            ..changeSearch(state.searchHistory[index])
                            ..searchProduct(context, state.searchHistory[index],
                                categoryId: state.selectIndexCategory >= 0
                                    ? ref
                                        .watch(homeProvider)
                                        .categories[state.selectIndexCategory]
                                        .id
                                    : null);
                        },
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
