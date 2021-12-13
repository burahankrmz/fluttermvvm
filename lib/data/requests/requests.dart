class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;
  LoginRequest(this.email,this.password,this.imei,this.deviceType);
}

class RegisterRequest {
  String name;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(
    this.name,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password,
    this.profilePicture,
  );
}
