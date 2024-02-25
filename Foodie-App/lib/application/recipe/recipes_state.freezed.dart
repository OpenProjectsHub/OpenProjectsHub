// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecipesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<RecipeData> get recipes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipesStateCopyWith<RecipesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipesStateCopyWith<$Res> {
  factory $RecipesStateCopyWith(
          RecipesState value, $Res Function(RecipesState) then) =
      _$RecipesStateCopyWithImpl<$Res, RecipesState>;
  @useResult
  $Res call({bool isLoading, List<RecipeData> recipes});
}

/// @nodoc
class _$RecipesStateCopyWithImpl<$Res, $Val extends RecipesState>
    implements $RecipesStateCopyWith<$Res> {
  _$RecipesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recipes = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recipes: null == recipes
          ? _value.recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<RecipeData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipesStateImplCopyWith<$Res>
    implements $RecipesStateCopyWith<$Res> {
  factory _$$RecipesStateImplCopyWith(
          _$RecipesStateImpl value, $Res Function(_$RecipesStateImpl) then) =
      __$$RecipesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<RecipeData> recipes});
}

/// @nodoc
class __$$RecipesStateImplCopyWithImpl<$Res>
    extends _$RecipesStateCopyWithImpl<$Res, _$RecipesStateImpl>
    implements _$$RecipesStateImplCopyWith<$Res> {
  __$$RecipesStateImplCopyWithImpl(
      _$RecipesStateImpl _value, $Res Function(_$RecipesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recipes = null,
  }) {
    return _then(_$RecipesStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recipes: null == recipes
          ? _value._recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<RecipeData>,
    ));
  }
}

/// @nodoc

class _$RecipesStateImpl extends _RecipesState {
  const _$RecipesStateImpl(
      {this.isLoading = false, final List<RecipeData> recipes = const []})
      : _recipes = recipes,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<RecipeData> _recipes;
  @override
  @JsonKey()
  List<RecipeData> get recipes {
    if (_recipes is EqualUnmodifiableListView) return _recipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipes);
  }

  @override
  String toString() {
    return 'RecipesState(isLoading: $isLoading, recipes: $recipes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._recipes, _recipes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_recipes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipesStateImplCopyWith<_$RecipesStateImpl> get copyWith =>
      __$$RecipesStateImplCopyWithImpl<_$RecipesStateImpl>(this, _$identity);
}

abstract class _RecipesState extends RecipesState {
  const factory _RecipesState(
      {final bool isLoading,
      final List<RecipeData> recipes}) = _$RecipesStateImpl;
  const _RecipesState._() : super._();

  @override
  bool get isLoading;
  @override
  List<RecipeData> get recipes;
  @override
  @JsonKey(ignore: true)
  _$$RecipesStateImplCopyWith<_$RecipesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
