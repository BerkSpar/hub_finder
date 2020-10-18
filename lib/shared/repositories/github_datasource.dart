import 'package:dio/dio.dart';
import 'package:github_finder/shared/models/user.dart';

class GithubDataSource {
  final Dio dio = Dio();

  GithubDataSource() {
    dio.options.baseUrl = 'https://api.github.com';
  }

  Future<User> getUser(String username) async {
    final result = await dio.get('/users/$username');

    return User.fromJson(result.data);
  }
}
