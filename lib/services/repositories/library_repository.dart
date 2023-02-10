import '../../models/book.dart';

abstract class LibraryRepository {
  List<Book> getBooks();
  void borrow(Book book, String user);
  void giveBack(Book book);
}
