// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrdersListState {
  bool get isActiveLoading => throw _privateConstructorUsedError;
  bool get isHistoryLoading => throw _privateConstructorUsedError;
  bool get isRefundLoading => throw _privateConstructorUsedError;
  int get totalActiveCount => throw _privateConstructorUsedError;
  List<OrderActiveModel> get activeOrders => throw _privateConstructorUsedError;
  List<OrderActiveModel> get historyOrders =>
      throw _privateConstructorUsedError;
  List<RefundModel> get refundOrders => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrdersListStateCopyWith<OrdersListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersListStateCopyWith<$Res> {
  factory $OrdersListStateCopyWith(
          OrdersListState value, $Res Function(OrdersListState) then) =
      _$OrdersListStateCopyWithImpl<$Res, OrdersListState>;
  @useResult
  $Res call(
      {bool isActiveLoading,
      bool isHistoryLoading,
      bool isRefundLoading,
      int totalActiveCount,
      List<OrderActiveModel> activeOrders,
      List<OrderActiveModel> historyOrders,
      List<RefundModel> refundOrders});
}

/// @nodoc
class _$OrdersListStateCopyWithImpl<$Res, $Val extends OrdersListState>
    implements $OrdersListStateCopyWith<$Res> {
  _$OrdersListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveLoading = null,
    Object? isHistoryLoading = null,
    Object? isRefundLoading = null,
    Object? totalActiveCount = null,
    Object? activeOrders = null,
    Object? historyOrders = null,
    Object? refundOrders = null,
  }) {
    return _then(_value.copyWith(
      isActiveLoading: null == isActiveLoading
          ? _value.isActiveLoading
          : isActiveLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _value.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefundLoading: null == isRefundLoading
          ? _value.isRefundLoading
          : isRefundLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      totalActiveCount: null == totalActiveCount
          ? _value.totalActiveCount
          : totalActiveCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeOrders: null == activeOrders
          ? _value.activeOrders
          : activeOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderActiveModel>,
      historyOrders: null == historyOrders
          ? _value.historyOrders
          : historyOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderActiveModel>,
      refundOrders: null == refundOrders
          ? _value.refundOrders
          : refundOrders // ignore: cast_nullable_to_non_nullable
              as List<RefundModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrdersListStateImplCopyWith<$Res>
    implements $OrdersListStateCopyWith<$Res> {
  factory _$$OrdersListStateImplCopyWith(_$OrdersListStateImpl value,
          $Res Function(_$OrdersListStateImpl) then) =
      __$$OrdersListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isActiveLoading,
      bool isHistoryLoading,
      bool isRefundLoading,
      int totalActiveCount,
      List<OrderActiveModel> activeOrders,
      List<OrderActiveModel> historyOrders,
      List<RefundModel> refundOrders});
}

/// @nodoc
class __$$OrdersListStateImplCopyWithImpl<$Res>
    extends _$OrdersListStateCopyWithImpl<$Res, _$OrdersListStateImpl>
    implements _$$OrdersListStateImplCopyWith<$Res> {
  __$$OrdersListStateImplCopyWithImpl(
      _$OrdersListStateImpl _value, $Res Function(_$OrdersListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveLoading = null,
    Object? isHistoryLoading = null,
    Object? isRefundLoading = null,
    Object? totalActiveCount = null,
    Object? activeOrders = null,
    Object? historyOrders = null,
    Object? refundOrders = null,
  }) {
    return _then(_$OrdersListStateImpl(
      isActiveLoading: null == isActiveLoading
          ? _value.isActiveLoading
          : isActiveLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _value.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isRefundLoading: null == isRefundLoading
          ? _value.isRefundLoading
          : isRefundLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      totalActiveCount: null == totalActiveCount
          ? _value.totalActiveCount
          : totalActiveCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeOrders: null == activeOrders
          ? _value._activeOrders
          : activeOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderActiveModel>,
      historyOrders: null == historyOrders
          ? _value._historyOrders
          : historyOrders // ignore: cast_nullable_to_non_nullable
              as List<OrderActiveModel>,
      refundOrders: null == refundOrders
          ? _value._refundOrders
          : refundOrders // ignore: cast_nullable_to_non_nullable
              as List<RefundModel>,
    ));
  }
}

/// @nodoc

class _$OrdersListStateImpl extends _OrdersListState {
  const _$OrdersListStateImpl(
      {this.isActiveLoading = false,
      this.isHistoryLoading = false,
      this.isRefundLoading = false,
      this.totalActiveCount = 0,
      final List<OrderActiveModel> activeOrders = const [],
      final List<OrderActiveModel> historyOrders = const [],
      final List<RefundModel> refundOrders = const []})
      : _activeOrders = activeOrders,
        _historyOrders = historyOrders,
        _refundOrders = refundOrders,
        super._();

  @override
  @JsonKey()
  final bool isActiveLoading;
  @override
  @JsonKey()
  final bool isHistoryLoading;
  @override
  @JsonKey()
  final bool isRefundLoading;
  @override
  @JsonKey()
  final int totalActiveCount;
  final List<OrderActiveModel> _activeOrders;
  @override
  @JsonKey()
  List<OrderActiveModel> get activeOrders {
    if (_activeOrders is EqualUnmodifiableListView) return _activeOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeOrders);
  }

  final List<OrderActiveModel> _historyOrders;
  @override
  @JsonKey()
  List<OrderActiveModel> get historyOrders {
    if (_historyOrders is EqualUnmodifiableListView) return _historyOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyOrders);
  }

  final List<RefundModel> _refundOrders;
  @override
  @JsonKey()
  List<RefundModel> get refundOrders {
    if (_refundOrders is EqualUnmodifiableListView) return _refundOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refundOrders);
  }

  @override
  String toString() {
    return 'OrdersListState(isActiveLoading: $isActiveLoading, isHistoryLoading: $isHistoryLoading, isRefundLoading: $isRefundLoading, totalActiveCount: $totalActiveCount, activeOrders: $activeOrders, historyOrders: $historyOrders, refundOrders: $refundOrders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrdersListStateImpl &&
            (identical(other.isActiveLoading, isActiveLoading) ||
                other.isActiveLoading == isActiveLoading) &&
            (identical(other.isHistoryLoading, isHistoryLoading) ||
                other.isHistoryLoading == isHistoryLoading) &&
            (identical(other.isRefundLoading, isRefundLoading) ||
                other.isRefundLoading == isRefundLoading) &&
            (identical(other.totalActiveCount, totalActiveCount) ||
                other.totalActiveCount == totalActiveCount) &&
            const DeepCollectionEquality()
                .equals(other._activeOrders, _activeOrders) &&
            const DeepCollectionEquality()
                .equals(other._historyOrders, _historyOrders) &&
            const DeepCollectionEquality()
                .equals(other._refundOrders, _refundOrders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isActiveLoading,
      isHistoryLoading,
      isRefundLoading,
      totalActiveCount,
      const DeepCollectionEquality().hash(_activeOrders),
      const DeepCollectionEquality().hash(_historyOrders),
      const DeepCollectionEquality().hash(_refundOrders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrdersListStateImplCopyWith<_$OrdersListStateImpl> get copyWith =>
      __$$OrdersListStateImplCopyWithImpl<_$OrdersListStateImpl>(
          this, _$identity);
}

abstract class _OrdersListState extends OrdersListState {
  const factory _OrdersListState(
      {final bool isActiveLoading,
      final bool isHistoryLoading,
      final bool isRefundLoading,
      final int totalActiveCount,
      final List<OrderActiveModel> activeOrders,
      final List<OrderActiveModel> historyOrders,
      final List<RefundModel> refundOrders}) = _$OrdersListStateImpl;
  const _OrdersListState._() : super._();

  @override
  bool get isActiveLoading;
  @override
  bool get isHistoryLoading;
  @override
  bool get isRefundLoading;
  @override
  int get totalActiveCount;
  @override
  List<OrderActiveModel> get activeOrders;
  @override
  List<OrderActiveModel> get historyOrders;
  @override
  List<RefundModel> get refundOrders;
  @override
  @JsonKey(ignore: true)
  _$$OrdersListStateImplCopyWith<_$OrdersListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
