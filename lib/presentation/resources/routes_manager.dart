import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/forgot_password/view/forgot_password_view.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/login/view/login_view.dart';
import 'package:flutteradvancedmvvm/presentation/authentication/register/view/register_view.dart';
import 'package:flutteradvancedmvvm/presentation/home/home.dart';
import 'package:flutteradvancedmvvm/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:flutteradvancedmvvm/presentation/splash/splash.dart';
import 'package:flutteradvancedmvvm/presentation/store_details/store_details.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String homeRoute = '/home';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
