import 'package:github_finder/shared/models/load_state.dart';
import 'package:github_finder/shared/models/organization.dart';
import 'package:github_finder/shared/models/user.dart';
import 'package:github_finder/shared/repositories/github_datasource.dart';
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

  _OrganizationControllerBase(String? organization) {
    _init(organization);
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
}
