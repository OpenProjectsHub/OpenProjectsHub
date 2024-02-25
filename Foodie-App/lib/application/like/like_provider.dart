import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';
import 'like_notifier.dart';
import 'like_state.dart';



final likeProvider = StateNotifierProvider<LikeNotifier, LikeState>(
  (ref) => LikeNotifier(productsRepository),
);
