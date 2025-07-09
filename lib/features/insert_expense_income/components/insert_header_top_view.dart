import 'package:flutter/cupertino.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class InsertHeaderTopView extends StatelessWidget {
  const InsertHeaderTopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Insert Transaction',
        style: getBoldStyle(color: ColorManager.white, fontSize: 20),
      ),
    );
  }
}
