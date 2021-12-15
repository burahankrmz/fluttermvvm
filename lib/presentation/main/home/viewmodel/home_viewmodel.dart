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

  final StreamController _servicesStreamController =
      BehaviorSubject<List<Services>>();
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannersAd>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Stores>>();

  @override
  void start() {
    _getHome();
  }

  @override
  Sink get inputServices => _servicesStreamController.sink;
  @override
  Sink get inputBanners => _bannersStreamController.sink;
  @override
  Sink get inputStores => _storesStreamController.sink;

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    // ignore: void_checks
    return (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            },
        (homeObject) => {
              inputState.add(ContentState()),
              inputServices.add(homeObject.data.services),
              inputBanners.add(homeObject.data.bannersAd),
              inputStores.add(homeObject.data.stores)
            });
  }

  @override
  Stream<List<Services>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);
  @override
  Stream<List<BannersAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);
  @override
  Stream<List<Stores>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
  }
}

abstract class HomeViewModelInputs {
  Sink get inputServices;
  Sink get inputBanners;
  Sink get inputStores;
  //getHome();
}

abstract class HomeViewModelOutputs {
  Stream<List<Services>> get outputServices;
  Stream<List<BannersAd>> get outputBanners;
  Stream<List<Stores>> get outputStores;
}
