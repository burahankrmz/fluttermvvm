import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';
import 'package:flutteradvancedmvvm/presentation/main/home/viewmodel/home_viewmodel.dart';

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
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          debugPrint(snapshot.data?.toString());
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              Container();
        });
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
