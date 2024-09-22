import 'package:flutter/material.dart';
import 'package:hub_finder/pages/home/home_controller.dart';
import 'package:hub_finder/pages/home/widgets/home_page_content.dart';
import 'package:hub_finder/pages/home/widgets/home_page_streak.dart';
import 'package:hub_finder/shared/services/review_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  final scrollController = ScrollController();
  final pageController = PageController();

  bool blockPageController = false;

  @override
  void initState() {
    super.initState();
    ReviewService.scheduleReview();

    scrollController.addListener(() {
      if (scrollController.offset < -50) {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo_light.png', height: 32),
        centerTitle: true,
        elevation: 0,
      ),
      body: PageView(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          if (value == 0) {
            setState(() {
              blockPageController = false;
            });
          } else {
            setState(() {
              blockPageController = true;
            });
          }
        },
        controller: pageController,
        physics:
            blockPageController ? const NeverScrollableScrollPhysics() : null,
        children: [
          HomePageStreak(
            pageController: pageController,
            controller: controller,
          ),
          HomePageContent(
            controller: controller,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}
