import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TextEditingController searchController = TextEditingController();
  final localStorage = LocalStorageService();

  AdWidget? adWidget;
  late BannerAd myBannerAd;
  @observable
  bool showBannerAd = false;

  @observable
  RewardedAd? myRewardedAd;

  @observable
  List<CachedUser> cachedUsers = <CachedUser>[];

  _HomeControllerBase() {
    _init();
    _loadBannerAd();
    _loadRewardedAd();
  }

  _init() async {
    Timer.periodic(Duration(seconds: 1), (_) async {
      cachedUsers = await localStorage.getCachedUsers();
    });
  }

  _loadRewardedAd() {
    if (!AppAd.showAd) return;

    RewardedAd.load(
      adUnitId: AppAd.getRewardedUnitId(
        'ca-app-pub-2005622694052245/8489869159',
      ),
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          myRewardedAd = ad;
        },
        onAdFailedToLoad: (_) {},
      ),
    );
  }

  Future onUserEarnedReward(ad, item) async {
    myRewardedAd = null;
    AppAd.showAd = false;
    await localStorage.saveRemoveAdDate();
  }

  _loadBannerAd() async {
    myBannerAd = BannerAd(
      adUnitId: AppAd.getBannerUnitId('ca-app-pub-2005622694052245/2018624292'),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );

    await myBannerAd.load();

    adWidget = AdWidget(ad: myBannerAd);

    showBannerAd = true;
  }
}
