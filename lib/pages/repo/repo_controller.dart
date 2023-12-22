import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/load_state.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/repositories/github_datasource.dart';
import 'package:mobx/mobx.dart';

part 'repo_controller.g.dart';

class RepoController = _RepoControllerBase with _$RepoController;

abstract class _RepoControllerBase with Store {
  final datasource = GithubDataSource();

  @observable
  Repository repository = Repository();

  @observable
  ObservableList<User> contributors = <User>[].asObservable();

  @observable
  LoadState load = LoadState.loading;

  AdWidget? adWidget;
  late BannerAd myBanner;
  @observable
  bool showBannerAd = false;

  _RepoControllerBase(String? fullName) {
    _init(fullName);
    _loadAd();
  }

  _init(String? fullName) async {
    try {
      repository = await datasource.getRepository(fullName);
      contributors = await datasource.getContributors(fullName);

      load = LoadState.loaded;
    } catch (e) {
      load = LoadState.error;
    }
  }

  _loadAd() async {
    myBanner = BannerAd(
      adUnitId: AppAd.getBannerUnitId(
        'ca-app-pub-2005622694052245/7359237423',
        'ca-app-pub-2005622694052245/8336476395',
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
