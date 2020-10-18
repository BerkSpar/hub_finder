import 'package:github_finder/shared/models/user.dart';
import 'package:github_finder/shared/repositories/github_datasource.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

enum LoadState { loaded, loading, error }

abstract class _UserControllerBase with Store {
  final datasource = GithubDataSource();

  @observable
  User user;

  @observable
  LoadState load = LoadState.loading;

  _UserControllerBase(String username) {
    _init(username);
  }

  _init(String username) async {
    try {
      user = await datasource.getUser(username);

      load = LoadState.loaded;
    } catch (e) {
      load = LoadState.error;
    }
  }
}
