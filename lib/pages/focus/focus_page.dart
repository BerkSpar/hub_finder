import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hub_finder/pages/focus/focus_controller.dart';
import 'package:hub_finder/pages/focus/widgets/circular_timer_widget.dart';
import 'package:hub_finder/pages/focus/widgets/duration_picker_widget.dart';
import 'package:hub_finder/pages/focus/widgets/focus_stats_widget.dart';
import 'package:hub_finder/shared/models/focus_type.dart';
import 'package:hub_finder/shared/services/subscription_service.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> with WidgetsBindingObserver {
  final controller = focusController;
  bool isPro = false;
  int remainingSessions = 3;
  ReactionDisposer? _reactionDisposer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseAnalytics.instance.logSelectContent(
      contentType: 'focus_mode',
      itemId: 'focus_page',
    );
    _loadSessionInfo();
    _reactionDisposer = reaction(
      (_) => controller.completedPomodoros,
      (_) => _loadSessionInfo(),
    );
  }

  Future<void> _loadSessionInfo() async {
    final proStatus = await SubscriptionService.instance.isPro;
    final remaining = await SubscriptionService.instance.remainingSessions;
    if (mounted) {
      setState(() {
        isPro = proStatus;
        remainingSessions = remaining;
      });
    }
  }

  Future<void> _handleStartSession() async {
    if (controller.isRunning && !controller.isPaused) {
      controller.pause();
      return;
    }

    if (controller.isPaused) {
      controller.start();
      return;
    }

    if (controller.currentType != FocusType.work) {
      controller.start();
      return;
    }

    final canUse = await SubscriptionService.instance.canUseFocus;
    if (!mounted) return;

    if (canUse) {
      await controller.start();
      await _loadSessionInfo();
    } else {
      final result = await RevenueCatUI.presentPaywallIfNeeded('pro');
      await _loadSessionInfo();
      if (result == PaywallResult.purchased || result == PaywallResult.restored) {
        await controller.start();
      }
    }
  }

  @override
  void dispose() {
    _reactionDisposer?.call();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      controller.saveStateForBackground();
    } else if (state == AppLifecycleState.resumed) {
      controller.syncOnResume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Focus Mode'),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (!isPro)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: remainingSessions > 0
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 14,
                    color: remainingSessions > 0
                        ? Colors.green.shade700
                        : Colors.red.shade700,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$remainingSessions/3',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: remainingSessions > 0
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return Column(
            children: [
              const SizedBox(height: 24),
              _buildTypeSelector(),
              const SizedBox(height: 48),
              CircularTimerWidget(
                progress: controller.progress,
                formattedTime: controller.formattedTime,
                isRunning: controller.isRunning,
                type: controller.currentType,
              ),
              const SizedBox(height: 48),
              _buildControls(),
              const Spacer(),
              FocusStatsWidget(
                totalMinutes: controller.totalFocusMinutes,
                sessionCount: controller.completedSessionCount,
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTypeButton('Focus', FocusType.work, controller.switchToWork),
            const SizedBox(width: 8),
            _buildTypeButton('Short Break', FocusType.shortBreak,
                controller.switchToShortBreak),
            const SizedBox(width: 8),
            _buildTypeButton('Long Break', FocusType.longBreak,
                controller.switchToLongBreak),
          ],
        );
      },
    );
  }

  Widget _buildTypeButton(String label, FocusType type, VoidCallback onTap) {
    final isSelected = controller.currentType == type;
    final isDisabled = controller.isRunning;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => controller.reset(),
              icon: const Icon(Icons.refresh, size: 32),
              color: Colors.grey,
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: _handleStartSession,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getColorForType(controller.currentType),
                ),
                child: Icon(
                  controller.isRunning && !controller.isPaused
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 24),
            IconButton(
              onPressed: () => _showSettingsBottomSheet(context),
              icon: const Icon(Icons.tune, size: 32),
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  Color _getColorForType(FocusType type) {
    switch (type) {
      case FocusType.work:
        return const Color(0xFFE74C3C);
      case FocusType.shortBreak:
        return const Color(0xFF2ECC71);
      case FocusType.longBreak:
        return const Color(0xFF3498DB);
    }
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Observer(
        builder: (_) => DurationPickerWidget(
          workDuration: controller.workDuration,
          shortBreakDuration: controller.shortBreakDuration,
          longBreakDuration: controller.longBreakDuration,
          cyclesBeforeLongBreak: controller.cyclesBeforeLongBreak,
          onWorkDurationChanged: controller.setWorkDuration,
          onShortBreakChanged: controller.setShortBreakDuration,
          onLongBreakChanged: controller.setLongBreakDuration,
          onCyclesChanged: controller.setCyclesBeforeLongBreak,
          onResetToDefaults: controller.resetToDefaults,
        ),
      ),
    );
  }
}
