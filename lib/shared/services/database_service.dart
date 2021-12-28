import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  Completer<Box> boxCompleter = Completer<Box>();

  DatabaseService() {
    _init();
  }

  _init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    final box = await Hive.openBox('cache');
    if (!boxCompleter.isCompleted) boxCompleter.complete(box);
  }

  Future<List<CachedUser>> getCachedUsers() async {
    final box = await boxCompleter.future;

    List<CachedUser> list = box.values.isNotEmpty
        ? box.values.map((c) => CachedUser.fromMap(c)).toList()
        : [];

    return list;
  }

  Future<int> addCachedUser(CachedUser cachedUser) async {
    final box = await boxCompleter.future;

    return await box.add(cachedUser.toMap());
  }
}
