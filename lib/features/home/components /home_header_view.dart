import 'package:flutter/cupertino.dart';
import 'package:income_expense_tracker/features/home/components%20/header_summary_view.dart';

import '../../../resources/assets_manager.dart';
import 'header_top_view.dart';

class HomeHeaderView extends StatelessWidget {
  const HomeHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage(ImageAssets.cureHomeHeaderBg),
                width: double.infinity,
                height: 250.0,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: HeaderTopView(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: HeaderSummaryView(),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
