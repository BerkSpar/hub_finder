import 'package:hub_finder/shared/models/focus_type.dart';

class FocusSession {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int durationMinutes;
  final FocusType type;
  final bool completed;

  FocusSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.durationMinutes,
    required this.type,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'durationMinutes': durationMinutes,
      'type': type.index,
      'completed': completed,
    };
  }

  factory FocusSession.fromMap(Map map) {
    return FocusSession(
      id: map['id'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      durationMinutes: map['durationMinutes'],
      type: FocusType.values[map['type']],
      completed: map['completed'] ?? false,
    );
  }

  FocusSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    FocusType? type,
    bool? completed,
  }) {
    return FocusSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      type: type ?? this.type,
      completed: completed ?? this.completed,
    );
  }
}
