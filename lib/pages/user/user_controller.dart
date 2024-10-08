import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/models/load_state.dart';
import 'package:hub_finder/shared/models/organization.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/repositories/github_datasource.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  final datasource = GithubDataSource();
  final localStorage = LocalStorageService();

  @observable
  User? user;

  @observable
  ObservableList<Organization> organizations = <Organization>[].asObservable();

  @observable
  ObservableList<Repository> repositories = <Repository>[].asObservable();

  @observable
  LoadState load = LoadState.loading;

  AdWidget? adWidget;
  late BannerAd myBanner;
  @observable
  bool showBannerAd = false;

  _UserControllerBase(String? username) {
    _init(username);
    _loadAd();
  }

  _init(String? username) async {
    try {
      user = await datasource.getUser(username);
      organizations = await datasource.getOrganizationsByUser(username);
      repositories = await datasource.getPublicRepositories(username);

      if (user != null) {
        _addCachedUser();
      }

      load = LoadState.loaded;
    } catch (e) {
      load = LoadState.error;
    }
  }

  _addCachedUser() {
    localStorage.addCachedUser(CachedUser(
      imageUrl: user!.avatarUrl,
      title: user!.name,
      subtitle: user!.location,
      username: user!.login,
    ));
  }

  _loadAd() async {
    myBanner = BannerAd(
      adUnitId: AppAd.getBannerUnitId(
        'ca-app-pub-2005622694052245/1183861251',
        'ca-app-pub-2005622694052245/6219486466',
      ),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          adWidget = AdWidget(ad: myBanner);
          showBannerAd = true;
        },
        onAdFailedToLoad: (_, error) {
          log('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    await myBanner.load();
  }
}
