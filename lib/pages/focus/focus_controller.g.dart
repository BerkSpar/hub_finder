// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FocusController on _FocusControllerBase, Store {
  Computed<int>? _$totalSecondsComputed;

  @override
  int get totalSeconds =>
      (_$totalSecondsComputed ??= Computed<int>(() => super.totalSeconds,
              name: '_FocusControllerBase.totalSeconds'))
          .value;
  Computed<double>? _$progressComputed;

  @override
  double get progress =>
      (_$progressComputed ??= Computed<double>(() => super.progress,
              name: '_FocusControllerBase.progress'))
          .value;
  Computed<String>? _$formattedTimeComputed;

  @override
  String get formattedTime =>
      (_$formattedTimeComputed ??= Computed<String>(() => super.formattedTime,
              name: '_FocusControllerBase.formattedTime'))
          .value;

  late final _$workDurationAtom =
      Atom(name: '_FocusControllerBase.workDuration', context: context);

  @override
  int get workDuration {
    _$workDurationAtom.reportRead();
    return super.workDuration;
  }

  @override
  set workDuration(int value) {
    _$workDurationAtom.reportWrite(value, super.workDuration, () {
      super.workDuration = value;
    });
  }

  late final _$shortBreakDurationAtom =
      Atom(name: '_FocusControllerBase.shortBreakDuration', context: context);

  @override
  int get shortBreakDuration {
    _$shortBreakDurationAtom.reportRead();
    return super.shortBreakDuration;
  }

  @override
  set shortBreakDuration(int value) {
    _$shortBreakDurationAtom.reportWrite(value, super.shortBreakDuration, () {
      super.shortBreakDuration = value;
    });
  }

  late final _$longBreakDurationAtom =
      Atom(name: '_FocusControllerBase.longBreakDuration', context: context);

  @override
  int get longBreakDuration {
    _$longBreakDurationAtom.reportRead();
    return super.longBreakDuration;
  }

  @override
  set longBreakDuration(int value) {
    _$longBreakDurationAtom.reportWrite(value, super.longBreakDuration, () {
      super.longBreakDuration = value;
    });
  }

  late final _$cyclesBeforeLongBreakAtom = Atom(
      name: '_FocusControllerBase.cyclesBeforeLongBreak', context: context);

  @override
  int get cyclesBeforeLongBreak {
    _$cyclesBeforeLongBreakAtom.reportRead();
    return super.cyclesBeforeLongBreak;
  }

  @override
  set cyclesBeforeLongBreak(int value) {
    _$cyclesBeforeLongBreakAtom.reportWrite(value, super.cyclesBeforeLongBreak,
        () {
      super.cyclesBeforeLongBreak = value;
    });
  }

  late final _$remainingSecondsAtom =
      Atom(name: '_FocusControllerBase.remainingSeconds', context: context);

  @override
  int get remainingSeconds {
    _$remainingSecondsAtom.reportRead();
    return super.remainingSeconds;
  }

  @override
  set remainingSeconds(int value) {
    _$remainingSecondsAtom.reportWrite(value, super.remainingSeconds, () {
      super.remainingSeconds = value;
    });
  }

  late final _$isRunningAtom =
      Atom(name: '_FocusControllerBase.isRunning', context: context);

  @override
  bool get isRunning {
    _$isRunningAtom.reportRead();
    return super.isRunning;
  }

  @override
  set isRunning(bool value) {
    _$isRunningAtom.reportWrite(value, super.isRunning, () {
      super.isRunning = value;
    });
  }

  late final _$isPausedAtom =
      Atom(name: '_FocusControllerBase.isPaused', context: context);

  @override
  bool get isPaused {
    _$isPausedAtom.reportRead();
    return super.isPaused;
  }

  @override
  set isPaused(bool value) {
    _$isPausedAtom.reportWrite(value, super.isPaused, () {
      super.isPaused = value;
    });
  }

  late final _$currentTypeAtom =
      Atom(name: '_FocusControllerBase.currentType', context: context);

  @override
  FocusType get currentType {
    _$currentTypeAtom.reportRead();
    return super.currentType;
  }

  @override
  set currentType(FocusType value) {
    _$currentTypeAtom.reportWrite(value, super.currentType, () {
      super.currentType = value;
    });
  }

  late final _$completedPomodorosAtom =
      Atom(name: '_FocusControllerBase.completedPomodoros', context: context);

  @override
  int get completedPomodoros {
    _$completedPomodorosAtom.reportRead();
    return super.completedPomodoros;
  }

  @override
  set completedPomodoros(int value) {
    _$completedPomodorosAtom.reportWrite(value, super.completedPomodoros, () {
      super.completedPomodoros = value;
    });
  }

  late final _$totalFocusMinutesAtom =
      Atom(name: '_FocusControllerBase.totalFocusMinutes', context: context);

  @override
  int get totalFocusMinutes {
    _$totalFocusMinutesAtom.reportRead();
    return super.totalFocusMinutes;
  }

  @override
  set totalFocusMinutes(int value) {
    _$totalFocusMinutesAtom.reportWrite(value, super.totalFocusMinutes, () {
      super.totalFocusMinutes = value;
    });
  }

  late final _$completedSessionCountAtom = Atom(
      name: '_FocusControllerBase.completedSessionCount', context: context);

  @override
  int get completedSessionCount {
    _$completedSessionCountAtom.reportRead();
    return super.completedSessionCount;
  }

  @override
  set completedSessionCount(int value) {
    _$completedSessionCountAtom.reportWrite(value, super.completedSessionCount,
        () {
      super.completedSessionCount = value;
    });
  }

  late final _$_initAsyncAction =
      AsyncAction('_FocusControllerBase._init', context: context);

  @override
  Future<void> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$_loadConfigAsyncAction =
      AsyncAction('_FocusControllerBase._loadConfig', context: context);

  @override
  Future<void> _loadConfig() {
    return _$_loadConfigAsyncAction.run(() => super._loadConfig());
  }

  late final _$_loadStatsAsyncAction =
      AsyncAction('_FocusControllerBase._loadStats', context: context);

  @override
  Future<void> _loadStats() {
    return _$_loadStatsAsyncAction.run(() => super._loadStats());
  }

  late final _$startAsyncAction =
      AsyncAction('_FocusControllerBase.start', context: context);

  @override
  Future<void> start() {
    return _$startAsyncAction.run(() => super.start());
  }

  late final _$_onTimerCompleteAsyncAction =
      AsyncAction('_FocusControllerBase._onTimerComplete', context: context);

  @override
  Future<void> _onTimerComplete() {
    return _$_onTimerCompleteAsyncAction.run(() => super._onTimerComplete());
  }

  late final _$pauseAsyncAction =
      AsyncAction('_FocusControllerBase.pause', context: context);

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$resetAsyncAction =
      AsyncAction('_FocusControllerBase.reset', context: context);

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  late final _$_FocusControllerBaseActionController =
      ActionController(name: '_FocusControllerBase', context: context);

  @override
  void setWorkDuration(int minutes) {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.setWorkDuration');
    try {
      return super.setWorkDuration(minutes);
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShortBreakDuration(int minutes) {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.setShortBreakDuration');
    try {
      return super.setShortBreakDuration(minutes);
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLongBreakDuration(int minutes) {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.setLongBreakDuration');
    try {
      return super.setLongBreakDuration(minutes);
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCyclesBeforeLongBreak(int cycles) {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.setCyclesBeforeLongBreak');
    try {
      return super.setCyclesBeforeLongBreak(cycles);
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetToDefaults() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.resetToDefaults');
    try {
      return super.resetToDefaults();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _tick() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase._tick');
    try {
      return super._tick();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchToWork() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.switchToWork');
    try {
      return super.switchToWork();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchToShortBreak() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.switchToShortBreak');
    try {
      return super.switchToShortBreak();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchToLongBreak() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.switchToLongBreak');
    try {
      return super.switchToLongBreak();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void syncOnResume() {
    final _$actionInfo = _$_FocusControllerBaseActionController.startAction(
        name: '_FocusControllerBase.syncOnResume');
    try {
      return super.syncOnResume();
    } finally {
      _$_FocusControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
workDuration: ${workDuration},
shortBreakDuration: ${shortBreakDuration},
longBreakDuration: ${longBreakDuration},
cyclesBeforeLongBreak: ${cyclesBeforeLongBreak},
remainingSeconds: ${remainingSeconds},
isRunning: ${isRunning},
isPaused: ${isPaused},
currentType: ${currentType},
completedPomodoros: ${completedPomodoros},
totalFocusMinutes: ${totalFocusMinutes},
completedSessionCount: ${completedSessionCount},
totalSeconds: ${totalSeconds},
progress: ${progress},
formattedTime: ${formattedTime}
    ''';
  }
}
