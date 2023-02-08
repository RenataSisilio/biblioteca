import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../shelf/shelf_page.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
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
