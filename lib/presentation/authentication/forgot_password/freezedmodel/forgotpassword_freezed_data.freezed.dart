// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'forgotpassword_freezed_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ForgotPasswordObjectTearOff {
  const _$ForgotPasswordObjectTearOff();

  _ForgotPasswordObject call(String email) {
    return _ForgotPasswordObject(
      email,
    );
  }
}

/// @nodoc
const $ForgotPasswordObject = _$ForgotPasswordObjectTearOff();

/// @nodoc
mixin _$ForgotPasswordObject {
  String get email => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgotPasswordObjectCopyWith<ForgotPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordObjectCopyWith<$Res> {
  factory $ForgotPasswordObjectCopyWith(ForgotPasswordObject value,
          $Res Function(ForgotPasswordObject) then) =
      _$ForgotPasswordObjectCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordObjectCopyWithImpl<$Res>
    implements $ForgotPasswordObjectCopyWith<$Res> {
  _$ForgotPasswordObjectCopyWithImpl(this._value, this._then);

  final ForgotPasswordObject _value;
  // ignore: unused_field
  final $Res Function(ForgotPasswordObject) _then;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ForgotPasswordObjectCopyWith<$Res>
    implements $ForgotPasswordObjectCopyWith<$Res> {
  factory _$ForgotPasswordObjectCopyWith(_ForgotPasswordObject value,
          $Res Function(_ForgotPasswordObject) then) =
      __$ForgotPasswordObjectCopyWithImpl<$Res>;
  @override
  $Res call({String email});
}

/// @nodoc
class __$ForgotPasswordObjectCopyWithImpl<$Res>
    extends _$ForgotPasswordObjectCopyWithImpl<$Res>
    implements _$ForgotPasswordObjectCopyWith<$Res> {
  __$ForgotPasswordObjectCopyWithImpl(
      _ForgotPasswordObject _value, $Res Function(_ForgotPasswordObject) _then)
      : super(_value, (v) => _then(v as _ForgotPasswordObject));

  @override
  _ForgotPasswordObject get _value => super._value as _ForgotPasswordObject;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_ForgotPasswordObject(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ForgotPasswordObject implements _ForgotPasswordObject {
  _$_ForgotPasswordObject(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordObject(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ForgotPasswordObject &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$ForgotPasswordObjectCopyWith<_ForgotPasswordObject> get copyWith =>
      __$ForgotPasswordObjectCopyWithImpl<_ForgotPasswordObject>(
          this, _$identity);
}

abstract class _ForgotPasswordObject implements ForgotPasswordObject {
  factory _ForgotPasswordObject(String email) = _$_ForgotPasswordObject;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$ForgotPasswordObjectCopyWith<_ForgotPasswordObject> get copyWith =>
      throw _privateConstructorUsedError;
}
