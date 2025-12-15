import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hub_finder/shared/models/focus_session.dart';
import 'package:hub_finder/shared/models/focus_type.dart';
import 'package:hub_finder/shared/services/database_service.dart';
import 'package:hub_finder/shared/services/notification_service.dart';
import 'package:mobx/mobx.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'focus_controller.g.dart';

FocusController? _focusControllerInstance;

FocusController get focusController {
  _focusControllerInstance ??= FocusController();
  return _focusControllerInstance!;
}

class FocusController = _FocusControllerBase with _$FocusController;

abstract class _FocusControllerBase with Store {
  final localStorage = LocalStorageService();
  Timer? _timer;
  FocusSession? _currentSession;
  DateTime? _expectedEndTime;

  @observable
  int workDuration = 25;

  @observable
  int shortBreakDuration = 5;

  @observable
  int longBreakDuration = 15;

  @observable
  int cyclesBeforeLongBreak = 4;

  @observable
  int remainingSeconds = 25 * 60;

  @observable
  bool isRunning = false;

  @observable
  bool isPaused = false;

  @observable
  FocusType currentType = FocusType.work;

  @observable
  int completedPomodoros = 0;

  @observable
  int totalFocusMinutes = 0;

  @observable
  int completedSessionCount = 0;

  @computed
  int get totalSeconds {
    switch (currentType) {
      case FocusType.work:
        return workDuration * 60;
      case FocusType.shortBreak:
        return shortBreakDuration * 60;
      case FocusType.longBreak:
        return longBreakDuration * 60;
    }
  }

  @computed
  double get progress => remainingSeconds / totalSeconds;

  @computed
  String get formattedTime {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  _FocusControllerBase() {
    _init();
  }

  @action
  Future<void> _init() async {
    await _loadConfig();
    await _loadStats();
  }

  @action
  Future<void> _loadConfig() async {
    final config = await localStorage.getConfig();
    workDuration = config.focusWorkDuration;
    shortBreakDuration = config.focusShortBreakDuration;
    longBreakDuration = config.focusLongBreakDuration;
    cyclesBeforeLongBreak = config.focusCyclesBeforeLongBreak;

    currentType = _parseType(config.focusCurrentType);
    completedPomodoros = config.focusCompletedPomodoros;

    final maxSeconds = _getDurationForType(currentType) * 60;

    if (config.focusIsRunning && config.focusExpectedEndTime != null) {
      final now = DateTime.now();
      final expectedEnd = config.focusExpectedEndTime!;

      if (expectedEnd.isAfter(now)) {
        remainingSeconds = expectedEnd.difference(now).inSeconds;
        _expectedEndTime = expectedEnd;
        isRunning = true;
        isPaused = false;
        WakelockPlus.enable();
        _timer = Timer.periodic(const Duration(seconds: 1), (_) {
          _tick();
        });
        await NotificationService.instance.scheduleFocusCompleteNotification(
          expectedEnd,
          currentType,
        );
      } else {
        remainingSeconds = 0;
        _onTimerComplete();
      }
    } else {
      final savedSeconds = config.focusRemainingSeconds;
      if (savedSeconds > 0 && savedSeconds <= maxSeconds) {
        remainingSeconds = savedSeconds;
      } else {
        remainingSeconds = maxSeconds;
      }
    }
  }

  FocusType _parseType(String type) {
    switch (type) {
      case 'shortBreak':
        return FocusType.shortBreak;
      case 'longBreak':
        return FocusType.longBreak;
      default:
        return FocusType.work;
    }
  }

  int _getDurationForType(FocusType type) {
    switch (type) {
      case FocusType.work:
        return workDuration;
      case FocusType.shortBreak:
        return shortBreakDuration;
      case FocusType.longBreak:
        return longBreakDuration;
    }
  }

  @action
  Future<void> _loadStats() async {
    totalFocusMinutes = await localStorage.getTotalFocusMinutes();
    completedSessionCount = await localStorage.getCompletedSessionCount();
  }

  Future<void> _saveConfig() async {
    final config = await localStorage.getConfig();
    config.focusWorkDuration = workDuration;
    config.focusShortBreakDuration = shortBreakDuration;
    config.focusLongBreakDuration = longBreakDuration;
    config.focusCyclesBeforeLongBreak = cyclesBeforeLongBreak;
    await localStorage.saveConfig(config);
  }

  Future<void> _saveState() async {
    final config = await localStorage.getConfig();
    config.focusCurrentType = currentType.name;
    config.focusRemainingSeconds = remainingSeconds;
    config.focusCompletedPomodoros = completedPomodoros;
    config.focusExpectedEndTime = _expectedEndTime;
    config.focusIsRunning = isRunning && !isPaused;
    await localStorage.saveConfig(config);
  }

  @action
  void setWorkDuration(int minutes) {
    workDuration = minutes;
    if (currentType == FocusType.work && !isRunning) {
      remainingSeconds = minutes * 60;
    }
    _saveConfig();
  }

  @action
  void setShortBreakDuration(int minutes) {
    shortBreakDuration = minutes;
    if (currentType == FocusType.shortBreak && !isRunning) {
      remainingSeconds = minutes * 60;
    }
    _saveConfig();
  }

  @action
  void setLongBreakDuration(int minutes) {
    longBreakDuration = minutes;
    if (currentType == FocusType.longBreak && !isRunning) {
      remainingSeconds = minutes * 60;
    }
    _saveConfig();
  }

  @action
  void setCyclesBeforeLongBreak(int cycles) {
    cyclesBeforeLongBreak = cycles;
    _saveConfig();
  }

  @action
  void resetToDefaults() {
    workDuration = 25;
    shortBreakDuration = 5;
    longBreakDuration = 15;
    cyclesBeforeLongBreak = 4;
    if (!isRunning) {
      remainingSeconds = workDuration * 60;
    }
    _saveConfig();
  }

  @action
  Future<void> start() async {
    if (isRunning && !isPaused) return;

    if (!isPaused) {
      _currentSession = FocusSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        startTime: DateTime.now(),
        durationMinutes: currentType == FocusType.work
            ? workDuration
            : currentType == FocusType.shortBreak
                ? shortBreakDuration
                : longBreakDuration,
        type: currentType,
      );
      await localStorage.addFocusSession(_currentSession!);
    }

    _expectedEndTime = DateTime.now().add(Duration(seconds: remainingSeconds));
    isRunning = true;
    isPaused = false;
    WakelockPlus.enable();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });

    await NotificationService.instance.scheduleFocusCompleteNotification(
      _expectedEndTime!,
      currentType,
    );

    _saveState();
  }

  @action
  void _tick() {
    if (remainingSeconds > 0) {
      remainingSeconds--;
    } else {
      _onTimerComplete();
    }
  }

  @action
  Future<void> _onTimerComplete() async {
    _timer?.cancel();
    _expectedEndTime = null;
    isRunning = false;
    isPaused = false;
    WakelockPlus.disable();

    await NotificationService.instance.cancelScheduledFocusNotification();

    HapticFeedback.heavyImpact();
    await NotificationService.instance
        .showFocusCompleteNotification(currentType);

    if (_currentSession != null) {
      final completedSession = _currentSession!.copyWith(
        endTime: DateTime.now(),
        completed: true,
      );
      await localStorage.updateFocusSession(completedSession);
      _currentSession = null;
    }

    if (currentType == FocusType.work) {
      completedPomodoros++;
      await _loadStats();

      if (completedPomodoros % cyclesBeforeLongBreak == 0) {
        currentType = FocusType.longBreak;
        remainingSeconds = longBreakDuration * 60;
      } else {
        currentType = FocusType.shortBreak;
        remainingSeconds = shortBreakDuration * 60;
      }
    } else {
      currentType = FocusType.work;
      remainingSeconds = workDuration * 60;
    }
    _saveState();
  }

  @action
  Future<void> pause() async {
    _timer?.cancel();

    if (_expectedEndTime != null) {
      final now = DateTime.now();
      if (_expectedEndTime!.isAfter(now)) {
        remainingSeconds = _expectedEndTime!.difference(now).inSeconds;
      }
    }

    _expectedEndTime = null;
    isPaused = true;
    isRunning = true;
    WakelockPlus.disable();
    await NotificationService.instance.cancelScheduledFocusNotification();
    _saveState();
  }

  @action
  Future<void> reset() async {
    _timer?.cancel();
    _expectedEndTime = null;
    isRunning = false;
    isPaused = false;
    WakelockPlus.disable();

    await NotificationService.instance.cancelScheduledFocusNotification();

    if (_currentSession != null) {
      await localStorage.updateFocusSession(_currentSession!.copyWith(
        endTime: DateTime.now(),
        completed: false,
      ));
      _currentSession = null;
    }

    switch (currentType) {
      case FocusType.work:
        remainingSeconds = workDuration * 60;
        break;
      case FocusType.shortBreak:
        remainingSeconds = shortBreakDuration * 60;
        break;
      case FocusType.longBreak:
        remainingSeconds = longBreakDuration * 60;
        break;
    }
    _saveState();
  }

  @action
  void switchToWork() {
    if (isRunning) return;
    currentType = FocusType.work;
    remainingSeconds = workDuration * 60;
    _saveState();
  }

  @action
  void switchToShortBreak() {
    if (isRunning) return;
    currentType = FocusType.shortBreak;
    remainingSeconds = shortBreakDuration * 60;
    _saveState();
  }

  @action
  void switchToLongBreak() {
    if (isRunning) return;
    currentType = FocusType.longBreak;
    remainingSeconds = longBreakDuration * 60;
    _saveState();
  }

  void saveStateForBackground() {
    _saveState();
  }

  @action
  void syncOnResume() {
    if (!isRunning || isPaused) return;

    if (_expectedEndTime != null) {
      final now = DateTime.now();

      if (_expectedEndTime!.isAfter(now)) {
        remainingSeconds = _expectedEndTime!.difference(now).inSeconds;
      } else {
        remainingSeconds = 0;
        _onTimerComplete();
      }
    }
  }

  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
  }
}
