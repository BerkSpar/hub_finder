import 'package:flutter/foundation.dart';

class AppAd {
  static String getBannerUnitId(String unitId) {
    if (!kReleaseMode) return 'ca-app-pub-3940256099942544/6300978111';
    return unitId;
  }

  static String getRewardedUnitId(String unitId) {
    if (!kReleaseMode) return 'ca-app-pub-3940256099942544/5224354917';
    return unitId;
  }
}
