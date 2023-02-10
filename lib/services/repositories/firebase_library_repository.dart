
import '../../models/book.dart';
import 'library_repository.dart';

class FirebaseLibraryRepository implements LibraryRepository {
  @override
  void borrow(Book book, String user) {
    try {
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Book> getBooks() {
    try {
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void giveBack(Book book) {
    try {
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
