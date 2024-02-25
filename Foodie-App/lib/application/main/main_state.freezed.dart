// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainState {
  List<Widget> get listOfWidget => throw _privateConstructorUsedError;
  int get selectIndex => throw _privateConstructorUsedError;
  bool get isScrolling => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainStateCopyWith<MainState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
  @useResult
  $Res call({List<Widget> listOfWidget, int selectIndex, bool isScrolling});
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfWidget = null,
    Object? selectIndex = null,
    Object? isScrolling = null,
  }) {
    return _then(_value.copyWith(
      listOfWidget: null == listOfWidget
          ? _value.listOfWidget
          : listOfWidget // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isScrolling: null == isScrolling
          ? _value.isScrolling
          : isScrolling // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainStateImplCopyWith<$Res>
    implements $MainStateCopyWith<$Res> {
  factory _$$MainStateImplCopyWith(
          _$MainStateImpl value, $Res Function(_$MainStateImpl) then) =
      __$$MainStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Widget> listOfWidget, int selectIndex, bool isScrolling});
}

/// @nodoc
class __$$MainStateImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainStateImpl>
    implements _$$MainStateImplCopyWith<$Res> {
  __$$MainStateImplCopyWithImpl(
      _$MainStateImpl _value, $Res Function(_$MainStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listOfWidget = null,
    Object? selectIndex = null,
    Object? isScrolling = null,
  }) {
    return _then(_$MainStateImpl(
      listOfWidget: null == listOfWidget
          ? _value._listOfWidget
          : listOfWidget // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      selectIndex: null == selectIndex
          ? _value.selectIndex
          : selectIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isScrolling: null == isScrolling
          ? _value.isScrolling
          : isScrolling // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MainStateImpl extends _MainState {
  const _$MainStateImpl(
      {final List<Widget> listOfWidget = const [],
      this.selectIndex = 0,
      this.isScrolling = false})
      : _listOfWidget = listOfWidget,
        super._();

  final List<Widget> _listOfWidget;
  @override
  @JsonKey()
  List<Widget> get listOfWidget {
    if (_listOfWidget is EqualUnmodifiableListView) return _listOfWidget;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listOfWidget);
  }

  @override
  @JsonKey()
  final int selectIndex;
  @override
  @JsonKey()
  final bool isScrolling;

  @override
  String toString() {
    return 'MainState(listOfWidget: $listOfWidget, selectIndex: $selectIndex, isScrolling: $isScrolling)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainStateImpl &&
            const DeepCollectionEquality()
                .equals(other._listOfWidget, _listOfWidget) &&
            (identical(other.selectIndex, selectIndex) ||
                other.selectIndex == selectIndex) &&
            (identical(other.isScrolling, isScrolling) ||
                other.isScrolling == isScrolling));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_listOfWidget),
      selectIndex,
      isScrolling);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      __$$MainStateImplCopyWithImpl<_$MainStateImpl>(this, _$identity);
}

abstract class _MainState extends MainState {
  const factory _MainState(
      {final List<Widget> listOfWidget,
      final int selectIndex,
      final bool isScrolling}) = _$MainStateImpl;
  const _MainState._() : super._();

  @override
  List<Widget> get listOfWidget;
  @override
  int get selectIndex;
  @override
  bool get isScrolling;
  @override
  @JsonKey(ignore: true)
  _$$MainStateImplCopyWith<_$MainStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
