import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book.dart';
import '../repositories/library_repository.dart';

enum LibraryState { loading, success, offlineSuccess, error }

class LibraryController extends Cubit<LibraryState> {
  LibraryController({
    required this.onlineRepo,
    required this.offlineRepo,
  }) : super(LibraryState.loading) {
    getBooks();
  }

  final LibraryRepository onlineRepo;
  final LibraryRepository offlineRepo;
  late final List<Book> books;

  void getBooks() {
    emit(LibraryState.loading);
    try {
      try {
        books = onlineRepo.getBooks();
        emit(LibraryState.success);
      } catch (e) {
        books = offlineRepo.getBooks();
        emit(LibraryState.offlineSuccess);
      }
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  void borrow(Book book, String user) {
    emit(LibraryState.loading);
    try {
      try {
        onlineRepo.borrow(book, user);
        getBooks();
        emit(LibraryState.success);
      } catch (e) {
        offlineRepo.borrow(book, user);
        final index = books.indexWhere(
            (e) => e.title == book.title && e.number == book.number);
        books.removeAt(index);
        books.insert(
          index,
          book.copyWith(status: Status.borrowed, lastUser: user),
        );
        emit(LibraryState.offlineSuccess);
      }
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  void giveBack(Book book) {
    emit(LibraryState.loading);
    try {
      try {
        onlineRepo.giveBack(book);
        getBooks();
        emit(LibraryState.success);
      } catch (e) {
        offlineRepo.giveBack(book);
        final index = books.indexWhere(
            (e) => e.title == book.title && e.number == book.number);
        books.removeAt(index);
        books.insert(index, book.copyWith(status: Status.available));
        emit(LibraryState.offlineSuccess);
      }
    } catch (e) {
      emit(LibraryState.error);
    }
  }
}
