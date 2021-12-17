import 'package:flutter/cupertino.dart';

import 'Dimensions.dart';

class AppDimension extends Dimensions {
  @override
  double get lightElevation => 4;

  @override
  double get mediumText => 16;

  @override
  double get listImageSize => 50;

  @override
  double get imageBorderRadius => 8;

  static AppDimension of(BuildContext context) {
    return AppDimension();
  }
}
