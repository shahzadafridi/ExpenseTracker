import 'package:flutter/cupertino.dart';
import 'package:income_expense_tracker/features/insert_expense_income/components/insert_header_top_view.dart';
import '../../../resources/assets_manager.dart';

class InsertHeaderView extends StatelessWidget {
  const InsertHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                child: Image(
                  image: AssetImage(ImageAssets.cureHomeHeaderBg),
                  width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                    child: InsertHeaderTopView(),
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
