import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

enum GestureType {
  onTapDown,
  onTapUp,
  onTap,
  onTapCancel,
  onSecondaryTapDown,
  onSecondaryTapUp,
  onSecondaryTapCancel,
  onDoubleTap,
  onLongPress,
  onLongPressStart,
  onLongPressMoveUpdate,
  onLongPressUp,
  onLongPressEnd,
  onVerticalDragDown,
  onVerticalDragStart,
  onVerticalDragUpdate,
  onVerticalDragEnd,
  onVerticalDragCancel,
  onHorizontalDragDown,
  onHorizontalDragStart,
  onHorizontalDragUpdate,
  onHorizontalDragEnd,
  onHorizontalDragCancel,
  onForcePressStart,
  onForcePressPeak,
  onForcePressUpdate,
  onForcePressEnd,
  onPanDown,
  onPanStart,
  onPanUpdateAnyDirection,
  onPanUpdateDownDirection,
  onPanUpdateUpDirection,
  onPanUpdateLeftDirection,
  onPanUpdateRightDirection,
  onPanEnd,
  onPanCancel,
  onScaleStart,
  onScaleUpdate,
  onScaleEnd,
}

class KeyboardDismisser extends StatelessWidget {
  const KeyboardDismisser({
    super.key,
    this.child,
    this.behavior,
    this.gestures = const [GestureType.onTap],
    this.dragStartBehavior = DragStartBehavior.start,
    this.excludeFromSemantics = false,
  });

  final List<GestureType> gestures;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior? behavior;
  final bool excludeFromSemantics;
  final Widget? child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    excludeFromSemantics: excludeFromSemantics,
    dragStartBehavior: dragStartBehavior,
    behavior: behavior,
    onTap: gestures.contains(GestureType.onTap)
        ? () => _unfocus(context)
        : null,
    onTapDown: gestures.contains(GestureType.onTapDown)
        ? (_) => _unfocus(context)
        : null,
    onPanUpdate: gestures.contains(GestureType.onPanUpdateAnyDirection)
        ? (_) => _unfocus(context)
        : null,
    onTapUp: gestures.contains(GestureType.onTapUp)
        ? (_) => _unfocus(context)
        : null,
    onTapCancel: gestures.contains(GestureType.onTapCancel)
        ? () => _unfocus(context)
        : null,
    onSecondaryTapDown: gestures.contains(GestureType.onSecondaryTapDown)
        ? (_) => _unfocus(context)
        : null,
    onSecondaryTapUp: gestures.contains(GestureType.onSecondaryTapUp)
        ? (_) => _unfocus(context)
        : null,
    onSecondaryTapCancel:
    gestures.contains(GestureType.onSecondaryTapCancel)
        ? () => _unfocus(context)
        : null,
    onDoubleTap: gestures.contains(GestureType.onDoubleTap)
        ? () => _unfocus(context)
        : null,
    onLongPress: gestures.contains(GestureType.onLongPress)
        ? () => _unfocus(context)
        : null,
    onLongPressStart: gestures.contains(GestureType.onLongPressStart)
        ? (_) => _unfocus(context)
        : null,
    onLongPressMoveUpdate:
    gestures.contains(GestureType.onLongPressMoveUpdate)
        ? (_) => _unfocus(context)
        : null,
    onLongPressUp: gestures.contains(GestureType.onLongPressUp)
        ? () => _unfocus(context)
        : null,
    onLongPressEnd: gestures.contains(GestureType.onLongPressEnd)
        ? (_) => _unfocus(context)
        : null,
    onVerticalDragDown: gestures.contains(GestureType.onVerticalDragDown)
        ? (_) => _unfocus(context)
        : null,
    onVerticalDragStart: gestures.contains(GestureType.onVerticalDragStart)
        ? (_) => _unfocus(context)
        : null,
    onVerticalDragUpdate: _gesturesContainsDirectionalPanUpdate()
        ? (details) => _unfocusWithDetails(context, details)
        : null,
    onVerticalDragEnd: gestures.contains(GestureType.onVerticalDragEnd)
        ? (_) => _unfocus(context)
        : null,
    onVerticalDragCancel:
    gestures.contains(GestureType.onVerticalDragCancel)
        ? () => _unfocus(context)
        : null,
    onHorizontalDragDown:
    gestures.contains(GestureType.onHorizontalDragDown)
        ? (_) => _unfocus(context)
        : null,
    onHorizontalDragStart:
    gestures.contains(GestureType.onHorizontalDragStart)
        ? (_) => _unfocus(context)
        : null,
    onHorizontalDragUpdate: _gesturesContainsDirectionalPanUpdate()
        ? (details) => _unfocusWithDetails(context, details)
        : null,
    onHorizontalDragEnd: gestures.contains(GestureType.onHorizontalDragEnd)
        ? (_) => _unfocus(context)
        : null,
    onHorizontalDragCancel:
    gestures.contains(GestureType.onHorizontalDragCancel)
        ? () => _unfocus(context)
        : null,
    onForcePressStart: gestures.contains(GestureType.onForcePressStart)
        ? (_) => _unfocus(context)
        : null,
    onForcePressPeak: gestures.contains(GestureType.onForcePressPeak)
        ? (_) => _unfocus(context)
        : null,
    onForcePressUpdate: gestures.contains(GestureType.onForcePressUpdate)
        ? (_) => _unfocus(context)
        : null,
    onForcePressEnd: gestures.contains(GestureType.onForcePressEnd)
        ? (_) => _unfocus(context)
        : null,
    onPanDown: gestures.contains(GestureType.onPanDown)
        ? (_) => _unfocus(context)
        : null,
    onPanStart: gestures.contains(GestureType.onPanStart)
        ? (_) => _unfocus(context)
        : null,
    onPanEnd: gestures.contains(GestureType.onPanEnd)
        ? (_) => _unfocus(context)
        : null,
    onPanCancel: gestures.contains(GestureType.onPanCancel)
        ? () => _unfocus(context)
        : null,
    onScaleStart: gestures.contains(GestureType.onScaleStart)
        ? (_) => _unfocus(context)
        : null,
    onScaleUpdate: gestures.contains(GestureType.onScaleUpdate)
        ? (_) => _unfocus(context)
        : null,
    onScaleEnd: gestures.contains(GestureType.onScaleEnd)
        ? (_) => _unfocus(context)
        : null,
    child: child,
  );

  void _unfocus(BuildContext context) =>
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

  void _unfocusWithDetails(
      BuildContext context,
      DragUpdateDetails details,
      ) {
    final dy = details.delta.dy;
    final dx = details.delta.dx;
    final isDragMainlyHorizontal = dx.abs() - dy.abs() > 0;
    if (gestures.contains(GestureType.onPanUpdateDownDirection) &&
        dy > 0 &&
        !isDragMainlyHorizontal) {
      _unfocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateUpDirection) &&
        dy < 0 &&
        !isDragMainlyHorizontal) {
      _unfocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateRightDirection) &&
        dx > 0 &&
        isDragMainlyHorizontal) {
      _unfocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateLeftDirection) &&
        dx < 0 &&
        isDragMainlyHorizontal) {
      _unfocus(context);
    }
  }

  bool _gesturesContainsDirectionalPanUpdate() =>
      gestures.contains(GestureType.onPanUpdateDownDirection) ||
          gestures.contains(GestureType.onPanUpdateUpDirection) ||
          gestures.contains(GestureType.onPanUpdateRightDirection) ||
          gestures.contains(GestureType.onPanUpdateLeftDirection);
}
