import 'dart:convert';

class Book {
  String id;
  String title;
  String author;
  String description;
  bool borrowed;
  DateTime? borrowedAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.description = '',
    this.borrowed = false,
    this.borrowedAt,
  });

  factory Book.fromMap(Map<String, dynamic> m) => Book(
        id: m['id'] as String,
        title: m['title'] as String,
        author: m['author'] as String,
        description: m['description'] as String? ?? '',
        borrowed: m['borrowed'] as bool? ?? false,
        borrowedAt: m['borrowedAt'] != null ? DateTime.parse(m['borrowedAt']) : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'borrowed': borrowed,
        'borrowedAt': borrowedAt?.toIso8601String(),
      };

  String toJson() => jsonEncode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(jsonDecode(source));
}