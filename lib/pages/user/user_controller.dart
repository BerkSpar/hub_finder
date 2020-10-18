import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/shared/models/organization.dart';
import 'package:github_finder/shared/models/repository.dart';
import 'package:github_finder/shared/models/user.dart';
import 'package:github_finder/shared/repositories/github_datasource.dart';
import 'package:mobx/mobx.dart';

part 'user_controller.g.dart';

class UserController = _UserControllerBase with _$UserController;

abstract class _UserControllerBase with Store {
  final datasource = GithubDataSource();

  @observable
  User user;

  @observable
  ObservableList<Organization> organizations = <Organization>[].asObservable();

  @observable
  ObservableList<Repository> repositories = <Repository>[].asObservable();

  @observable
  LoadState load = LoadState.loading;

  _UserControllerBase(String username) {
    _init(username);
  }

  _init(String username) async {
    try {
      user = await datasource.getUser(username);
      organizations = await datasource.getOrganizationsByUser(username);
      repositories = await datasource.getPublicRepositories(username);

      load = LoadState.loaded;
    } catch (e) {
      load = LoadState.error;
    }
  }
}
