import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_finder/pages/splash/splash_page.dart';
import 'package:hub_finder/shared/core/app_colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    Firebase.app().setAutomaticDataCollectionEnabled(false);
    Firebase.app().setAutomaticResourceManagementEnabled(false);
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: darkColor,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: darkColor,
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: lightColor,
        )
            .copyWith(
              secondary: Colors.black,
            )
            .copyWith(surface: const Color(0xfff0f0f5)),
      ),
      home: const SplashPage(),
    );
  }
}
