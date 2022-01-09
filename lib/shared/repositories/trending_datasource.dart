import 'package:dio/dio.dart';
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';

class TrendingDataSource {
  final Dio dio = Dio();

  TrendingDataSource() {
    dio.options.baseUrl = 'https://gh-trending-api.herokuapp.com';
  }

  Future<List<Repository>> getRepositories() async {
    try {
      final result = await dio.get('/repositories');

      final list = <Repository>[];

      result.data.forEach((e) async {
        list.add(Repository.fromTreding(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<User>> getUsers() async {
    try {
      final result = await dio.get('/developers');

      final list = <User>[];

      result.data.forEach((e) async {
        list.add(User.fromTreding(e));
      });

      return list;
    } catch (e) {
      throw Exception();
    }
  }
}
