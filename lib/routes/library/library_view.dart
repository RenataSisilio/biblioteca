import 'package:flutter/material.dart';

import '../../services/controllers/library_controller.dart';
import '../../get_it.dart';
import '../shelf/shelf_page.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final books = controller.books;
    final categories = books.fold(<String>[], (previousValue, book) {
      if (!previousValue.contains(book.category)) {
        previousValue.add(book.category);
      }
      return previousValue;
    });
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShelfView(
              books: books,
              category: categories[index],
            ),
          ),
        ),
        title: Text(categories[index]),
      ),
    );
  }
}
