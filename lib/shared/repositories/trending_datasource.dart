import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:hub_finder/shared/models/repository.dart';
import 'package:hub_finder/shared/models/user.dart';
import 'package:mobx/mobx.dart';

class TrendingDatasource {
  final Dio dio = Dio();

  TrendingDatasource() {
    dio.options.baseUrl = 'https://github.com';
  }

  int _parseNumber(String text) {
    final cleaned = text.trim().replaceAll(',', '');
    if (cleaned.isEmpty) return 0;
    return int.tryParse(cleaned) ?? 0;
  }

  Future<ObservableList<Repository>> getRepositories({
    String? spokenLanguage,
    String? language,
    String? since,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (spokenLanguage != null)
        queryParams['spoken_language_code'] = spokenLanguage;
      if (language != null) queryParams['language'] = language;
      if (since != null) queryParams['since'] = since;

      final result = await dio.get(
        '/trending',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final document = html_parser.parse(result.data);
      final list = <Repository>[].asObservable();

      final articles = document.querySelectorAll('.Box article.Box-row');

      for (var i = 0; i < articles.length; i++) {
        final element = articles[i];

        final nameElement = element.querySelector('h2 a');
        final fullName =
            nameElement?.text.trim().replaceAll(RegExp(r'\s+'), ' ') ?? '';
        final nameParts = fullName.split('/').map((e) => e.trim()).toList();
        final author = nameParts.isNotEmpty ? nameParts[0] : '';
        final name = nameParts.length > 1 ? nameParts[1] : fullName;

        final description = element.querySelector('p')?.text.trim() ?? '';
        final languageText = element
                .querySelector('[itemprop="programmingLanguage"]')
                ?.text
                .trim() ??
            '';

        final linkElements = element.querySelectorAll('a.Link--muted');
        var starsText = '';
        var forksText = '';

        for (final link in linkElements) {
          final href = link.attributes['href'] ?? '';
          if (href.contains('/stargazers')) {
            starsText = link.text.trim();
          } else if (href.contains('/forks')) {
            forksText = link.text.trim();
          }
        }

        final repo = Repository(
          rank: i + 1,
          name: name,
          fullName: '$author/$name',
          description: description,
          language: languageText.isEmpty ? null : languageText,
          stars: _parseNumber(starsText),
          forks: _parseNumber(forksText),
        );

        list.add(repo);
      }

      return list;
    } catch (e) {
      throw Exception('Error scraping GitHub Trending page: $e');
    }
  }

  Future<ObservableList<User>> getUsers({
    String? language,
    String? since,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (language != null) queryParams['language'] = language;
      if (since != null) queryParams['since'] = since;

      final result = await dio.get(
        '/trending/developers',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final document = html_parser.parse(result.data);
      final list = <User>[].asObservable();

      final articles = document.querySelectorAll('article.Box-row');

      for (final element in articles) {
        final avatarElement = element.querySelector('img.avatar-user');
        final avatarUrl = avatarElement?.attributes['src'] ?? '';

        final nameElement = element.querySelector('h1.h3 a');
        final name = nameElement?.text.trim() ?? '';

        final usernameElement = element.querySelector('p.f4 a');
        final login = usernameElement?.text.trim() ?? name;

        final userLinkElement = element.querySelector('div.mx-3 a');
        final href = userLinkElement?.attributes['href'] ?? '';
        final url = href.isNotEmpty ? 'https://github.com$href' : '';

        final repoDescElement =
            element.querySelector('article .f6.color-fg-muted.mt-1');
        final popularRepo = repoDescElement?.text.trim() ?? '';

        final user = User(
          login: login,
          name: name,
          avatarUrl: avatarUrl,
          url: url,
          bio: popularRepo,
        );

        list.add(user);
      }

      return list;
    } catch (e) {
      throw Exception('Error scraping GitHub Trending developers page: $e');
    }
  }
}
