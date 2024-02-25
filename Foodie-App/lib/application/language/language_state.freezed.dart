// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LanguageState {
  List<LanguageData> get list => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LanguageStateCopyWith<LanguageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageStateCopyWith<$Res> {
  factory $LanguageStateCopyWith(
          LanguageState value, $Res Function(LanguageState) then) =
      _$LanguageStateCopyWithImpl<$Res, LanguageState>;
  @useResult
  $Res call(
      {List<LanguageData> list, int index, bool isLoading, bool isSuccess});
}

/// @nodoc
class _$LanguageStateCopyWithImpl<$Res, $Val extends LanguageState>
    implements $LanguageStateCopyWith<$Res> {
  _$LanguageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? index = null,
    Object? isLoading = null,
    Object? isSuccess = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageStateImplCopyWith<$Res>
    implements $LanguageStateCopyWith<$Res> {
  factory _$$LanguageStateImplCopyWith(
          _$LanguageStateImpl value, $Res Function(_$LanguageStateImpl) then) =
      __$$LanguageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LanguageData> list, int index, bool isLoading, bool isSuccess});
}

/// @nodoc
class __$$LanguageStateImplCopyWithImpl<$Res>
    extends _$LanguageStateCopyWithImpl<$Res, _$LanguageStateImpl>
    implements _$$LanguageStateImplCopyWith<$Res> {
  __$$LanguageStateImplCopyWithImpl(
      _$LanguageStateImpl _value, $Res Function(_$LanguageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? index = null,
    Object? isLoading = null,
    Object? isSuccess = null,
  }) {
    return _then(_$LanguageStateImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<LanguageData>,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LanguageStateImpl extends _LanguageState {
  const _$LanguageStateImpl(
      {final List<LanguageData> list = const [],
      this.index = 0,
      this.isLoading = true,
      this.isSuccess = false})
      : _list = list,
        super._();

  final List<LanguageData> _list;
  @override
  @JsonKey()
  List<LanguageData> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final int index;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;

  @override
  String toString() {
    return 'LanguageState(list: $list, index: $index, isLoading: $isLoading, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageStateImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), index, isLoading, isSuccess);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageStateImplCopyWith<_$LanguageStateImpl> get copyWith =>
      __$$LanguageStateImplCopyWithImpl<_$LanguageStateImpl>(this, _$identity);
}

abstract class _LanguageState extends LanguageState {
  const factory _LanguageState(
      {final List<LanguageData> list,
      final int index,
      final bool isLoading,
      final bool isSuccess}) = _$LanguageStateImpl;
  const _LanguageState._() : super._();

  @override
  List<LanguageData> get list;
  @override
  int get index;
  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  @JsonKey(ignore: true)
  _$$LanguageStateImplCopyWith<_$LanguageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
