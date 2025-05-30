import 'dart:async';
import '../../model/sliderobject.dart';
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
  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();

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
      _list[_currentPageIndex],
      _currentPageIndex,
      _list.length,
    );
    inputSliderViewObject.add(sliderViewObject);
  }

  List<SliderObject> _getSliderData() => [
    SliderObject(
      AppStrings.onBoardingTitle1.tr(),
      AppStrings.onBoardingSubTitle1.tr(),
      ImageAssets.onBoardingLogo1,
    ),
    SliderObject(
      AppStrings.onBoardingTitle2.tr(),
      AppStrings.onBoardingSubTitle2.tr(),
      ImageAssets.onBoardingLogo2,
    ),
    SliderObject(
      AppStrings.onBoardingTitle3.tr(),
      AppStrings.onBoardingSubTitle3.tr(),
      ImageAssets.onBoardingLogo3,
    ),
    SliderObject(
      AppStrings.onBoardingTitle4.tr(),
      AppStrings.onBoardingSubTitle4.tr(),
      ImageAssets.onBoardingLogo4,
    ),
  ];
}