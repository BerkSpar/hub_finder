import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/models/history_point.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/models/user_config.dart';
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
  List<CachedUser> cachedUsers = <CachedUser>[];

  @observable
  List<Repository> trendingRepositories = <Repository>[];

  @observable
  List<User> trendingUsers = <User>[];

  @observable
  int streak = 0;

  @observable
  bool isActiveStreak = false;

  final searchController = TextEditingController();

  @observable
  UserConfig config = UserConfig();

  _HomeControllerBase() {
    _loadBannerAd();
    _loadTrendingRepositories();
    _loadTrendingUsers();
    _loadCachedUsers();
    _loadStreak();
    _loadConfig();
  }

  _loadConfig() async {
    config = await localStorage.getConfig();
  }

  _loadStreak() async {
    streak = await localStorage.getStreak();

    final last = await localStorage.getLastHistoryPoint();
    if (last != null &&
        last.date.day == DateTime.now().day &&
        last.date.month == DateTime.now().month &&
        last.date.year == DateTime.now().year) {
      isActiveStreak = true;
    } else {
      isActiveStreak = false;
    }
  }

  _loadCachedUsers() async {
    cachedUsers = await localStorage.getCachedUsers();
    Timer.periodic(const Duration(seconds: 3), (_) async {
      cachedUsers = await localStorage.getCachedUsers();
    });
  }

  _loadTrendingRepositories() async {
    trendingRepositories = await trendingDatasource.getRepositories();
  }

  _loadTrendingUsers() async {
    trendingUsers = await trendingDatasource.getUsers();
  }

  _loadBannerAd() async {
    myBannerAd = BannerAd(
      adUnitId: AppAd.getBannerUnitId(
        'ca-app-pub-2005622694052245/2018624292',
        'ca-app-pub-2005622694052245/7399075880',
      ),
      size: AdSize.banner,
      request: const AdRequest(),
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

  Future<bool> hasHistoryPoint(DateTime date) async {
    final result = await localStorage.getHistoryPoint(date);

    return result != null;
  }

  void onTapStreak() async {
    final last = await localStorage.getLastHistoryPoint();

    if (last?.date.day == DateTime.now().day) {
      localStorage.removeHistoryPoint(HistoryPoint(
        date: DateTime.now(),
        value: 1,
      ));

      _loadStreak();
      return;
    }

    localStorage.addHistoryPoint(HistoryPoint(
      date: DateTime.now(),
      value: 1,
    ));

    HapticFeedback.heavyImpact();

    _loadStreak();
  }
}
