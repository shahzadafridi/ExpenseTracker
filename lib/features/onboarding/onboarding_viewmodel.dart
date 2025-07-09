import 'dart:async';
import '../../model/SliderObjectModel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class OnBoardingViewModelBase {
  void dispose();

  void start();

  int goNext();

  int goPrevious();

  void onPageChanged(int index);

  Sink get inputSliderViewObject;

  Stream<SliderViewObject> get outputSliderViewObject;
}

class OnBoardingViewModel extends OnBoardingViewModelBase {
  final StreamController<SliderViewObject> _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    _currentPageIndex++;
    if (_currentPageIndex >= _list.length) {
      _currentPageIndex = 0;
    }
    _postDataToView();
    return _currentPageIndex;
  }

  @override
  int goPrevious() {
    _currentPageIndex--;
    if (_currentPageIndex < 0) {
      _currentPageIndex = _list.length - 1;
    }
    _postDataToView();
    return _currentPageIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentPageIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream;

  void _postDataToView() {
    final sliderViewObject = SliderViewObject(
        _list[_currentPageIndex], _list.length, _currentPageIndex);

    inputSliderViewObject.add(sliderViewObject);
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
            "Spend Smarter Save More",
            ImageAssets.onBoardingBackground1,
            ImageAssets.onBoardingLogo1
        ),
        SliderObject(
            "Where does it come from",
            ImageAssets.onBoardingBackground1,
            ImageAssets.onBoardingLogo2
        )
      ];
}
