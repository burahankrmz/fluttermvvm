import 'package:flutter/material.dart';
import '../../../core/colors/color_manager.dart';
import '../../../core/constants/strings_manager.dart';
import '../../../core/constants/value_manager.dart';

import '../home/view/home_view.dart';
import '../notifications/notifications_page.dart';
import '../search/search_page.dart';
import '../settings/view/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePageView(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage()
  ];

  List<String> titles =  [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  String _title = AppStrings.home.tr();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTap,
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.search,
                ),
                label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.notifications,
                ),
                label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                ),
                label: AppStrings.settings.tr()),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
