import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/repositories/github_datasource.dart';
import 'package:hub_finder/shared/repositories/trending_datasource.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final localStorage = LocalStorageService();
  final githubDatasource = GithubDataSource();
  final trendingDatasource = TrendingDatasource();

  AdWidget? adWidget;
  late BannerAd myBannerAd;
  @observable
  bool showBannerAd = false;

  @observable
  RewardedAd? myRewardedAd;

  @observable
  List<CachedUser> cachedUsers = <CachedUser>[];

  @observable
  List<Repository> trendingRepositories = <Repository>[];

  @observable
  List<User> trendingUsers = <User>[];

  final searchController = TextEditingController();

  _HomeControllerBase() {
    _loadBannerAd();
    _loadRewardedAd();
    _loadTredingRepositories();
    _loadTredingUsers();
    _loadCachedUsers();
  }

  _loadCachedUsers() async {
    cachedUsers = await localStorage.getCachedUsers();
    Timer.periodic(Duration(seconds: 3), (_) async {
      cachedUsers = await localStorage.getCachedUsers();
    });
  }

  _loadTredingRepositories() async {
    trendingRepositories = await trendingDatasource.getRepositories();
  }

  _loadTredingUsers() async {
    trendingUsers = await trendingDatasource.getUsers();
  }

  _loadRewardedAd() {
    if (!AppAd.showAd) return;
    if (!kReleaseMode) return;

    RewardedAd.load(
      adUnitId: AppAd.getRewardedUnitId(
        'ca-app-pub-2005622694052245/1931838279',
        'ca-app-pub-2005622694052245/1470835084',
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
      adUnitId: AppAd.getBannerUnitId(
        'ca-app-pub-2005622694052245/2018624292',
        'ca-app-pub-2005622694052245/1730689531',
      ),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          adWidget = AdWidget(ad: myBannerAd);
          showBannerAd = true;
        },
        onAdFailedToLoad: (_, error) {
          log('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    await myBannerAd.load();
  }
}
