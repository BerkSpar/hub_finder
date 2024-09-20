import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/pages/splash/splash_page.dart';
import 'package:hub_finder/shared/core/app_ad.dart';
import 'package:hub_finder/shared/core/app_colors.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  AppAd.showAd = await LocalStorageService().showAds();

  AppAd.showAd = false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    Firebase.app().setAutomaticDataCollectionEnabled(false);
    Firebase.app().setAutomaticResourceManagementEnabled(false);
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hub Finder',
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: darkColor,
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: darkColor,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: lightColor,
        )
            .copyWith(
              secondary: Colors.black,
            )
            .copyWith(background: Color(0xfff0f0f5)),
      ),
      home: SplashPage(),
    );
  }
}
