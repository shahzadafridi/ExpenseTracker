import 'package:flutter/cupertino.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class TransactionHeaderView extends StatelessWidget {
  const TransactionHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction History',
              style: getMediumStyle(color: ColorManager.black, fontSize: 18),
            ),
            Text('See All',
                style: getRegularStyle(
                    color: ColorManager.lightGrey, fontSize: 14))
          ],
        ));
  }
}