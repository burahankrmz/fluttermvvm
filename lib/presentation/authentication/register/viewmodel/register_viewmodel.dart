import 'dart:async';
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
      StreamController<String>.broadcast();
  final StreamController _isALLInputValidStreamController =
      StreamController<void>.broadcast();

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
            (data) => {inputState.add(ContentState())});
  }

  //? OUTPUTS
  @override
  Stream<bool> get outputIsCountryMobileCodeValid =>
      _countryMobileCodeController.stream.map(
          (countryMobileCode) => _isCountryMobileCodeValid(countryMobileCode));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameController.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<bool> get outputIsProfilePictureValid =>
      _profilePictureController.stream
          .map((profilePicture) => _isProfilePictureValid(profilePicture));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isALLInputValidStreamController.stream.map((_) => _isAllInputsValid());

  //? set value functions
  @override
  setName(String name) {
    inputuserName.add(name);
    registerObject = registerObject.copyWith(name: name);
    _validate();
  }

  @override
  setCountryMobileCode(String countryMobileCode) {
    inputcountryMobileCode.add(countryMobileCode);
    registerObject =
        registerObject.copyWith(countryMobileCode: countryMobileCode);

    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputmobileNumber.add(mobileNumber);
    registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    _validate();
  }

  @override
  setEmail(String email) {
    inputemail.add(email);
    registerObject = registerObject.copyWith(email: email);

    _validate();
  }

  @override
  setPassword(String password) {
    inputpassword.add(password);
    registerObject = registerObject.copyWith(password: password);

    _validate();
  }

  @override
  setProfilePicture(String profilePicture) {
    inputprofilePicture.add(profilePicture);
    registerObject = registerObject.copyWith(profilePicture: profilePicture);

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
    return userName.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.isNotEmpty;
  }

  bool _isProfilePictureValid(String profilePicture) {
    return profilePicture.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isUserNameValid(registerObject.name) &&
        _isCountryMobileCodeValid(registerObject.countryMobileCode) &&
        _isMobileNumberValid(registerObject.mobileNumber) &&
        _isEmailValid(registerObject.email) &&
        _isPasswordValid(registerObject.password) &&
        _isProfilePictureValid(registerObject.profilePicture);
  }
}

abstract class RegisterViewModelInputs {
  setName(String name);
  setCountryMobileCode(String countryMobileCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(String profilePicture);
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
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<bool> get outputIsProfilePictureValid;
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