import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:hub_finder/shared/services/database_service.dart';

class SubscriptionService {
  static final SubscriptionService instance = SubscriptionService._();
  SubscriptionService._();

  final Completer<void> _initCompleter = Completer<void>();
  CustomerInfo? _customerInfo;
  final LocalStorageService _storage = LocalStorageService();

  static const int maxFreeSessions = 3;
  static const String entitlementId = 'pro';

  Future<void> initialize() async {
    if (_initCompleter.isCompleted) return;

    try {
      final apiKey = Platform.isIOS
          ? dotenv.env['REVENUECAT_IOS_API_KEY'] ?? ''
          : dotenv.env['REVENUECAT_ANDROID_API_KEY'] ?? '';

      if (apiKey.isEmpty) {
        if (kDebugMode) {
          print('RevenueCat API key not found');
        }
        _initCompleter.complete();
        return;
      }

      await Purchases.configure(PurchasesConfiguration(apiKey));
      _customerInfo = await Purchases.getCustomerInfo();

      Purchases.addCustomerInfoUpdateListener((info) {
        _customerInfo = info;
      });

      _initCompleter.complete();
    } catch (e) {
      if (kDebugMode) {
        print('RevenueCat initialization error: $e');
      }
      if (!_initCompleter.isCompleted) {
        _initCompleter.complete();
      }
    }
  }

  Future<void> _ensureInitialized() async {
    await _initCompleter.future;
  }

  Future<bool> get isPro async {
    await _ensureInitialized();
    if (_customerInfo == null) return false;
    return _customerInfo!.entitlements.active.containsKey(entitlementId);
  }

  Future<Offerings?> getOfferings() async {
    await _ensureInitialized();
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting offerings: $e');
      }
      return null;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    await _ensureInitialized();
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      _customerInfo = result.customerInfo;
      return _customerInfo!.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      if (kDebugMode) {
        print('Purchase error: $e');
      }
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    await _ensureInitialized();
    try {
      _customerInfo = await Purchases.restorePurchases();
      return _customerInfo!.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      if (kDebugMode) {
        print('Restore error: $e');
      }
      return false;
    }
  }

  Future<int> getTodayFocusSessions() async {
    await _storage.resetDailySessionsIfNeeded();
    final config = await _storage.getConfig();
    return config.dailyFocusSessions;
  }

  Future<bool> get canUseFocus async {
    final pro = await isPro;
    if (pro) return true;

    final sessions = await getTodayFocusSessions();
    return sessions < maxFreeSessions;
  }

  Future<int> get remainingSessions async {
    final pro = await isPro;
    if (pro) return -1;

    final sessions = await getTodayFocusSessions();
    return maxFreeSessions - sessions;
  }

  Future<void> incrementFocusSession() async {
    final config = await _storage.getConfig();
    config.dailyFocusSessions++;
    config.lastSessionDate = DateTime.now();
    await _storage.saveConfig(config);
  }
}
