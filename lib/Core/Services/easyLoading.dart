
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Utils/AppColors.dart';

class ConfigLoading {
  void showLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..maskType = EasyLoadingMaskType.black
      ..textColor=AppColors.wightColor
      ..indicatorColor = AppColors.primaryColor
      ..userInteractions = true
      ..dismissOnTap = false
      ..backgroundColor=AppColors.wightColor;
  }
}