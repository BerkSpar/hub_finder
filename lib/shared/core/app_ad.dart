import 'package:flutter/foundation.dart';

class AppAd {
  static bool showAd = true;

  static String getBannerUnitId(String androidId, String iosId) {
    if (!kReleaseMode) return 'ca-app-pub-3940256099942544/6300978111';
    return defaultTargetPlatform == TargetPlatform.android ? androidId : iosId;
  }

  static String getRewardedUnitId(String androidId, String iosId) {
    if (!kReleaseMode) return 'ca-app-pub-3940256099942544/5224354917';
    return defaultTargetPlatform == TargetPlatform.android ? androidId : iosId;
  }
}
