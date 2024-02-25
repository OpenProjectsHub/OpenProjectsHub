// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HelpState {
  bool get isLoading => throw _privateConstructorUsedError;
  HelpModel? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HelpStateCopyWith<HelpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpStateCopyWith<$Res> {
  factory $HelpStateCopyWith(HelpState value, $Res Function(HelpState) then) =
      _$HelpStateCopyWithImpl<$Res, HelpState>;
  @useResult
  $Res call({bool isLoading, HelpModel? data});
}

/// @nodoc
class _$HelpStateCopyWithImpl<$Res, $Val extends HelpState>
    implements $HelpStateCopyWith<$Res> {
  _$HelpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as HelpModel?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelpStateImplCopyWith<$Res>
    implements $HelpStateCopyWith<$Res> {
  factory _$$HelpStateImplCopyWith(
          _$HelpStateImpl value, $Res Function(_$HelpStateImpl) then) =
      __$$HelpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, HelpModel? data});
}

/// @nodoc
class __$$HelpStateImplCopyWithImpl<$Res>
    extends _$HelpStateCopyWithImpl<$Res, _$HelpStateImpl>
    implements _$$HelpStateImplCopyWith<$Res> {
  __$$HelpStateImplCopyWithImpl(
      _$HelpStateImpl _value, $Res Function(_$HelpStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? data = freezed,
  }) {
    return _then(_$HelpStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as HelpModel?,
    ));
  }
}

/// @nodoc

class _$HelpStateImpl extends _HelpState {
  const _$HelpStateImpl({this.isLoading = false, this.data = null}) : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final HelpModel? data;

  @override
  String toString() {
    return 'HelpState(isLoading: $isLoading, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelpStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelpStateImplCopyWith<_$HelpStateImpl> get copyWith =>
      __$$HelpStateImplCopyWithImpl<_$HelpStateImpl>(this, _$identity);
}

abstract class _HelpState extends HelpState {
  const factory _HelpState({final bool isLoading, final HelpModel? data}) =
      _$HelpStateImpl;
  const _HelpState._() : super._();

  @override
  bool get isLoading;
  @override
  HelpModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$HelpStateImplCopyWith<_$HelpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
