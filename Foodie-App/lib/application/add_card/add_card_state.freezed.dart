// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddCardState {
  bool get isActiveCard => throw _privateConstructorUsedError;
  String get cardNumber => throw _privateConstructorUsedError;
  String get cardName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get cvc => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddCardStateCopyWith<AddCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddCardStateCopyWith<$Res> {
  factory $AddCardStateCopyWith(
          AddCardState value, $Res Function(AddCardState) then) =
      _$AddCardStateCopyWithImpl<$Res, AddCardState>;
  @useResult
  $Res call(
      {bool isActiveCard,
      String cardNumber,
      String cardName,
      String date,
      String cvc});
}

/// @nodoc
class _$AddCardStateCopyWithImpl<$Res, $Val extends AddCardState>
    implements $AddCardStateCopyWith<$Res> {
  _$AddCardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveCard = null,
    Object? cardNumber = null,
    Object? cardName = null,
    Object? date = null,
    Object? cvc = null,
  }) {
    return _then(_value.copyWith(
      isActiveCard: null == isActiveCard
          ? _value.isActiveCard
          : isActiveCard // ignore: cast_nullable_to_non_nullable
              as bool,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      cvc: null == cvc
          ? _value.cvc
          : cvc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddCardStateImplCopyWith<$Res>
    implements $AddCardStateCopyWith<$Res> {
  factory _$$AddCardStateImplCopyWith(
          _$AddCardStateImpl value, $Res Function(_$AddCardStateImpl) then) =
      __$$AddCardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isActiveCard,
      String cardNumber,
      String cardName,
      String date,
      String cvc});
}

/// @nodoc
class __$$AddCardStateImplCopyWithImpl<$Res>
    extends _$AddCardStateCopyWithImpl<$Res, _$AddCardStateImpl>
    implements _$$AddCardStateImplCopyWith<$Res> {
  __$$AddCardStateImplCopyWithImpl(
      _$AddCardStateImpl _value, $Res Function(_$AddCardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveCard = null,
    Object? cardNumber = null,
    Object? cardName = null,
    Object? date = null,
    Object? cvc = null,
  }) {
    return _then(_$AddCardStateImpl(
      isActiveCard: null == isActiveCard
          ? _value.isActiveCard
          : isActiveCard // ignore: cast_nullable_to_non_nullable
              as bool,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      cvc: null == cvc
          ? _value.cvc
          : cvc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddCardStateImpl extends _AddCardState {
  const _$AddCardStateImpl(
      {this.isActiveCard = false,
      this.cardNumber = "0000 0000 0000 0000",
      this.cardName = "",
      this.date = "",
      this.cvc = ""})
      : super._();

  @override
  @JsonKey()
  final bool isActiveCard;
  @override
  @JsonKey()
  final String cardNumber;
  @override
  @JsonKey()
  final String cardName;
  @override
  @JsonKey()
  final String date;
  @override
  @JsonKey()
  final String cvc;

  @override
  String toString() {
    return 'AddCardState(isActiveCard: $isActiveCard, cardNumber: $cardNumber, cardName: $cardName, date: $date, cvc: $cvc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCardStateImpl &&
            (identical(other.isActiveCard, isActiveCard) ||
                other.isActiveCard == isActiveCard) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cardName, cardName) ||
                other.cardName == cardName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.cvc, cvc) || other.cvc == cvc));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isActiveCard, cardNumber, cardName, date, cvc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCardStateImplCopyWith<_$AddCardStateImpl> get copyWith =>
      __$$AddCardStateImplCopyWithImpl<_$AddCardStateImpl>(this, _$identity);
}

abstract class _AddCardState extends AddCardState {
  const factory _AddCardState(
      {final bool isActiveCard,
      final String cardNumber,
      final String cardName,
      final String date,
      final String cvc}) = _$AddCardStateImpl;
  const _AddCardState._() : super._();

  @override
  bool get isActiveCard;
  @override
  String get cardNumber;
  @override
  String get cardName;
  @override
  String get date;
  @override
  String get cvc;
  @override
  @JsonKey(ignore: true)
  _$$AddCardStateImplCopyWith<_$AddCardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
