import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';


import 'search_notifier.dart';
import 'search_state.dart';



final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(productsRepository),
);
