import 'package:flutter/cupertino.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class SummaryTopView extends StatelessWidget {
  const SummaryTopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageIcon(
          const AssetImage(ImageAssets.arrowBack),
          color: ColorManager.black,
          size: 28.0,
        ),
        Text(
          'Statistics',
          style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        ImageIcon(
          const AssetImage(ImageAssets.download),
          color: ColorManager.black,
          size: 28.0,
        ),
      ],
    );
  }
}
