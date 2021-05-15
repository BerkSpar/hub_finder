import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hub_finder/shared/models/cached_user.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TextEditingController searchController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();

  @observable
  List<CachedUser> cachedUsers = <CachedUser>[];

  _HomeControllerBase() {
    _init();
  }

  _init() async {
    Timer.periodic(Duration(seconds: 1), (_) async {
      cachedUsers = await databaseService.getCachedUsers();
    });
  }
}
