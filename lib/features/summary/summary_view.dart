import 'package:flutter/material.dart';
import 'package:income_expense_tracker/features/summary/components/summary_header_view.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: const Column(
        children: [SummaryHeaderView()],
      ),
    );
  }
}
