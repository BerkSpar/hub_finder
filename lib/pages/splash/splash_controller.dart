import 'package:hub_finder/shared/models/user_config.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';
part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  UserConfig config = UserConfig();
  LocalStorageService localStorageService = LocalStorageService();

  void init() async {
    config = await localStorageService.getConfig();
  }
}
