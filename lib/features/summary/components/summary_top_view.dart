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
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Summary',
        style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18),
      ),
    );
  }
}
