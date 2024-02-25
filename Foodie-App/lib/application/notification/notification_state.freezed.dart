// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationState {
  List<NotificationModel> get news => throw _privateConstructorUsedError;
  List<NotificationModel> get orders => throw _privateConstructorUsedError;
  List<NotificationModel> get reservations =>
      throw _privateConstructorUsedError;
  CountNotificationModel? get countOfNotifications =>
      throw _privateConstructorUsedError;
  bool get isReadAllLoading => throw _privateConstructorUsedError;
  bool get isAllNotificationsLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationStateCopyWith<NotificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationStateCopyWith<$Res> {
  factory $NotificationStateCopyWith(
          NotificationState value, $Res Function(NotificationState) then) =
      _$NotificationStateCopyWithImpl<$Res, NotificationState>;
  @useResult
  $Res call(
      {List<NotificationModel> news,
      List<NotificationModel> orders,
      List<NotificationModel> reservations,
      CountNotificationModel? countOfNotifications,
      bool isReadAllLoading,
      bool isAllNotificationsLoading});
}

/// @nodoc
class _$NotificationStateCopyWithImpl<$Res, $Val extends NotificationState>
    implements $NotificationStateCopyWith<$Res> {
  _$NotificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? news = null,
    Object? orders = null,
    Object? reservations = null,
    Object? countOfNotifications = freezed,
    Object? isReadAllLoading = null,
    Object? isAllNotificationsLoading = null,
  }) {
    return _then(_value.copyWith(
      news: null == news
          ? _value.news
          : news // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      reservations: null == reservations
          ? _value.reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      countOfNotifications: freezed == countOfNotifications
          ? _value.countOfNotifications
          : countOfNotifications // ignore: cast_nullable_to_non_nullable
              as CountNotificationModel?,
      isReadAllLoading: null == isReadAllLoading
          ? _value.isReadAllLoading
          : isReadAllLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAllNotificationsLoading: null == isAllNotificationsLoading
          ? _value.isAllNotificationsLoading
          : isAllNotificationsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationStateImplCopyWith<$Res>
    implements $NotificationStateCopyWith<$Res> {
  factory _$$NotificationStateImplCopyWith(_$NotificationStateImpl value,
          $Res Function(_$NotificationStateImpl) then) =
      __$$NotificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NotificationModel> news,
      List<NotificationModel> orders,
      List<NotificationModel> reservations,
      CountNotificationModel? countOfNotifications,
      bool isReadAllLoading,
      bool isAllNotificationsLoading});
}

/// @nodoc
class __$$NotificationStateImplCopyWithImpl<$Res>
    extends _$NotificationStateCopyWithImpl<$Res, _$NotificationStateImpl>
    implements _$$NotificationStateImplCopyWith<$Res> {
  __$$NotificationStateImplCopyWithImpl(_$NotificationStateImpl _value,
      $Res Function(_$NotificationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? news = null,
    Object? orders = null,
    Object? reservations = null,
    Object? countOfNotifications = freezed,
    Object? isReadAllLoading = null,
    Object? isAllNotificationsLoading = null,
  }) {
    return _then(_$NotificationStateImpl(
      news: null == news
          ? _value._news
          : news // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      reservations: null == reservations
          ? _value._reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as List<NotificationModel>,
      countOfNotifications: freezed == countOfNotifications
          ? _value.countOfNotifications
          : countOfNotifications // ignore: cast_nullable_to_non_nullable
              as CountNotificationModel?,
      isReadAllLoading: null == isReadAllLoading
          ? _value.isReadAllLoading
          : isReadAllLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isAllNotificationsLoading: null == isAllNotificationsLoading
          ? _value.isAllNotificationsLoading
          : isAllNotificationsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NotificationStateImpl extends _NotificationState {
  const _$NotificationStateImpl(
      {final List<NotificationModel> news = const [],
      final List<NotificationModel> orders = const [],
      final List<NotificationModel> reservations = const [],
      this.countOfNotifications = null,
      this.isReadAllLoading = false,
      this.isAllNotificationsLoading = false})
      : _news = news,
        _orders = orders,
        _reservations = reservations,
        super._();

  final List<NotificationModel> _news;
  @override
  @JsonKey()
  List<NotificationModel> get news {
    if (_news is EqualUnmodifiableListView) return _news;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_news);
  }

  final List<NotificationModel> _orders;
  @override
  @JsonKey()
  List<NotificationModel> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  final List<NotificationModel> _reservations;
  @override
  @JsonKey()
  List<NotificationModel> get reservations {
    if (_reservations is EqualUnmodifiableListView) return _reservations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reservations);
  }

  @override
  @JsonKey()
  final CountNotificationModel? countOfNotifications;
  @override
  @JsonKey()
  final bool isReadAllLoading;
  @override
  @JsonKey()
  final bool isAllNotificationsLoading;

  @override
  String toString() {
    return 'NotificationState(news: $news, orders: $orders, reservations: $reservations, countOfNotifications: $countOfNotifications, isReadAllLoading: $isReadAllLoading, isAllNotificationsLoading: $isAllNotificationsLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationStateImpl &&
            const DeepCollectionEquality().equals(other._news, _news) &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            const DeepCollectionEquality()
                .equals(other._reservations, _reservations) &&
            (identical(other.countOfNotifications, countOfNotifications) ||
                other.countOfNotifications == countOfNotifications) &&
            (identical(other.isReadAllLoading, isReadAllLoading) ||
                other.isReadAllLoading == isReadAllLoading) &&
            (identical(other.isAllNotificationsLoading,
                    isAllNotificationsLoading) ||
                other.isAllNotificationsLoading == isAllNotificationsLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_news),
      const DeepCollectionEquality().hash(_orders),
      const DeepCollectionEquality().hash(_reservations),
      countOfNotifications,
      isReadAllLoading,
      isAllNotificationsLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationStateImplCopyWith<_$NotificationStateImpl> get copyWith =>
      __$$NotificationStateImplCopyWithImpl<_$NotificationStateImpl>(
          this, _$identity);
}

abstract class _NotificationState extends NotificationState {
  const factory _NotificationState(
      {final List<NotificationModel> news,
      final List<NotificationModel> orders,
      final List<NotificationModel> reservations,
      final CountNotificationModel? countOfNotifications,
      final bool isReadAllLoading,
      final bool isAllNotificationsLoading}) = _$NotificationStateImpl;
  const _NotificationState._() : super._();

  @override
  List<NotificationModel> get news;
  @override
  List<NotificationModel> get orders;
  @override
  List<NotificationModel> get reservations;
  @override
  CountNotificationModel? get countOfNotifications;
  @override
  bool get isReadAllLoading;
  @override
  bool get isAllNotificationsLoading;
  @override
  @JsonKey(ignore: true)
  _$$NotificationStateImplCopyWith<_$NotificationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
