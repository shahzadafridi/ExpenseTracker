import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/TransactionModel.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class HeaderSummaryView extends StatelessWidget {

  final List<TransactionModel> transactions;
  const HeaderSummaryView(this.transactions, {super.key});

  double _calculateTotalBalance() {
    return _calculateIncome() - _calculateExpense();
  }

  double _calculateIncome() {
    return transactions
        .where((t) => t.type == 1) // Assuming 1 = income
        .fold(0.0, (sum, t) => sum + (double.tryParse(t.amount) ?? 0.0));
  }

  double _calculateExpense() {
    return transactions
        .where((t) => t.type == 0) // Assuming 0 = expense
        .fold(0.0, (sum, t) => sum + (double.tryParse(t.amount) ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: ColorManager.primary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Balance',
                    style: getMediumStyle(color: ColorManager.white, fontSize: 16),
                  ),
                  Image.asset(
                    ImageAssets.menuIcon,
                    width: 21,
                    height: 5,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${_calculateTotalBalance().toStringAsFixed(2)}',
                style: getBoldStyle(color: ColorManager.white, fontSize: 30),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        ImageAssets.arrowUp,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Income',
                        style: getRegularStyle(
                            color: ColorManager.white, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ImageAssets.arrowDown,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Expense',
                        style: getRegularStyle(
                            color: ColorManager.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${_calculateIncome().toStringAsFixed(2)}',
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: 20),
                  ),
                  Text(
                    '\$${_calculateExpense().toStringAsFixed(2)}',
                    style: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: 20),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
