import 'package:freezed_annotation/freezed_annotation.dart';
part 'forgotpassword_freezed_data.freezed.dart';

@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject(String email) = _ForgotPasswordObject;
}
