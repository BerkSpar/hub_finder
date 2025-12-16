import 'dart:async';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/models/focus_session.dart';
import 'package:hub_finder/shared/models/focus_type.dart';
import 'package:hub_finder/shared/models/history_point.dart';
import 'package:hub_finder/shared/models/user_config.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  Completer<Box> cacheCompleter = Completer<Box>();
  Completer<Box> adsCompleter = Completer<Box>();
  Completer<Box> reviewCompleter = Completer<Box>();
  Completer<Box> configCompleter = Completer<Box>();
  Completer<Box> historyCompleter = Completer<Box>();
  Completer<Box> focusCompleter = Completer<Box>();

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

    final focusBox = await Hive.openBox('focus_sessions');
    if (!focusCompleter.isCompleted) focusCompleter.complete(focusBox);
  }

  Future<List<CachedUser>> getCachedUsers() async {
    final box = await cacheCompleter.future;

    List<CachedUser> list = box.values.isNotEmpty
        ? box.values.map((c) => CachedUser.fromMap(c)).toList()
        : [];

    list = list.reversed.toList();
    if (list.length > 5) {
      list = list.sublist(0, 5);
    }

    return list;
  }

  Future<void> addCachedUser(CachedUser cachedUser) async {
    final box = await cacheCompleter.future;

    return await box.put(cachedUser.username, cachedUser.toMap());
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

    await box.put('config', config.toMap());

    log('Saved config: ${config.toMap()}');
  }

  Future<UserConfig> getConfig() async {
    final box = await configCompleter.future;

    final data = box.get('config');

    if (data == null) return UserConfig();

    return UserConfig.fromMap(data);
  }

  Future<HistoryPoint?> getHistoryPoint(DateTime date) async {
    final box = await historyCompleter.future;

    final data = box.get("${date.year}-${date.month}-${date.day}");

    if (data == null) return null;

    return HistoryPoint.fromMap(data);
  }

  Future<void> addHistoryPoint(HistoryPoint point) async {
    final box = await historyCompleter.future;

    await box.put("${point.date.year}-${point.date.month}-${point.date.day}",
        point.toMap());
  }

  Future<void> removeHistoryPoint(HistoryPoint point) async {
    final box = await historyCompleter.future;

    await box
        .delete("${point.date.year}-${point.date.month}-${point.date.day}");
  }

  Future<void> clearHistoryPoints() async {
    final box = await historyCompleter.future;

    await box.clear();
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
  // Utiliza a data atual para verificar se os dias são consecutivos.
  Future<int> getStreak() async {
    final box = await historyCompleter.future;

    List<HistoryPoint> data = box.values.isNotEmpty
        ? box.values.map((c) => HistoryPoint.fromMap(c)).toList()
        : [];

    if (data.isEmpty) return 0;

    // Ordena os pontos de histórico por data.
    data.sort((a, b) => a.date.compareTo(b.date));
    data = data.reversed.toList();

    int streak = 0;

    for (int i = 0; i < data.length; i++) {
      HistoryPoint current = data[i];
      HistoryPoint previous =
          i == 0 ? HistoryPoint(date: DateTime.now()) : data[i - 1];

      final currentDay =
          DateTime(current.date.year, current.date.month, current.date.day);
      final previousDay =
          DateTime(previous.date.year, previous.date.month, previous.date.day);

      if (currentDay.difference(previousDay).inDays == -1) {
        streak++;
      } else if (currentDay == previousDay) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  Future<void> addFocusSession(FocusSession session) async {
    final box = await focusCompleter.future;
    await box.put(session.id, session.toMap());
  }

  Future<void> updateFocusSession(FocusSession session) async {
    final box = await focusCompleter.future;
    await box.put(session.id, session.toMap());
  }

  Future<List<FocusSession>> getFocusSessions() async {
    final box = await focusCompleter.future;
    List<FocusSession> list = box.values.isNotEmpty
        ? box.values.map((c) => FocusSession.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<int> getTotalFocusMinutes() async {
    final sessions = await getFocusSessions();
    return sessions
        .where((s) => s.completed && s.type == FocusType.work)
        .fold<int>(0, (sum, s) => sum + s.durationMinutes);
  }

  Future<int> getCompletedSessionCount() async {
    final sessions = await getFocusSessions();
    return sessions.where((s) => s.completed && s.type == FocusType.work).length;
  }

  Future<void> resetDailySessionsIfNeeded() async {
    final config = await getConfig();
    final lastDate = config.lastSessionDate;

    if (lastDate == null) return;

    final now = DateTime.now();
    final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
    final today = DateTime(now.year, now.month, now.day);

    if (today.isAfter(lastDay)) {
      config.dailyFocusSessions = 0;
      config.lastSessionDate = null;
      await saveConfig(config);
    }
  }
}
