import 'package:income_expense_tracker/features/home/home_botttom_bar_view.dart';

import '../../app/di.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:income_expense_tracker/resources/string_manager.dart';
import '../features/onboarding/on_boarding_view.dart';
import '../features/splash/splash_view.dart';


class Routes {
  static const String splashRoute = "/";
  static const String onBpardingRoute = "onBparding";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBpardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeBotttomBarView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRouteFound.tr())),
        body: Center(
          child: Text(AppStrings.noRouteFound.tr()),
        ),
      ),
    );
  }
}