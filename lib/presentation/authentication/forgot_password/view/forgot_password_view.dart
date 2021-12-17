import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';
import 'package:flutteradvancedmvvm/presentation/resources/assets_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/color_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/styles_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/value_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.forgotPassword();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      color: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _getplashLogo(),
                const SizedBox(
                  height: AppSize.s28,
                ),
                _getUsernameTextfield(),
                const SizedBox(
                  height: AppSize.s28,
                ),
                _getResetPasswordBtn(),
                const SizedBox(
                  height: AppSize.s14,
                ),
                _getDidntReceiverMailTextBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getplashLogo() {
    return FadeInDown(
        child: const Image(image: AssetImage(ImageAssets.splashLogo)));
  }

  Widget _getUsernameTextfield() {
    return FadeInDown(
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
        child: StreamBuilder<bool>(
            stream: _viewModel.outputEmailIsValid,
            builder: (context, snapshot) {
              return TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: AppStrings.emailHint.tr(),
                  labelText: AppStrings.emailHint.tr(),
                  errorText:
                      (snapshot.data ?? true) ? null : AppStrings.invalidEmail.tr(),
                ),
              );
            }),
      ),
    );
  }

  Widget _getResetPasswordBtn() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: SizedBox(
          width: double.infinity,
          child: StreamBuilder<bool>(
              stream: _viewModel.outputEmailIsValid,
              builder: (context, snapshot) {
                return ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                          _viewModel.forgotPassword().tr();
                        }
                      : null,
                  child: Text(
                    AppStrings.resetPassword.tr(),
                    style: getRegularStyle(color: ColorManager.white),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _getDidntReceiverMailTextBtn() {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
        child: TextButton(
          onPressed: () {
            _viewModel.forgotPassword();
          },
          child:  Text(AppStrings.didntReceiveMailTextBtn.tr()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
