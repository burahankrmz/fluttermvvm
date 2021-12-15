import 'dart:async';
import 'dart:ffi';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/domain/usecase/home_usecase.dart';
import 'package:flutteradvancedmvvm/presentation/base/baseviewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer.dart';
import 'package:flutteradvancedmvvm/presentation/common/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  @override
  void start() {
    _getHome();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    // ignore: void_checks
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.bannersAd));
    });
  }

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);

  @override
  void dispose() {
    _dataStreamController.close();
  }
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
  //getHome();
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Stores> stores;
  List<Services> services;
  List<BannersAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
