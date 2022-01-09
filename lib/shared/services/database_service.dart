import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  Completer<Box> cacheCompleter = Completer<Box>();
  Completer<Box> adsCompleter = Completer<Box>();
  Completer<Box> reviewCompleter = Completer<Box>();

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

  Future saveReviewData() async {
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
}
