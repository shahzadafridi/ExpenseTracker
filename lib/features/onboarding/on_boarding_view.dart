import 'package:income_expense_tracker/resources/font_manager.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';

import '../../../app/app_preferences.dart';
import '../../../app/di.dart';
import '../../model/sliderobject.dart';
import 'onboarding_viewmodel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _controller;

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  final AppsPreferences _appsPreferences = instance<AppsPreferences>();

  _build() {
    _appsPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _build();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) return Container();

    return Scaffold(
        backgroundColor: ColorManager.white,
        body: PageView.builder(
          controller: _controller,
          itemCount: sliderViewObject.numberOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (_, index) =>
              OnBoardingPage(sliderViewObject.sliderObject),
        ));
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;

  const OnBoardingPage(this.sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            SizedBox(
              width: double.infinity,
              height: AppSize.s500,
              child: Image(
                image: AssetImage(sliderObject.background),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.s140),
              child: Image(
                  image: AssetImage(sliderObject.image),
                  width: double.infinity,
                  height: AppSize.s361),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s32),
          child: Text(
            AppStrings.onBoardingTitle1,
            style: getBoldStyle(
                color: ColorManager.primary, fontSize: FontSize.s34),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: AppSize.s32, right: AppSize.s32, top: AppSize.s8),
          child: Container(
            width: double.infinity, // or your desired width
            decoration: BoxDecoration(
              gradient: ColorManager.primaryGradient,
              borderRadius: BorderRadius.circular(AppSize.s40),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.homeRoute);
              },
              style: ElevatedButton.styleFrom(
                elevation: AppSize.s8,
                padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s40),
                ),
              ),
              child: const Text(
                AppStrings.onBoardingButton,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
