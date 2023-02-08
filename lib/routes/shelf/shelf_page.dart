import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../widgets/book_info.dart';

class ShelfView extends StatelessWidget {
  const ShelfView({
    super.key,
    required this.books,
    required this.category,
  });

  final List<Book> books;
  final String category;

  @override
  Widget build(BuildContext context) {
    final shelf = books.where((book) => book.category == category).toList();
    final copy = [...shelf];
    for (var i = 1; i < copy.length; i++) {
      if (copy[i].title == copy[i - 1].title) {
        copy.remove(copy[i]);
        i--;
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        itemCount: copy.length,
        itemBuilder: (context, index) => ExpansionTile(
          title: Text(copy[index].title),
          subtitle: Text(copy[index].author ?? ''),
          children: List.from(shelf
              .where((e) => e.title == copy[index].title)
              .map((e) => BookInfo(selectedBook: e))),
        ),
      ),
    );
  }
}
