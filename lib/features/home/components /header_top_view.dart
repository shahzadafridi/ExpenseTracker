import 'package:flutter/cupertino.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';

class HeaderTopView extends StatelessWidget {
  const HeaderTopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good afternoon,',
              style: getMediumStyle(color: ColorManager.white, fontSize: 12),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Enjelin Morgeana',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 20),
            ),
          ],
        ),
        ImageIcon(
          const AssetImage(ImageAssets.notification),
          color: ColorManager.white,
          size: 40.0,
        ),
      ],
    );
  }
}
