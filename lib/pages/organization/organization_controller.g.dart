// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrganizationController on _OrganizationControllerBase, Store {
  final _$organizationAtom =
      Atom(name: '_OrganizationControllerBase.organization');

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

  final _$membersAtom = Atom(name: '_OrganizationControllerBase.members');

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

  final _$showBannerAdAtom =
      Atom(name: '_OrganizationControllerBase.showBannerAd');

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
organization: ${organization},
members: ${members},
load: ${load},
showBannerAd: ${showBannerAd}
    ''';
  }
}
