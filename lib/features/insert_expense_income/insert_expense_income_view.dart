import 'package:flutter/material.dart';
import 'package:income_expense_tracker/features/insert_expense_income/components/insert_header_view.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import 'components/insert_form_view.dart';
class InsertExpenseIncomeView extends StatelessWidget {
  const InsertExpenseIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Expense/Income'),
      ),
      body: Stack(
        children: [
          const InsertHeaderView(),
          const Padding(
            padding: EdgeInsets.only(top: 120.0, left: 16, right: 16),
            child: InsertFormView(),
          ),
          // Positioned button at the bottom
          Positioned(
            left: AppSize.s16,
            right: AppSize.s16,
            bottom: AppSize.s32,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: ColorManager.primaryGradient,
                borderRadius: BorderRadius.circular(AppSize.s40),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.homeRoute);
                },
                style: ElevatedButton.styleFrom(
                  elevation: AppSize.s4,
                  backgroundColor: ColorManager.primary,
                  shadowColor: ColorManager.primary,
                  padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s40),
                  ),
                ),
                child: Text(
                  AppStrings.insertButton,
                  style: getBoldStyle(color: ColorManager.white, fontSize: AppSize.s16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
