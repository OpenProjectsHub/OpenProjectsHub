// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchState {
  bool get isProductLoading => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;
  int get selectIndexCategory => throw _privateConstructorUsedError;
  List<String> get searchHistory => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {bool isProductLoading,
      String search,
      List<ProductData> products,
      int selectIndexCategory,
      List<String> searchHistory});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductLoading = null,
    Object? search = null,
    Object? products = null,
    Object? selectIndexCategory = null,
    Object? searchHistory = null,
  }) {
    return _then(_value.copyWith(
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      selectIndexCategory: null == selectIndexCategory
          ? _value.selectIndexCategory
          : selectIndexCategory // ignore: cast_nullable_to_non_nullable
              as int,
      searchHistory: null == searchHistory
          ? _value.searchHistory
          : searchHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isProductLoading,
      String search,
      List<ProductData> products,
      int selectIndexCategory,
      List<String> searchHistory});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductLoading = null,
    Object? search = null,
    Object? products = null,
    Object? selectIndexCategory = null,
    Object? searchHistory = null,
  }) {
    return _then(_$SearchStateImpl(
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
      selectIndexCategory: null == selectIndexCategory
          ? _value.selectIndexCategory
          : selectIndexCategory // ignore: cast_nullable_to_non_nullable
              as int,
      searchHistory: null == searchHistory
          ? _value._searchHistory
          : searchHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SearchStateImpl extends _SearchState {
  const _$SearchStateImpl(
      {this.isProductLoading = true,
      this.search = "",
      final List<ProductData> products = const [],
      this.selectIndexCategory = -1,
      final List<String> searchHistory = const []})
      : _products = products,
        _searchHistory = searchHistory,
        super._();

  @override
  @JsonKey()
  final bool isProductLoading;
  @override
  @JsonKey()
  final String search;
  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey()
  final int selectIndexCategory;
  final List<String> _searchHistory;
  @override
  @JsonKey()
  List<String> get searchHistory {
    if (_searchHistory is EqualUnmodifiableListView) return _searchHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchHistory);
  }

  @override
  String toString() {
    return 'SearchState(isProductLoading: $isProductLoading, search: $search, products: $products, selectIndexCategory: $selectIndexCategory, searchHistory: $searchHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.isProductLoading, isProductLoading) ||
                other.isProductLoading == isProductLoading) &&
            (identical(other.search, search) || other.search == search) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.selectIndexCategory, selectIndexCategory) ||
                other.selectIndexCategory == selectIndexCategory) &&
            const DeepCollectionEquality()
                .equals(other._searchHistory, _searchHistory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isProductLoading,
      search,
      const DeepCollectionEquality().hash(_products),
      selectIndexCategory,
      const DeepCollectionEquality().hash(_searchHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState extends SearchState {
  const factory _SearchState(
      {final bool isProductLoading,
      final String search,
      final List<ProductData> products,
      final int selectIndexCategory,
      final List<String> searchHistory}) = _$SearchStateImpl;
  const _SearchState._() : super._();

  @override
  bool get isProductLoading;
  @override
  String get search;
  @override
  List<ProductData> get products;
  @override
  int get selectIndexCategory;
  @override
  List<String> get searchHistory;
  @override
  @JsonKey(ignore: true)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
