// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrganizationController on _OrganizationControllerBase, Store {
  final _$loadAtom = Atom(name: '_OrganizationControllerBase.load');

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
load: ${load}
    ''';
  }
}
