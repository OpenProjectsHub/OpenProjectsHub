
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/domain/di/dependency_manager.dart';

import 'notification_notifier.dart';
import 'notification_state.dart';



final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>(
  (ref) => NotificationNotifier(notificationRepo)
);
