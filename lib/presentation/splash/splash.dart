import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/app_prefs.dart';
import '../../app/dependency_injection.dart';
import '../../core/assets/assets_manager.dart';
import '../../core/colors/color_manager.dart';
import '../../core/routes/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPrefences _appPrefences = instance<AppPrefences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPrefences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {Navigator.pushReplacementNamed(context, Routes.mainRoute)}
          else
            {
              _appPrefences
                  .isOnBoardingScreenViewed()
                  .then((isOnboardingScreenViewed) => {
                        if (isOnboardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }
}
