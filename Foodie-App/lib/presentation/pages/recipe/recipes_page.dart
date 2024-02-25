import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppingapp/application/recipe/recipes_provider.dart';
import 'package:shoppingapp/presentation/components/app_bars/common_app_bar.dart';
import '../../components/buttons/pop_button.dart';
import '../../theme/app_style.dart';
import 'grid_recipes_body.dart';

@RoutePage()
class ShopRecipesPage extends ConsumerStatefulWidget {
  final int? categoryId;
  final String? categoryTitle;

  const ShopRecipesPage({
    super.key,
    this.categoryId,
    this.categoryTitle,
  });

  @override
  ConsumerState<ShopRecipesPage> createState() => _ShopRecipesPageState();
}

class _ShopRecipesPageState extends ConsumerState<ShopRecipesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref
            .read(recipesProvider.notifier)
            .fetchRecipe(context, widget.categoryId ?? 0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.bgGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppBar(
            child: Text(
              widget.categoryTitle ?? "",
              style: Style.interNoSemi(
                size: 18,
                color: Style.black,
              ),
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final recipesState = ref.watch(recipesProvider);
                return GridRecipesBody(
                  isLoading: recipesState.isLoading,
                  recipes: recipesState.recipes,
                  bottomPadding: 24,
                );
              },
            ),
          ),
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
