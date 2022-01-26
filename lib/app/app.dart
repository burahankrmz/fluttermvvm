import 'package:flutter/material.dart';
import 'app_prefs.dart';
import '../core/routes/routes_manager.dart';
import '../core/theme/theme_manager.dart';

import 'dependency_injection.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;

  static final MyApp instance =
      MyApp._internal(); // single instance --  singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefences _appPrefences = instance<AppPrefences>();

  @override
  void didChangeDependencies() {
    _appPrefences.getLocal().then((locale) => {
      context.setLocale(locale)
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
