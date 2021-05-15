import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_finder/pages/home/home_page.dart';
import 'package:hub_finder/utils/colors.dart';

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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Color(0xfff0f0f5),
      ),
      home: HomePage(),
    );
  }
}
