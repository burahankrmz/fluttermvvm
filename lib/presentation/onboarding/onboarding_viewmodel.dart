import 'dart:async';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/presentation/base/baseviewmodel.dart';
import 'package:flutteradvancedmvvm/presentation/resources/assets_manager.dart';
import 'package:flutteradvancedmvvm/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //? stream controllers
  final StreamController _streamController = BehaviorSubject<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //? inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //? send this slider data to our view
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //? infinite loop to go first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; //? infinite loop to go the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //? outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.asBroadcastStream().map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(
            AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1,
            ImageAssets.onboardingLogo1),
        SliderObject(
            AppStrings.onBoardingTitle2,
             AppStrings.onBoardingSubTitle2,
             ImageAssets.onboardingLogo2),
        SliderObject(
            AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3,
             ImageAssets.onboardingLogo3),
        SliderObject(
             AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4,
            ImageAssets.onboardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//! inputs mean the orders that our view model will recieve from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); //? when user clicks on right arrow or swipe
  void goPrevious(); //? when user click on left arrow or swipe
  void onPageChanged(int index); //? when page changed
  Sink get inputSliderViewObject;
}

//! outputs mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  //? will be implement it later
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
