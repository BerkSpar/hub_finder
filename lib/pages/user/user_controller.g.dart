// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserController on _UserControllerBase, Store {
  late final _$userAtom =
      Atom(name: '_UserControllerBase.user', context: context);

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

  late final _$organizationsAtom =
      Atom(name: '_UserControllerBase.organizations', context: context);

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

  late final _$repositoriesAtom =
      Atom(name: '_UserControllerBase.repositories', context: context);

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

  late final _$loadAtom =
      Atom(name: '_UserControllerBase.load', context: context);

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

  @override
  String toString() {
    return '''
user: ${user},
organizations: ${organizations},
repositories: ${repositories},
load: ${load}
    ''';
  }
}
