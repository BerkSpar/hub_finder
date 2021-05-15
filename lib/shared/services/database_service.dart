import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseHelper _helper = DatabaseHelper();

  Future<List<CachedUser>> getCachedUsers() async {
    final db = await _helper.getDatabase();

    var response = await db.rawQuery('SELECT * FROM users ORDER BY id desc');

    List<CachedUser> list = response.isNotEmpty
        ? response.map((c) => CachedUser.fromMap(c)).toList()
        : [];

    return list;
  }

  Future addCachedUser(CachedUser cachedUser) async {
    final db = await _helper.getDatabase();

    await db.insert('users', {
      'username': cachedUser.username,
      'title': cachedUser.title,
      'subtitle': cachedUser.subtitle,
      'imageUrl': cachedUser.imageUrl,
    });
  }
}

class DatabaseHelper {
  Future<Database> getDatabase() async {
    return await openDatabase(
      await getDatabasesPath() + '/app.db',
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT, subtitle TEXT, title TEXT, imageUrl TEXT)",
    );
  }
}
