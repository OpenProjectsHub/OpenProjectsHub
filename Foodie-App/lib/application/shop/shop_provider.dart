import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';


import 'shop_notifier.dart';
import 'shop_state.dart';



final shopProvider = StateNotifierProvider<ShopNotifier, ShopState>(
  (ref) => ShopNotifier(shopsRepository,productsRepository,categoriesRepository,drawRepository),
);