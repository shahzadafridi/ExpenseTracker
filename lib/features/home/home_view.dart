import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_expense_tracker/features/common/components/base_safe_scaffold.dart';
import 'package:provider/provider.dart';
import '../../resources/assets_manager.dart';
import '../common/transaction_viewmodel.dart';
import 'components /home_header_view.dart';
import 'components /transaction_header_view.dart';
import '../common/components/transaction_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : transactions.isEmpty
                ? const Center(child: Text("No transactions found."))
                : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}