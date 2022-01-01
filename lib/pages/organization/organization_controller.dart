import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/models/load_state.dart';
import 'package:hub_finder/shared/models/organization.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:hub_finder/shared/repositories/github_datasource.dart';
import 'package:mobx/mobx.dart';

part 'organization_controller.g.dart';

class OrganizationController = _OrganizationControllerBase
    with _$OrganizationController;

abstract class _OrganizationControllerBase with Store {
  final datasource = GithubDataSource();

  @observable
  Organization organization = Organization();

  @observable
  ObservableList<User> members = <User>[].asObservable();

  @observable
  LoadState load = LoadState.loading;

  AdWidget? adWidget;
  late BannerAd myBanner;
  @observable
  bool showBannerAd = false;

  _OrganizationControllerBase(String? organization) {
    _init(organization);
    _loadAd();
  }

  _init(String? name) async {
    try {
      organization = await datasource.getOrganization(name);
      members = await datasource.getMembersByOrganization(name);

      load = LoadState.loaded;
    } catch (e) {
      load = LoadState.error;
    }
  }

  _loadAd() async {
    myBanner = BannerAd(
      adUnitId: AppAd.getBannerUnitId('ca-app-pub-2005622694052245/4740990550'),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );

    await myBanner.load();

    adWidget = AdWidget(ad: myBanner);

    showBannerAd = true;
  }
}
