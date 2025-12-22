import 'package:flutter/material.dart';
import 'package:hub_finder/pages/focus/focus_page.dart';
import 'package:hub_finder/pages/home/home_controller.dart';
import 'package:hub_finder/pages/home/widgets/home_page_content.dart';
import 'package:hub_finder/pages/home/widgets/home_page_streak.dart';
import 'package:hub_finder/shared/services/review_service.dart';
import 'package:hub_finder/shared/services/subscription_service.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

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
  bool isPro = false;

  @override
  void initState() {
    super.initState();
    ReviewService.scheduleReview();
    _checkProStatus();

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

  Future<void> _checkProStatus() async {
    final proStatus = await SubscriptionService.instance.isPro;
    if (mounted) {
      setState(() {
        isPro = proStatus;
      });
    }
  }

  Future<void> _handleFocusTap() async {
    final canUse = await SubscriptionService.instance.canUseFocus;
    if (!mounted) return;

    if (canUse) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FocusPage()),
      );
    } else {
      await RevenueCatUI.presentPaywallIfNeeded('pro');
      _checkProStatus();
    }
  }

  void _showToolsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Tools',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              _buildToolOption(
                icon: Icons.timer,
                title: 'Focus Mode',
                subtitle: 'Pomodoro timer for productivity',
                onTap: () {
                  Navigator.pop(context);
                  _handleFocusTap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isPro = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isPro) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PRO',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.amber[700],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showToolsMenu,
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
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
            isPro: isPro,
            onUpgradeTap: () async {
              await RevenueCatUI.presentPaywall();
              _checkProStatus();
            },
          ),
        ],
      ),
    );
  }
}
