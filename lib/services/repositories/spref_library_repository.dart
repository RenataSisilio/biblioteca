import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/book.dart';
import 'library_repository.dart';

class SPrefLibraryRepository implements LibraryRepository {
  SPrefLibraryRepository();

  late final SharedPreferences sPref;

  Future<void> init() async {
    sPref = await SharedPreferences.getInstance();
  }

  @override
  void borrow(Book book, String user, DateTime date) async {
    final books = getBooks();
    for (var i = 0; i < books.length; i++) {
      if (book.title == books[i].title && book.number == books[i].number) {
        books.removeAt(i);
        books.insert(i, book.copyWith(status: Status.borrowed, lastUser: user));
      }
    }
    final mapList = books.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    await sPref.setString('library', encoded);
  }

  @override
  List<Book> getBooks() {
    final file = json.decode(sPref.getString('library') ?? '');
    final mapped = file.map(
      (e) => Book.fromMap(map: e as Map<String, dynamic>),
    );
    return List.from(mapped);
  }

  @override
  void giveBack(Book book, DateTime date) async {
    final books = getBooks();
    for (var i = 0; i < books.length; i++) {
      if (book.title == books[i].title && book.number == books[i].number) {
        books.removeAt(i);
        books.insert(i, book.copyWith(status: Status.available));
      }
    }
    final mapList = books.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    await sPref.setString('library', encoded);
  }

  @override
  Future<void> update(List<Book> list) async {
    final mapList = list.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    await sPref.setString('library', encoded);
    // TODO: sync offline info to firebase (ask user?)
  }
}
