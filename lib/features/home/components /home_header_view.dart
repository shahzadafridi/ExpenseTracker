import 'package:flutter/cupertino.dart';
import 'package:income_expense_tracker/features/home/components%20/header_summary_view.dart';
import 'package:income_expense_tracker/model/TransactionModel.dart';

import '../../../resources/assets_manager.dart';
import 'header_top_view.dart';

class HomeHeaderView extends StatelessWidget {
  final List<TransactionModel> transactions;

  const HomeHeaderView(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage(ImageAssets.cureHomeHeaderBg),
                width: double.infinity,
                height: 250.0,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: HeaderTopView(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                    child: HeaderSummaryView(transactions),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}