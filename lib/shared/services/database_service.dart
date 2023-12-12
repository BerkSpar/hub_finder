import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/models/history_point.dart';
import 'package:hub_finder/shared/models/user_config.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  Completer<Box> cacheCompleter = Completer<Box>();
  Completer<Box> adsCompleter = Completer<Box>();
  Completer<Box> reviewCompleter = Completer<Box>();
  Completer<Box> configCompleter = Completer<Box>();
  Completer<Box> historyCompleter = Completer<Box>();

  LocalStorageService() {
    _init();
  }

  _init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    final cacheBox = await Hive.openBox('cache');
    if (!cacheCompleter.isCompleted) cacheCompleter.complete(cacheBox);

    final adsBox = await Hive.openBox('ads');
    if (!adsCompleter.isCompleted) adsCompleter.complete(adsBox);

    final reviewBox = await Hive.openBox('review');
    if (!reviewCompleter.isCompleted) reviewCompleter.complete(reviewBox);

    final configBox = await Hive.openBox('config');
    if (!configCompleter.isCompleted) configCompleter.complete(configBox);

    final historyBox = await Hive.openBox('history');
    if (!historyCompleter.isCompleted) historyCompleter.complete(historyBox);
  }

  Future<List<CachedUser>> getCachedUsers() async {
    final box = await cacheCompleter.future;

    List<CachedUser> list = box.values.isNotEmpty
        ? box.values.map((c) => CachedUser.fromMap(c)).toList()
        : [];

    return list;
  }

  Future<int> addCachedUser(CachedUser cachedUser) async {
    final box = await cacheCompleter.future;

    return await box.add(cachedUser.toMap());
  }

  Future saveRemoveAdDate() async {
    final box = await adsCompleter.future;

    box.put('remove_ad_date', DateTime.now().millisecondsSinceEpoch);
  }

  Future saveReviewDate() async {
    final box = await reviewCompleter.future;

    box.put('review_date', DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> showReview() async {
    final box = await reviewCompleter.future;

    final data = box.get('review_date');

    if (data == null) return true;

    return false;
  }

  Future<bool> showAds() async {
    final box = await adsCompleter.future;

    final data = box.get('remove_ad_date');

    if (data == null) return true;

    final removeAdDate = DateTime.fromMillisecondsSinceEpoch(data);

    if (DateTime.now().difference(removeAdDate).inHours >= 2) return true;

    return false;
  }

  Future<void> saveConfig(UserConfig config) async {
    final box = await configCompleter.future;

    return await box.put('config', config.toMap());
  }

  Future<UserConfig> getConfig() async {
    final box = await configCompleter.future;

    final data = box.get('config');

    if (data == null) return UserConfig();

    return UserConfig.fromMap(data);
  }

  Future<int> addHistoryPoint(HistoryPoint point) async {
    final box = await historyCompleter.future;

    return await box.add(point.toMap());
  }

  Future<List<HistoryPoint>> getHistoryPoints() async {
    final box = await historyCompleter.future;

    List<HistoryPoint> list = box.values.isNotEmpty
        ? box.values.map((c) => HistoryPoint.fromMap(c)).toList()
        : [];

    return list;
  }

  Future<HistoryPoint?> getLastHistoryPoint() async {
    final box = await historyCompleter.future;

    final data = box.values.isNotEmpty ? box.values.last : null;

    if (data == null) return null;

    return HistoryPoint.fromMap(data);
  }

  // Pega todos os pontos de histórico. Se não houver nenhum, retorna 0.
  // Conta quantos pontos de histórico existem em que os dias são consecutivos.
  // Se não houver pontos de histórico consecutivos, retorna 0.
  Future<int> getStreak() async {
    final box = await historyCompleter.future;

    final points = box.values.isNotEmpty
        ? box.values.map((c) => HistoryPoint.fromMap(c)).toList()
        : [];

    if (points.isEmpty) return 0;

    int streak = 0;

    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        streak++;
        continue;
      }

      final current = points[i];
      final previous = points[i - 1];

      final currentDay = DateTime(current.date.year, current.date.month,
          current.date.day, 0, 0, 0, 0, 0);
      final previousDay = DateTime(previous.date.year, previous.date.month,
          previous.date.day, 0, 0, 0, 0, 0);

      final difference = currentDay.difference(previousDay).inDays;

      if (difference == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }
}
