import 'package:flutter/cupertino.dart';
import 'package:income_expense_tracker/features/summary/components/summary_top_view.dart';
import '../../../resources/assets_manager.dart';

class SummaryHeaderView extends StatelessWidget {
  const SummaryHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 40),
            child: SummaryTopView(),
          ),
        ],
      ),
    );
  }
}
