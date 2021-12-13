import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/register/viewmodel/register_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';
import 'package:flutteradvancedmvvm/presentation/resources/assets_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/color_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/routes_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/styles_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/value_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryMobileCodeController =
      TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();

  _bind() {
    _viewModel.start();
    _nameController.addListener(() {
      _viewModel.setName(_nameController.text);
    });

    _countryMobileCodeController.addListener(() {
      _viewModel.setCountryMobileCode(_countryMobileCodeController.text);
    });
    _countryMobileCodeController.text = '+90';
    _mobilePhoneController.addListener(() {
      _viewModel.setMobileNumber(_mobilePhoneController.text);
    });
    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });
    _profilePictureController.addListener(() {
      _viewModel.setProfilePicture(_profilePictureController.text);
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
                  _viewModel.register();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Container _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p50),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Form(
            child: Column(
              children: <Widget>[
                _buildSplashLogo(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildNameTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildCountryCodeTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildMobileNumberTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildEmailTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildPasswordTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildProfilePictureTextfield(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildRegisterBtn(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _buildAlreadyHaveAccountTextBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  FadeInDown _buildAlreadyHaveAccountTextBtn() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p28,
            right: AppPadding.p28,
            bottom: AppPadding.p12),
        child: TextButton(
          child: const Text(AppStrings.alreadyHaveAccountTxtBtn),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          },
        ),
      ),
    );
  }

  FadeInDown _buildRegisterBtn() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p28,
            right: AppPadding.p28,
            bottom: AppPadding.p12),
        child: StreamBuilder<bool>(
          stream: _viewModel.outputIsAllInputsValid,
          builder: (context, snapshot) {
            return SizedBox(
              width: double.infinity,
              height: AppSize.s40,
              child: ElevatedButton(
                onPressed: (snapshot.data ?? false)
                    ? () {
                        _viewModel.register();
                      }
                    : null,
                child: Text(
                  AppStrings.registerBtn,
                  style: getRegularStyle(color: ColorManager.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FadeInDown _buildProfilePictureTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsProfilePictureValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _profilePictureController,
                decoration: InputDecoration(
                  hintText: AppStrings.profilPicture,
                  labelText: AppStrings.profilPicture,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.profilPictureError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildPasswordTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsPasswordValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: AppStrings.password,
                  labelText: AppStrings.password,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.passwordError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildEmailTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsEmailValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: AppStrings.email,
                  labelText: AppStrings.email,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.emailError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildMobileNumberTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsMobileNumberValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _mobilePhoneController,
                decoration: InputDecoration(
                  hintText: AppStrings.mobileNumber,
                  labelText: AppStrings.mobileNumber,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.mobileNumberError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildCountryCodeTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsCountryMobileCodeValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _countryMobileCodeController,
                decoration: InputDecoration(
                  hintText: AppStrings.countryCode,
                  labelText: AppStrings.countryCode,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.countryCodeError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildNameTextfield() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputIsUserNameValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: AppStrings.name,
                  labelText: AppStrings.name,
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.nameError,
                ),
              );
            }),
      ),
    );
  }

  FadeInDown _buildSplashLogo() {
    return FadeInDown(
        child: const Image(image: AssetImage(ImageAssets.splashLogo)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryMobileCodeController.dispose();
    _mobilePhoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _profilePictureController.dispose();
    super.dispose();
  }
}
