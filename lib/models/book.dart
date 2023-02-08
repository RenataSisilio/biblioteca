import 'dart:convert';

enum Status { borrowed, available }

class Book {
  final String? id;
  final String title;
  final String? author;
  final String category;
  final double number;
  final Status status;
  final String? lastUser;

  String get numStr => number - number.floor() == 0
      ? number.floor().toString()
      : number.toString();

  Book({
    this.id,
    required this.title,
    this.author,
    required this.category,
    required this.number,
    required this.status,
    this.lastUser,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? category,
    double? number,
    Status? status,
    String? lastUser,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      number: number ?? this.number,
      status: status ?? this.status,
      lastUser: lastUser ?? this.lastUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'number': number,
      'status': status.name,
      'lastUser': lastUser,
    };
  }

  factory Book.fromMap({String? id, required Map<String, dynamic> map}) {
    return Book(
      id: id ?? map['id'],
      title: map['title'] as String,
      author: map['author'] != null ? map['author'] as String : null,
      category: map['category'] as String,
      number: double.parse(map['number'].toString()),
      status: Status.values.firstWhere((e) => e.name == map['status']),
      lastUser: map['lastUser'] != null ? map['lastUser'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(map: json.decode(source) as Map<String, dynamic>);
}
