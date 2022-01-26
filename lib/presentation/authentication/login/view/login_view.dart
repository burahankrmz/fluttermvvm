import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../../app/app_prefs.dart';
import '../../../../app/dependency_injection.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../../common/state_renderer_impl.dart';
import '../../../../core/assets/assets_manager.dart';
import '../../../../core/colors/color_manager.dart';
import '../../../../core/routes/routes_manager.dart';
import '../../../../core/constants/strings_manager.dart';
import '../../../../core/styles/styles_manager.dart';
import '../../../../core/constants/value_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPrefences _appPrefences = instance<AppPrefences>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLoggedIn) {
      _appPrefences.setIsUserLoggedIn();
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildSplashLogo(),
              const SizedBox(
                height: AppSize.s28,
              ),
              _buildUsernameTextfield(),
              const SizedBox(
                height: AppSize.s28,
              ),
              _buildPasswordTextField(),
              const SizedBox(
                height: AppSize.s28,
              ),
              _buildLoginBtn(),
              _buildForgetandSignUpTextbtn()
            ],
          ),
        ),
      ),
    );
  }

  FadeInDown _buildForgetandSignUpTextbtn() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p8,
          left: AppPadding.p28,
          right: AppPadding.p28,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildForgetTextBtn(),
            _buildSignUpTextBtn(),
          ],
        ),
      ),
    );
  }

  TextButton _buildSignUpTextBtn() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.registerRoute);
      },
      child: Text(AppStrings.registerText.tr(),
          style: Theme.of(context).textTheme.subtitle2),
    );
  }

  TextButton _buildForgetTextBtn() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.forgotPasswordRoute);
      },
      child: Text(AppStrings.forgetPassword.tr(),
          style: Theme.of(context).textTheme.subtitle2),
    );
  }

  FadeInDown _buildLoginBtn() {
    return FadeInDown(
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
        child: StreamBuilder<bool>(
          stream: _viewModel.outputIsAllInputsValid,
          builder: (context, snapshot) {
            return SizedBox(
              width: double.infinity,
              height: AppSize.s40,
              child: ElevatedButton(
                onPressed: (snapshot.data ?? false)
                    ? () {
                        _viewModel.login();
                      }
                    : null,
                child: Text(
                  AppStrings.login.tr(),
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInDown _buildPasswordTextField() {
    return FadeInDown(
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
        child: StreamBuilder<bool>(
          stream: _viewModel.outputIsPasswordValid,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _userPasswordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: AppStrings.password.tr(),
                labelText: AppStrings.password.tr(),
                errorText:
                    (snapshot.data ?? true) ? null : AppStrings.passwordError.tr(),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInDown _buildUsernameTextfield() {
    return FadeInDown(
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
        child: StreamBuilder<bool>(
          stream: _viewModel.outputIsUserNameValid,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _userNameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: AppStrings.username.tr(),
                labelText: AppStrings.username.tr(),
                errorText:
                    (snapshot.data ?? true) ? null : AppStrings.usernameError.tr(),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInDown _buildSplashLogo() {
    return FadeInDown(
        child: const Image(image: AssetImage(ImageAssets.splashLogo)));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _userNameController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }
}
