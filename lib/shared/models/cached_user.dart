import 'dart:convert';

class CachedUser {
  String? imageUrl;
  String? title;
  String? subtitle;
  String? username;
  DateTime? date;

  CachedUser({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.username,
    this.date,
  }) {
    this.date ??= DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'username': username,
      'date': date?.millisecondsSinceEpoch,
    };
  }

  factory CachedUser.fromMap(Map map) {
    return CachedUser(
      imageUrl: map['imageUrl'],
      title: map['title'],
      subtitle: map['subtitle'],
      username: map['username'],
      date: map['date'] == null
          ? DateTime(1970)
          : DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CachedUser.fromJson(String source) =>
      CachedUser.fromMap(json.decode(source));
}
