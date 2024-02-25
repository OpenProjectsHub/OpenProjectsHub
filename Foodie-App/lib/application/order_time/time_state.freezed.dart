// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimeState {
  int get currentIndexOne => throw _privateConstructorUsedError;
  int get currentIndexTwo => throw _privateConstructorUsedError;
  int? get selectIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeStateCopyWith<TimeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeStateCopyWith<$Res> {
  factory $TimeStateCopyWith(TimeState value, $Res Function(TimeState) then) =
      _$TimeStateCopyWithImpl<$Res, TimeState>;
  @useResult
  $Res call({int currentIndexOne, int currentIndexTwo, int? selectIndex});
}

/// @nodoc
class _$TimeStateCopyWithImpl<$Res, $Val extends TimeState>
    implements $TimeStateCopyWith<$Res> {
  _$TimeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndexOne = null,
    Object? currentIndexTwo = null,
    Object? selectIndex = freezed,
  }) {
    return _then(_value.copyWith(
      currentIndexOne: null == currentIndexOne
          ? _value.currentIndexOne
          : currentIndexOne // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexTwo: null == currentIndexTwo
          ? _value.currentIndexTwo
          : currentIndexTwo // ignore: cast_nullable_to_non_nullable
              as int,
      selectIndex: freezed == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeStateImplCopyWith<$Res>
    implements $TimeStateCopyWith<$Res> {
  factory _$$TimeStateImplCopyWith(
          _$TimeStateImpl value, $Res Function(_$TimeStateImpl) then) =
      __$$TimeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentIndexOne, int currentIndexTwo, int? selectIndex});
}

/// @nodoc
class __$$TimeStateImplCopyWithImpl<$Res>
    extends _$TimeStateCopyWithImpl<$Res, _$TimeStateImpl>
    implements _$$TimeStateImplCopyWith<$Res> {
  __$$TimeStateImplCopyWithImpl(
      _$TimeStateImpl _value, $Res Function(_$TimeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndexOne = null,
    Object? currentIndexTwo = null,
    Object? selectIndex = freezed,
  }) {
    return _then(_$TimeStateImpl(
      currentIndexOne: null == currentIndexOne
          ? _value.currentIndexOne
          : currentIndexOne // ignore: cast_nullable_to_non_nullable
              as int,
      currentIndexTwo: null == currentIndexTwo
          ? _value.currentIndexTwo
          : currentIndexTwo // ignore: cast_nullable_to_non_nullable
              as int,
      selectIndex: freezed == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$TimeStateImpl extends _TimeState {
  const _$TimeStateImpl(
      {this.currentIndexOne = 0,
      this.currentIndexTwo = 0,
      this.selectIndex = null})
      : super._();

  @override
  @JsonKey()
  final int currentIndexOne;
  @override
  @JsonKey()
  final int currentIndexTwo;
  @override
  @JsonKey()
  final int? selectIndex;

  @override
  String toString() {
    return 'TimeState(currentIndexOne: $currentIndexOne, currentIndexTwo: $currentIndexTwo, selectIndex: $selectIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeStateImpl &&
            (identical(other.currentIndexOne, currentIndexOne) ||
                other.currentIndexOne == currentIndexOne) &&
            (identical(other.currentIndexTwo, currentIndexTwo) ||
                other.currentIndexTwo == currentIndexTwo) &&
            (identical(other.selectIndex, selectIndex) ||
                other.selectIndex == selectIndex));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentIndexOne, currentIndexTwo, selectIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeStateImplCopyWith<_$TimeStateImpl> get copyWith =>
      __$$TimeStateImplCopyWithImpl<_$TimeStateImpl>(this, _$identity);
}

abstract class _TimeState extends TimeState {
  const factory _TimeState(
      {final int currentIndexOne,
      final int currentIndexTwo,
      final int? selectIndex}) = _$TimeStateImpl;
  const _TimeState._() : super._();

  @override
  int get currentIndexOne;
  @override
  int get currentIndexTwo;
  @override
  int? get selectIndex;
  @override
  @JsonKey(ignore: true)
  _$$TimeStateImplCopyWith<_$TimeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
