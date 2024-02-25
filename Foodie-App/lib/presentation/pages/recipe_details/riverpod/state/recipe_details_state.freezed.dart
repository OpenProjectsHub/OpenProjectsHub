// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipeDetailsState {
  bool get isLoading => throw _privateConstructorUsedError;
  RecipeData? get recipeData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeDetailsStateCopyWith<RecipeDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeDetailsStateCopyWith<$Res> {
  factory $RecipeDetailsStateCopyWith(
          RecipeDetailsState value, $Res Function(RecipeDetailsState) then) =
      _$RecipeDetailsStateCopyWithImpl<$Res, RecipeDetailsState>;
  @useResult
  $Res call({bool isLoading, RecipeData? recipeData});
}

/// @nodoc
class _$RecipeDetailsStateCopyWithImpl<$Res, $Val extends RecipeDetailsState>
    implements $RecipeDetailsStateCopyWith<$Res> {
  _$RecipeDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recipeData = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recipeData: freezed == recipeData
          ? _value.recipeData
          : recipeData // ignore: cast_nullable_to_non_nullable
              as RecipeData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeDetailsStateImplCopyWith<$Res>
    implements $RecipeDetailsStateCopyWith<$Res> {
  factory _$$RecipeDetailsStateImplCopyWith(_$RecipeDetailsStateImpl value,
          $Res Function(_$RecipeDetailsStateImpl) then) =
      __$$RecipeDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, RecipeData? recipeData});
}

/// @nodoc
class __$$RecipeDetailsStateImplCopyWithImpl<$Res>
    extends _$RecipeDetailsStateCopyWithImpl<$Res, _$RecipeDetailsStateImpl>
    implements _$$RecipeDetailsStateImplCopyWith<$Res> {
  __$$RecipeDetailsStateImplCopyWithImpl(_$RecipeDetailsStateImpl _value,
      $Res Function(_$RecipeDetailsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recipeData = freezed,
  }) {
    return _then(_$RecipeDetailsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recipeData: freezed == recipeData
          ? _value.recipeData
          : recipeData // ignore: cast_nullable_to_non_nullable
              as RecipeData?,
    ));
  }
}

/// @nodoc

class _$RecipeDetailsStateImpl extends _RecipeDetailsState {
  const _$RecipeDetailsStateImpl({this.isLoading = false, this.recipeData})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final RecipeData? recipeData;

  @override
  String toString() {
    return 'RecipeDetailsState(isLoading: $isLoading, recipeData: $recipeData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeDetailsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.recipeData, recipeData) ||
                other.recipeData == recipeData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, recipeData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeDetailsStateImplCopyWith<_$RecipeDetailsStateImpl> get copyWith =>
      __$$RecipeDetailsStateImplCopyWithImpl<_$RecipeDetailsStateImpl>(
          this, _$identity);
}

abstract class _RecipeDetailsState extends RecipeDetailsState {
  const factory _RecipeDetailsState(
      {final bool isLoading,
      final RecipeData? recipeData}) = _$RecipeDetailsStateImpl;
  const _RecipeDetailsState._() : super._();

  @override
  bool get isLoading;
  @override
  RecipeData? get recipeData;
  @override
  @JsonKey(ignore: true)
  _$$RecipeDetailsStateImplCopyWith<_$RecipeDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
