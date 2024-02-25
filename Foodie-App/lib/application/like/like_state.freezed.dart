// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LikeState {
  bool get isProductLoading => throw _privateConstructorUsedError;
  List<ProductData> get products => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LikeStateCopyWith<LikeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikeStateCopyWith<$Res> {
  factory $LikeStateCopyWith(LikeState value, $Res Function(LikeState) then) =
      _$LikeStateCopyWithImpl<$Res, LikeState>;
  @useResult
  $Res call({bool isProductLoading, List<ProductData> products});
}

/// @nodoc
class _$LikeStateCopyWithImpl<$Res, $Val extends LikeState>
    implements $LikeStateCopyWith<$Res> {
  _$LikeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductLoading = null,
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LikeStateImplCopyWith<$Res>
    implements $LikeStateCopyWith<$Res> {
  factory _$$LikeStateImplCopyWith(
          _$LikeStateImpl value, $Res Function(_$LikeStateImpl) then) =
      __$$LikeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isProductLoading, List<ProductData> products});
}

/// @nodoc
class __$$LikeStateImplCopyWithImpl<$Res>
    extends _$LikeStateCopyWithImpl<$Res, _$LikeStateImpl>
    implements _$$LikeStateImplCopyWith<$Res> {
  __$$LikeStateImplCopyWithImpl(
      _$LikeStateImpl _value, $Res Function(_$LikeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isProductLoading = null,
    Object? products = null,
  }) {
    return _then(_$LikeStateImpl(
      isProductLoading: null == isProductLoading
          ? _value.isProductLoading
          : isProductLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductData>,
    ));
  }
}

/// @nodoc

class _$LikeStateImpl extends _LikeState {
  const _$LikeStateImpl(
      {this.isProductLoading = true,
      final List<ProductData> products = const []})
      : _products = products,
        super._();

  @override
  @JsonKey()
  final bool isProductLoading;
  final List<ProductData> _products;
  @override
  @JsonKey()
  List<ProductData> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'LikeState(isProductLoading: $isProductLoading, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LikeStateImpl &&
            (identical(other.isProductLoading, isProductLoading) ||
                other.isProductLoading == isProductLoading) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isProductLoading,
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LikeStateImplCopyWith<_$LikeStateImpl> get copyWith =>
      __$$LikeStateImplCopyWithImpl<_$LikeStateImpl>(this, _$identity);
}

abstract class _LikeState extends LikeState {
  const factory _LikeState(
      {final bool isProductLoading,
      final List<ProductData> products}) = _$LikeStateImpl;
  const _LikeState._() : super._();

  @override
  bool get isProductLoading;
  @override
  List<ProductData> get products;
  @override
  @JsonKey(ignore: true)
  _$$LikeStateImplCopyWith<_$LikeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
