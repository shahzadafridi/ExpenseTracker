import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_expense_tracker/features/common/components/base_safe_scaffold.dart';
import 'package:income_expense_tracker/features/summary/components/summary_top_view.dart';
import 'package:provider/provider.dart';
import '../common/components/transaction_item.dart';
import '../common/transaction_viewmodel.dart';
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

    final viewModel = context.watch<TransactionViewModel>();
    final transactions = viewModel.transactions;
    final isLoading = viewModel.isLoading;

    // Fetch latest transactions AFTER build (only once per push)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionViewModel>().fetchTransactions();
    });


    return BaseSafeScaffold(
      systemUiOverlayStyle: SystemUiOverlayStyle.dark,
      background: const SizedBox(),
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
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (transactions.isEmpty)
              const Center(child: Text("No transactions found."))
            else
              ...transactions.map((transaction) {
                return TransactionItem(transaction: transaction);
              }).toList(),
          ],
        ),
      ),
    );
  }
}
