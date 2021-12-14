import 'dart:async';
import 'dart:io';
import 'package:flutteradvancedmvvm/app/functions.dart';
import 'package:flutteradvancedmvvm/domain/usecase/register_usecase.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/register/freezedmodel/register_freezed_data.dart';
import 'package:flutteradvancedmvvm/presentation/base/baseviewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _countryMobileCodeController =
      StreamController<String>.broadcast();
  final StreamController _userNameController =
      StreamController<String>.broadcast();
  final StreamController _emailController =
      StreamController<String>.broadcast();
  final StreamController _passwordController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureController =
      StreamController<File>.broadcast();
  final StreamController _isALLInputValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "", "");
  final RegisterUsecase _registerUsecase;
  RegisterViewModel(this._registerUsecase);

  @override
  void dispose() {
    _countryMobileCodeController.close();
    _userNameController.close();
    _emailController.close();
    _passwordController.close();
    _mobileNumberController.close();
    _profilePictureController.close();
    _isALLInputValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  //? INPUTS
  @override
  Sink get inputcountryMobileCode => _countryMobileCodeController.sink;
  @override
  Sink get inputuserName => _userNameController.sink;
  @override
  Sink get inputemail => _emailController.sink;
  @override
  Sink get inputpassword => _passwordController.sink;
  @override
  Sink get inputmobileNumber => _mobileNumberController.sink;
  @override
  Sink get inputprofilePicture => _profilePictureController.sink;
  @override
  Sink get inputIsAllInputValid => _isALLInputValidStreamController.sink;

  //? register usecase
  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUsecase.execute(RegisterUsecaseInput(
            registerObject.name,
            registerObject.countryMobileCode,
            registerObject.mobileNumber,
            registerObject.email,
            registerObject.password,
            registerObject.profilePicture)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {
                  inputState.add(ContentState()),
                  isUserLoggedInSuccessfullyStreamController.add(true)
                });
  }

  //? OUTPUTS
  @override
  Stream<bool> get outputIsCountryMobileCodeValid =>
      _countryMobileCodeController.stream.map(
          (countryMobileCode) => _isCountryMobileCodeValid(countryMobileCode));
  @override
  Stream<String> get outputCountryMobileCodeValid => throw UnimplementedError();

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameController.stream.map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserNameValid => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid Username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputErrorEmailValid => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));
  @override
  Stream<String?> get outputErrorPasswordValid => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));
  @override
  Stream<String?> get outputErrorMobileNumberValid => outputIsMobileNumberValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<File?> get outputIsProfilePictureValid =>
      _profilePictureController.stream.map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isALLInputValidStreamController.stream.map((_) => _validateAllInputs());

  //? set value functions
  @override
  setCountryMobileCode(String countryMobileCode) {
    if (countryMobileCode.isNotEmpty) {
      // update register view object with countryCode value
      registerObject = registerObject.copyWith(
          countryMobileCode: countryMobileCode); // using data class like kotlin
    } else {
      // reset countryCode value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputemail.add(email);
    if (isEmailValid(email)) {
      // update register view object with email value
      registerObject =
          registerObject.copyWith(email: email); // using data class like kotlin
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputmobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerObject = registerObject.copyWith(
          mobileNumber: mobileNumber); // using data class like kotlin
    } else {
      // reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputpassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerObject = registerObject.copyWith(
          password: password); // using data class like kotlin
    } else {
      // reset password value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputprofilePicture.add(file);
    if (file.path.isNotEmpty) {
      // update register view object with profilePicture value
      registerObject = registerObject.copyWith(
          profilePicture: file.path); // using data class like kotlin
    } else {
      // reset profilePicture value in register view object
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setName(String name) {
    inputuserName.add(name);
    if (_isUserNameValid(name)) {
      // update register view object with username value
      registerObject =
          registerObject.copyWith(name: name); // using data class like kotlin
    } else {
      // reset username value in register view object
      registerObject = registerObject.copyWith(name: "");
    }
    _validate();
  }

  void _validate() {
    inputIsAllInputValid.add(null);
  }

//? validates
  bool _isCountryMobileCodeValid(String countryMobileCode) {
    return countryMobileCode.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.isNotEmpty;
  }

  bool _validateAllInputs() {
    return registerObject.profilePicture.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.name.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }
}

abstract class RegisterViewModelInputs {
  setName(String name);
  setCountryMobileCode(String countryMobileCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);
  register();
  Sink get inputcountryMobileCode;
  Sink get inputuserName;
  Sink get inputemail;
  Sink get inputpassword;
  Sink get inputmobileNumber;
  Sink get inputprofilePicture;
  Sink get inputIsAllInputValid;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsCountryMobileCodeValid;
  Stream<String> get outputCountryMobileCodeValid;
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserNameValid;
  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmailValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPasswordValid;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumberValid;
  Stream<File?> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputsValid;
}

/*
{
  "country_mobile_code": "+90",
  "user_name": "burahan",
  "email": "burahankrmz@gmail.com",
  "password" : "123456",
  "mobile_number" : "5425679672",
  "profile_picture" : ""
}
*/