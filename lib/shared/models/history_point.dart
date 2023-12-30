class HistoryPoint {
  final DateTime date;
  final double value;

  HistoryPoint({
    required this.date,
    this.value = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.millisecondsSinceEpoch,
      'value': value,
    };
  }

  factory HistoryPoint.fromMap(Map map) {
    return HistoryPoint(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      value: map['value'],
    );
  }
}
