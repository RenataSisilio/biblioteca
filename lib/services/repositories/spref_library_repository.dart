import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/book.dart';
import 'library_repository.dart';

class SPrefLibraryRepository implements LibraryRepository {
  SPrefLibraryRepository();

  late final SharedPreferences sPref;

  Future<void> init() async {
    try {
      sPref = await SharedPreferences.getInstance();
    } catch (e) {
      if (sPref == await SharedPreferences.getInstance()) {
        log('SharedPreferences already initialized');
      } else {
        rethrow;
      }
    }
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

    final List<Map<String, dynamic>> update =
        json.decode(sPref.getString('update') ?? '');
    update.add({
      'user': user,
      'book': book.id,
      'date': date.millisecondsSinceEpoch,
      'status': Status.borrowed.name,
    });
    await sPref.setString('update', json.encode(update));
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

    final List<Map<String, dynamic>> update =
        json.decode(sPref.getString('update') ?? '');
    update.add({
      'user': book.lastUser,
      'book': book.id,
      'date': date.millisecondsSinceEpoch,
      'status': Status.available.name,
    });
    await sPref.setString('update', json.encode(update));
  }

  @override
  Future<void> update(List<Book> list, LibraryRepository onlineRepo) async {
    final updateStr =
        sPref.containsKey('update') ? sPref.getString('update') ?? '' : '';
    if (updateStr != '') {
      final List<Map<String, dynamic>> update = json.decode(updateStr);
      try {
        for (var map in update) {
          final book = list.firstWhere((book) => book.id == map['book']);
          switch (map['status']) {
            case 'available':
              if (book.status == Status.borrowed) {
                try {
                  await onlineRepo.giveBack(book, map['date']);
                } catch (e) {
                  rethrow;
                }
              }
              break;
            case 'borrowed':
              if (book.status == Status.available) {
                await onlineRepo.borrow(book, map['user'], map['date']);
              }
              break;
          }
        }
        await sPref.setString('update', '[]');
      } catch (e) {
        rethrow;
      }
    }

    final mapList = list.map((e) => e.toMap()).toList();
    final encoded = json.encode(mapList);
    await sPref.setString('library', encoded);
  }

  @override
  FutureOr<List<String>> getUsers() {
    return [];
  }
}
