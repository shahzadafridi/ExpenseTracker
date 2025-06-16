import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_expense_tracker/features/common/components/base_safe_scaffold.dart';
import '../../model/TransactionModel.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/assets_manager.dart';
import '../../utils/dummy_data.dart';
import 'components /home_header_view.dart';
import 'components /transaction_header_view.dart';
import '../common/components/transaction_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSafeScaffold(
        systemUiOverlayStyle: SystemUiOverlayStyle.light,
        background: const Image(
          image: AssetImage(ImageAssets.cureHomeHeaderBg),
          width: double.infinity,
          height: 250.0,
          fit: BoxFit.cover,
        ),
        body: Column(
          children: [
            const HomeHeaderView(),
            const TransactionHeaderView(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (context, index) {
                  return TransactionItem(transaction: transactionList[index]);
                },
              ),
            ),
          ],
        ));
  }
}
