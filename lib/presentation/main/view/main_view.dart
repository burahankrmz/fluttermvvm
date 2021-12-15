import 'package:flutter/material.dart';

import 'package:flutteradvancedmvvm/presentation/main/home/view/home_view.dart';
import 'package:flutteradvancedmvvm/presentation/main/notifications/notifications_page.dart';
import 'package:flutteradvancedmvvm/presentation/main/search/search_page.dart';
import 'package:flutteradvancedmvvm/presentation/main/settings/settings_page.dart';
import 'package:flutteradvancedmvvm/presentation/resources/color_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/value_manager.dart';

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

  List<String> titles = const [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  String _title = AppStrings.home;
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                ),
                label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: AppStrings.settings),
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
