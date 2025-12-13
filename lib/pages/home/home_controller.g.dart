// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$cachedUsersAtom =
      Atom(name: '_HomeControllerBase.cachedUsers', context: context);

  @override
  List<CachedUser> get cachedUsers {
    _$cachedUsersAtom.reportRead();
    return super.cachedUsers;
  }

  @override
  set cachedUsers(List<CachedUser> value) {
    _$cachedUsersAtom.reportWrite(value, super.cachedUsers, () {
      super.cachedUsers = value;
    });
  }

  late final _$trendingRepositoriesAtom =
      Atom(name: '_HomeControllerBase.trendingRepositories', context: context);

  @override
  List<Repository> get trendingRepositories {
    _$trendingRepositoriesAtom.reportRead();
    return super.trendingRepositories;
  }

  @override
  set trendingRepositories(List<Repository> value) {
    _$trendingRepositoriesAtom.reportWrite(value, super.trendingRepositories,
        () {
      super.trendingRepositories = value;
    });
  }

  late final _$trendingUsersAtom =
      Atom(name: '_HomeControllerBase.trendingUsers', context: context);

  @override
  List<User> get trendingUsers {
    _$trendingUsersAtom.reportRead();
    return super.trendingUsers;
  }

  @override
  set trendingUsers(List<User> value) {
    _$trendingUsersAtom.reportWrite(value, super.trendingUsers, () {
      super.trendingUsers = value;
    });
  }

  late final _$streakAtom =
      Atom(name: '_HomeControllerBase.streak', context: context);

  @override
  int get streak {
    _$streakAtom.reportRead();
    return super.streak;
  }

  @override
  set streak(int value) {
    _$streakAtom.reportWrite(value, super.streak, () {
      super.streak = value;
    });
  }

  late final _$isActiveStreakAtom =
      Atom(name: '_HomeControllerBase.isActiveStreak', context: context);

  @override
  bool get isActiveStreak {
    _$isActiveStreakAtom.reportRead();
    return super.isActiveStreak;
  }

  @override
  set isActiveStreak(bool value) {
    _$isActiveStreakAtom.reportWrite(value, super.isActiveStreak, () {
      super.isActiveStreak = value;
    });
  }

  late final _$configAtom =
      Atom(name: '_HomeControllerBase.config', context: context);

  @override
  UserConfig get config {
    _$configAtom.reportRead();
    return super.config;
  }

  @override
  set config(UserConfig value) {
    _$configAtom.reportWrite(value, super.config, () {
      super.config = value;
    });
  }

  @override
  String toString() {
    return '''
cachedUsers: ${cachedUsers},
trendingRepositories: ${trendingRepositories},
trendingUsers: ${trendingUsers},
streak: ${streak},
isActiveStreak: ${isActiveStreak},
config: ${config}
    ''';
  }
}
