import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/book.dart';
import 'library_repository.dart';

class FirebaseLibraryRepository implements LibraryRepository {
  late final FirebaseFirestore? firestore;

  FirebaseLibraryRepository();

  init() {
    try {
      firestore = FirebaseFirestore.instance;
    } catch (e) {
      firestore = null;
    }
  }

  @override
  Future<void> borrow(Book book, String user, DateTime date) async {
    try {
      final map =
          book.copyWith(status: Status.borrowed, lastUser: user).toMap();
      map.remove('id');
      await firestore!.collection('books').doc(book.id).set(map);
      await firestore!.collection('users').doc(user).collection('moves').add(
        {
          'status': Status.borrowed.name,
          'date': date.millisecondsSinceEpoch,
          'book': book.id,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Book>> getBooks() async {
    try {
      final snapshot =
          await firestore!.collection('books').orderBy('title').get();
      final docs = snapshot.docs;
      final library = <Book>[];
      for (var doc in docs) {
        final data = doc.data();
        data.addAll({'id': doc.id});
        library.add(Book.fromMap(map: data));
      }
      return library;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> giveBack(Book book, DateTime date) async {
    try {
      final map = book.copyWith(status: Status.available).toMap();
      map.remove('id');
      await firestore!.collection('books').doc(book.id).set(map);
      await firestore!.collection('users').doc(book.lastUser).collection('moves').add(
        {
          'status': Status.available.name,
          'date': date.millisecondsSinceEpoch,
          'book': book.id,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  void update(List<Book> list) {
    // unnecessary, it's already online
  }
}
