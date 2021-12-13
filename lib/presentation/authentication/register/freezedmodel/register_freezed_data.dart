import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_freezed_data.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String name,
      String countryMobileCode,
      String email,
      String password,
      String mobileNumber,
      String profilePicture) = _RegisterObject;
}
