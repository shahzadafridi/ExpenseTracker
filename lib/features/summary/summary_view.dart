import 'package:flutter/material.dart';
import 'package:income_expense_tracker/features/summary/components/summary_top_view.dart';
import 'components/summary_custom_tab.dart';

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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            SummaryTopView(),
            SizedBox(height: 32),
            SummaryCustomTab(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
