// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$showBannerAdAtom = Atom(name: '_HomeControllerBase.showBannerAd');

  @override
  bool get showBannerAd {
    _$showBannerAdAtom.reportRead();
    return super.showBannerAd;
  }

  @override
  set showBannerAd(bool value) {
    _$showBannerAdAtom.reportWrite(value, super.showBannerAd, () {
      super.showBannerAd = value;
    });
  }

  final _$myRewardedAdAtom = Atom(name: '_HomeControllerBase.myRewardedAd');

  @override
  RewardedAd? get myRewardedAd {
    _$myRewardedAdAtom.reportRead();
    return super.myRewardedAd;
  }

  @override
  set myRewardedAd(RewardedAd? value) {
    _$myRewardedAdAtom.reportWrite(value, super.myRewardedAd, () {
      super.myRewardedAd = value;
    });
  }

  final _$cachedUsersAtom = Atom(name: '_HomeControllerBase.cachedUsers');

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

  final _$trendingRepositoriesAtom =
      Atom(name: '_HomeControllerBase.trendingRepositories');

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

  final _$trendingUsersAtom = Atom(name: '_HomeControllerBase.trendingUsers');

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

  @override
  String toString() {
    return '''
showBannerAd: ${showBannerAd},
myRewardedAd: ${myRewardedAd},
cachedUsers: ${cachedUsers},
trendingRepositories: ${trendingRepositories},
trendingUsers: ${trendingUsers}
    ''';
  }
}
