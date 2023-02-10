
import 'dart:convert';
import 'dart:io';

import '../../models/book.dart';
import 'library_repository.dart';

class LocalStorageLibraryRepository implements LibraryRepository {
  final String filePath;

  LocalStorageLibraryRepository(this.filePath);

  @override
  void borrow(Book book, String user) {
    final books = getBooks();
    for (var i = 0; i < books.length; i++) {
      if (book.title == books[i].title && book.number == books[i].number) {
        books.removeAt(i);
        books.insert(i, book.copyWith(status: Status.borrowed, lastUser: user));
      }
    }
    final mapList = books.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    File(filePath).writeAsStringSync(encoded);
  }

  @override
  List<Book> getBooks() {
    final file = json.decode(File(filePath).readAsStringSync());
    final mapped = file.map(
        (e) => Book.fromMap(map: e as Map<String, dynamic>),
      );
    return List.from(
      mapped,
    );
  }

  @override
  void giveBack(Book book) {
    final books = getBooks();
    for (var i = 0; i < books.length; i++) {
      if (book.title == books[i].title && book.number == books[i].number) {
        books.removeAt(i);
        books.insert(i, book.copyWith(status: Status.available));
      }
    }
    final mapList = books.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    File(filePath).writeAsStringSync(encoded);
  }
}
