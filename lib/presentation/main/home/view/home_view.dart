import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';
import 'package:flutteradvancedmvvm/presentation/main/home/viewmodel/home_viewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.home),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
