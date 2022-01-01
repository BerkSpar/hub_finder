// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RepoController on _RepoControllerBase, Store {
  final _$repositoryAtom = Atom(name: '_RepoControllerBase.repository');

  @override
  Repository get repository {
    _$repositoryAtom.reportRead();
    return super.repository;
  }

  @override
  set repository(Repository value) {
    _$repositoryAtom.reportWrite(value, super.repository, () {
      super.repository = value;
    });
  }

  final _$contributorsAtom = Atom(name: '_RepoControllerBase.contributors');

  @override
  ObservableList<User> get contributors {
    _$contributorsAtom.reportRead();
    return super.contributors;
  }

  @override
  set contributors(ObservableList<User> value) {
    _$contributorsAtom.reportWrite(value, super.contributors, () {
      super.contributors = value;
    });
  }

  final _$loadAtom = Atom(name: '_RepoControllerBase.load');

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

  final _$showBannerAdAtom = Atom(name: '_RepoControllerBase.showBannerAd');

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
repository: ${repository},
contributors: ${contributors},
load: ${load},
showBannerAd: ${showBannerAd}
    ''';
  }
}
