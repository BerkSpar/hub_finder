import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hub_finder/pages/home/home_page.dart';
import 'package:hub_finder/shared/core/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Color(0xfff0f0f5),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: lightColor,
        ).copyWith(
          secondary: Colors.black,
        ),
      ),
      home: HomePage(),
    );
  }
}
