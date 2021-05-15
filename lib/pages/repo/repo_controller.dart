import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/shared/models/repository.dart';
import 'package:github_finder/shared/models/user.dart';
import 'package:github_finder/shared/repositories/github_datasource.dart';
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

  _RepoControllerBase(String? fullName) {
    _init(fullName);
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
}
