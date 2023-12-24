import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hub_finder/pages/home/home_page.dart';
import 'package:hub_finder/pages/onboarding/onboarding_page.dart';
import 'package:hub_finder/pages/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _containerHeight = 0;
  double _containerWidth = 0;
  double _opacity = 1;
  late Color _containerColor = Theme.of(context).scaffoldBackgroundColor;

  final controller = SplashController();

  @override
  void initState() {
    super.initState();
    controller.init();

    _animate();
  }

  void _animate() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {
      _containerHeight = 100;
      _containerWidth = 100;
    });

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _opacity = 0;
    });

    await Future.delayed(Duration(milliseconds: 300));

    if (controller.config.didOnboarding) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    }

    FirebaseAnalytics.instance.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 300),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _containerHeight,
            width: _containerWidth,
            color: _containerColor,
            child: Image.asset('asset/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
