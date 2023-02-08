import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/book.dart';

enum LibraryState { loading, success, offline, error }

class LibraryController extends Cubit<LibraryState> {
  LibraryController() : super(LibraryState.loading);

  List<Book> getBooks() {
    try {
      // get from cloud
      throw Exception();
    } catch (e) {
      final file = json.decode(File('lib/data.json').readAsStringSync());
      final dyn = file.map(
        (e) => Book.fromMap(map: e as Map<String, dynamic>),
      );
      return List.from(dyn);
    }
  }
}
