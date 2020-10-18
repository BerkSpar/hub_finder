import 'package:dio/dio.dart';
import 'package:github_finder/shared/models/organization.dart';
import 'package:github_finder/shared/models/repository.dart';
import 'package:github_finder/shared/models/user.dart';
import 'package:mobx/mobx.dart';

class GithubDataSource {
  final Dio dio = Dio();

  GithubDataSource() {
    dio.options.baseUrl = 'https://api.github.com';
    dio.options.headers = {
      'Authorization': 'Basic YmVya3NwYXI6QmF6dWNhMDE=',
    };
  }

  Future<User> getUser(String username) async {
    try {
      final result = await dio.get('/users/$username');

      return User.fromJson(result.data);
    } catch (e) {
      throw Exception();
    }
  }

  Future<ObservableList<Organization>> getOrganizationsByUser(
    String username,
  ) async {
    try {
      final result = await dio.get('/users/$username/orgs');

      final list = <Organization>[].asObservable();

      result.data.forEach((e) {
        list.add(Organization.fromJson(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }

  Future<ObservableList<Repository>> getPublicRepositories(
    String username,
  ) async {
    try {
      final result = await dio.get('/users/$username/repos');

      final list = <Repository>[].asObservable();

      result.data.forEach((e) {
        list.add(Repository.fromJson(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }
}
