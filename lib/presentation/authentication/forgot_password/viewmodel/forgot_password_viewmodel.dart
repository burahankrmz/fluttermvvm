import 'dart:async';
import 'package:flutteradvancedmvvm/domain/usecase/forgotpassword_usecase.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/forgot_password/freezedmodel/forgotpassword_freezed_data.dart';
import 'package:flutteradvancedmvvm/presentation/base/baseviewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isALLInputsValidStreamController =
      StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var forgotPasswordObject = ForgotPasswordObject("");

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotPasswordUseCase
            .execute(ForgotPasswordInputUsecase(forgotPasswordObject.email)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message)),
                },
            (data) => {
                  inputState.add(
                    ContentState(),
                  ),
                });
  }

  @override
  Stream<bool> get outputEmailIsValid =>
      _emailStreamController.stream.map((email) => _isEmailValidate(email));

  @override
  void dispose() {
    _emailStreamController;
    _isALLInputsValidStreamController.close();
  }

  //? functions
  @override
  setEmail(String email) {
    inputEmail.add(email);
    forgotPasswordObject = forgotPasswordObject.copyWith(email: email);
    _isEmailValidate(forgotPasswordObject.email);
  }

  bool _isEmailValidate(String email) {
    return email.isNotEmpty;
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  Sink get inputEmail;
  forgotPassword();
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputEmailIsValid;
}
