import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  _AppStoreBase._privateConstructor();
  final AppStore _instance = AppStore._privateConstructor();
  AppStore get instance => _instance;

  @observable
  bool showAd = true;
}
