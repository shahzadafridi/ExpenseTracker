import 'package:flutter/cupertino.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class SummaryTransactionHeaderView extends StatelessWidget {
  const SummaryTransactionHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Spending',
              style: getMediumStyle(color: ColorManager.black, fontSize: 18),
            ),
            const Image(
              image: AssetImage(ImageAssets.transactionSortIcon),
              width: 21,
              height: 21,
            )
          ],
        ));
  }
}
