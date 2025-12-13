// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrganizationController on _OrganizationControllerBase, Store {
  late final _$organizationAtom =
      Atom(name: '_OrganizationControllerBase.organization', context: context);

  @override
  Organization get organization {
    _$organizationAtom.reportRead();
    return super.organization;
  }

  @override
  set organization(Organization value) {
    _$organizationAtom.reportWrite(value, super.organization, () {
      super.organization = value;
    });
  }

  late final _$membersAtom =
      Atom(name: '_OrganizationControllerBase.members', context: context);

  @override
  ObservableList<User> get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(ObservableList<User> value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  late final _$loadAtom =
      Atom(name: '_OrganizationControllerBase.load', context: context);

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
organization: ${organization},
members: ${members},
load: ${load}
    ''';
  }
}
