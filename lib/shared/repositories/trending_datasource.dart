import 'package:dio/dio.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:mobx/mobx.dart';

class TrendingDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.gitterapp.com",
    ),
  );

  Future<ObservableList<Repository>> getRepositories() async {
    try {
      final result = await dio.get('/repositories');

      final list = <Repository>[].asObservable();

      result.data.forEach((e) {
        list.add(Repository.fromTrending(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }

  Future<ObservableList<User>> getUsers() async {
    try {
      final result = await dio.get('/developers');

      final list = <User>[].asObservable();

      result.data.forEach((e) {
        list.add(User.fromTrending(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }
}
