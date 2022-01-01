// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on _UserControllerBase, Store {
  final _$userAtom = Atom(name: '_UserControllerBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$organizationsAtom = Atom(name: '_UserControllerBase.organizations');

  @override
  ObservableList<Organization> get organizations {
    _$organizationsAtom.reportRead();
    return super.organizations;
  }

  @override
  set organizations(ObservableList<Organization> value) {
    _$organizationsAtom.reportWrite(value, super.organizations, () {
      super.organizations = value;
    });
  }

  final _$repositoriesAtom = Atom(name: '_UserControllerBase.repositories');

  @override
  ObservableList<Repository> get repositories {
    _$repositoriesAtom.reportRead();
    return super.repositories;
  }

  @override
  set repositories(ObservableList<Repository> value) {
    _$repositoriesAtom.reportWrite(value, super.repositories, () {
      super.repositories = value;
    });
  }

  final _$loadAtom = Atom(name: '_UserControllerBase.load');

  @override
  LoadState get load {
    _$loadAtom.reportRead();
    return super.load;
  }

  @override
  set load(LoadState value) {
    _$loadAtom.reportWrite(value, super.load, () {
      super.load = value;
    });
  }

  final _$showBannerAdAtom = Atom(name: '_UserControllerBase.showBannerAd');

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

  @override
  String toString() {
    return '''
user: ${user},
organizations: ${organizations},
repositories: ${repositories},
load: ${load},
showBannerAd: ${showBannerAd}
    ''';
  }
}
