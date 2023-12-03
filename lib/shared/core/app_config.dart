import 'dart:io';

class AppConfig {
  static String get storeUrl {
    if (Platform.isAndroid)
      return 'https://play.google.com/store/apps/details?id=tech.bunnie.hub_finder';

    if (Platform.isIOS)
      return 'https://apps.apple.com/br/app/hub-finder-for-github/id6473225993';

    return '';
  }
}
