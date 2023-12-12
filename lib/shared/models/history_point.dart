class HistoryPoint {
  final DateTime date;
  final double value;

  HistoryPoint({
    required this.date,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'value': value,
    };
  }

  factory HistoryPoint.fromMap(Map<String, dynamic> map) {
    return HistoryPoint(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      value: map['value'],
    );
  }
}
