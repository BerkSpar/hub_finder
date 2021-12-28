import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_core.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TextEditingController searchController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();

  AdWidget adWidget;
  BannerAd myBanner;
  @observable
  bool showAd = false;

  @observable
  List<CachedUser> cachedUsers = <CachedUser>[];

  _HomeControllerBase() {
    _init();
    _loadAd();
  }

  _init() async {
    Timer.periodic(Duration(seconds: 1), (_) async {
      cachedUsers = await databaseService.getCachedUsers();
    });
  }

  _loadAd() async {
    myBanner = BannerAd(
      adUnitId: AppAd.getBannerUnitId('ca-app-pub-2005622694052245/2018624292'),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );

    await myBanner.load();

    adWidget = AdWidget(ad: myBanner);

    showAd = true;
  }
}
