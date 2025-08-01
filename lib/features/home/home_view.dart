import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_expense_tracker/features/common/components/base_safe_scaffold.dart';
import 'package:provider/provider.dart';
import '../../resources/assets_manager.dart';
import '../main/main_viewmodel.dart';
import 'components /home_header_view.dart';
import 'components /transaction_header_view.dart';
import '../common/components/transaction_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isFetched) {
      _isFetched = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MainViewModel>().fetchTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final transactions = viewModel.transactions;
    final isLoading = viewModel.isLoading;

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
          HomeHeaderView(transactions),
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