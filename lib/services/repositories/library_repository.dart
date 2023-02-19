import 'dart:async';

import '../../models/book.dart';

abstract class LibraryRepository {
  FutureOr<List<Book>> getBooks();
  FutureOr<void> borrow(Book book, String user, DateTime date);
  FutureOr<void> giveBack(Book book, DateTime date);
  FutureOr<void> update(List<Book> list, LibraryRepository onlineRepo);
  FutureOr<List<String>> getUsers();
}
