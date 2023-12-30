import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/home/home_controller.dart';

class HomePageStreak extends StatefulWidget {
  final PageController pageController;
  final HomeController controller;

  HomePageStreak({
    super.key,
    required this.pageController,
    required this.controller,
  });

  @override
  State<HomePageStreak> createState() => _HomePageStreakState();
}

class _HomePageStreakState extends State<HomePageStreak> {
  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).scaffoldBackgroundColor;

    return Observer(builder: (_) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.controller.isActiveStreak ? Colors.green : background,
        ),
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              "Be amazing!",
              style: TextStyle(
                color: widget.controller.isActiveStreak
                    ? background
                    : Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.controller.isActiveStreak ? "You are awesome!!!" : "Today",
              style: TextStyle(
                color: widget.controller.isActiveStreak
                    ? background
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: widget.controller.onTapStreak,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.controller.isActiveStreak
                      ? background
                      : Colors.green,
                ),
                height: 150,
                width: 150,
                child: Icon(
                  Icons.check,
                  color: widget.controller.isActiveStreak
                      ? Colors.green
                      : background,
                  size: 80,
                ),
              ),
            ),
            Spacer(),
            Text(
              "Streak",
              style: TextStyle(
                color: widget.controller.isActiveStreak
                    ? background
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Observer(builder: (context) {
              return Text(
                "${widget.controller.streak}",
                style: TextStyle(
                  color: widget.controller.isActiveStreak
                      ? background
                      : Colors.green,
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                ),
              );
            }),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                widget.pageController.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              child: Icon(
                Icons.keyboard_double_arrow_down,
                color:
                    widget.controller.isActiveStreak ? background : Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
    });
  }
}
