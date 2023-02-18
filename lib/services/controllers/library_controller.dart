import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book.dart';
import '../repositories/library_repository.dart';

enum LibraryState { loading, saving, success, offlineSuccess, error }

class LibraryController extends Cubit<LibraryState> {
  LibraryController({
    required this.onlineRepo,
    required this.offlineRepo,
  }) : super(LibraryState.loading);

  final LibraryRepository onlineRepo;
  final LibraryRepository offlineRepo;
  late List<Book> books;

  void getBooks() async {
    emit(LibraryState.loading);
    try {
      try {
        books = await onlineRepo.getBooks();
        await offlineRepo.update(books, onlineRepo);
        emit(LibraryState.success);
      } catch (e) {
        books = await offlineRepo.getBooks();
        emit(LibraryState.offlineSuccess);
      }
    } catch (e) {
      emit(LibraryState.error);
    }
  }

  List<String> getCategories() {
    final categories = books.fold(<String>[], (previousValue, book) {
      if (!previousValue.contains(book.category)) {
        previousValue.add(book.category);
      }
      return previousValue;
    });
    categories.sort((a, b) => a.compareTo(b));
    return categories;
  }

  Future<void> borrow(Book book, String user, DateTime date) async {
    emit(LibraryState.saving);
    try {
      try {
        await onlineRepo.borrow(book, user, date);
        final index = books.indexWhere((e) => e.id == book.id);
        books.removeAt(index);
        books.insert(
          index,
          book.copyWith(status: Status.borrowed, lastUser: user),
        );
        // offlineRepo.borrow(book, user, date);
        emit(LibraryState.success);
      } catch (e) {
        offlineRepo.borrow(book, user, date);
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

  Future<void> giveBack(Book book, DateTime date) async {
    emit(LibraryState.saving);
    try {
      try {
        await onlineRepo.giveBack(book, date);
        final index = books.indexWhere((e) => e.id == book.id);
        books.removeAt(index);
        books.insert(
          index,
          book.copyWith(status: Status.available),
        );
        // offlineRepo.giveBack(book, date);
        emit(LibraryState.success);
      } catch (e) {
        offlineRepo.giveBack(book, date);
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
