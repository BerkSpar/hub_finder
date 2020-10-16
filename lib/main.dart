import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_finder/pages/home_page.dart';
import 'package:github_finder/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Finder',
      theme: ThemeData(
        primarySwatch: lightColor,
        accentColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
