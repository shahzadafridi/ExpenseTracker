import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_expense_tracker/features/insert_expense_income/components/insert_header_view.dart';
import 'package:income_expense_tracker/resources/styles_manager.dart';
import 'package:provider/provider.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/values_manager.dart';
import '../common/components/base_safe_scaffold.dart';
import '../common/transaction_viewmodel.dart';
import 'components/insert_form_view.dart';

class InsertExpenseIncomeView extends StatelessWidget {
  const InsertExpenseIncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TransactionViewModel>();
    final categories = viewModel.categories;

    final GlobalKey<InsertFormViewState> formKey =
        GlobalKey<InsertFormViewState>();

    return BaseSafeScaffold(
      systemUiOverlayStyle: SystemUiOverlayStyle.light,
      background: const Image(
        image: AssetImage(ImageAssets.cureHomeHeaderBg),
        width: double.infinity,
        height: 250.0,
        fit: BoxFit.cover,
      ),
      body: Stack(
        children: [
          const InsertHeaderView(),
          Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 16, right: 16),
            child: InsertFormView(
              key: formKey,
              categories: categories,
            ),
          ),
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
                onPressed: () async {
                  final transaction = formKey.currentState?.getTransaction();

                  if (transaction != null) {
                    await viewModel.insertTransaction(transaction);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Transaction added successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please complete the form')),
                    );
                  }
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
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: AppSize.s16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
