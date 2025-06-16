import 'package:flutter/material.dart';
import 'package:income_expense_tracker/features/summary/components/summary_top_view.dart';
import '../../utils/dummy_data.dart';
import '../common/components/transaction_item.dart';
import 'components/summary_custom_tab.dart';
import 'components/summary_transaction_header_view.dart';

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryTabViewScreenState();
}

class _SummaryTabViewScreenState extends State<SummaryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SummaryTopView(),
            ),
            const SizedBox(height: 32),
            const SummaryCustomTab(),
            const SizedBox(height: 16),
            const SummaryTransactionHeaderView(),
            const SizedBox(height: 16),
            ...transactionList.map((transaction) {
              return TransactionItem(transaction: transaction);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
