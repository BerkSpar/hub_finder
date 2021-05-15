// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
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

  @override
  String toString() {
    return '''
cachedUsers: ${cachedUsers}
    ''';
  }
}
