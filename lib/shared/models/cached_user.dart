import 'dart:convert';

class CachedUser {
  String? imageUrl;
  String? title;
  String? subtitle;
  String? username;

  CachedUser({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'username': username,
    };
  }

  factory CachedUser.fromMap(Map map) {
    return CachedUser(
      imageUrl: map['imageUrl'],
      title: map['title'],
      subtitle: map['subtitle'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CachedUser.fromJson(String source) =>
      CachedUser.fromMap(json.decode(source));
}
