import 'package:flutter/material.dart';
import 'package:income_expense_tracker/resources/color_manager.dart';
import 'package:income_expense_tracker/resources/string_manager.dart';

import '../insert_expense_income/insert_expense_income_view.dart';
import '../summary/summary_view.dart';
import 'home_view.dart';

class HomeBotttomBarView extends StatefulWidget {
  const HomeBotttomBarView({super.key});

  @override
  State<HomeBotttomBarView> createState() => _HomeBotttomBarViewState();
}

class _HomeBotttomBarViewState extends State<HomeBotttomBarView> {
  int currentIndex = 0;
  final List<Widget> _screens = const [
    HomeView(),
    InsertExpenseIncomeView(),
    SummaryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: _screens[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.lightGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.bottom_tab_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: AppStrings.bottom_tab_insert,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: AppStrings.bottom_tab_summary,
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
