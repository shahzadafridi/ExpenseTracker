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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageIcon(
          const AssetImage(ImageAssets.arrowBack),
          color: ColorManager.white,
          size: 28.0,
        ),
        Text(
          'Insert Transaction',
          style: getSemiBoldStyle(color: ColorManager.white, fontSize: 18),
        ),
        const SizedBox(
          width: 28.0,
          height: 28.0,
        ),
      ],
    );
  }
}
