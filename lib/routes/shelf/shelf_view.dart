import 'package:flutter/material.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import '../../widgets/book_info.dart';

class ShelfView extends StatelessWidget {
  const ShelfView(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final books = controller.books;
    final shelf = books.where((book) => book.category == category).toList();

    final copy = [...shelf];
    for (var i = 1; i < copy.length; i++) {
      if (copy[i].title == copy[i - 1].title) {
        copy.remove(copy[i]);
        i--;
      }
    }
    
    return ListView.builder(
      itemCount: copy.length,
      itemBuilder: (context, index) => ExpansionTile(
        title: Text(copy[index].title),
        subtitle: Text(copy[index].author ?? ''),
        children: List.from(shelf
            .where((e) => e.title == copy[index].title)
            .map((e) => BookInfo(books.indexOf(e)))),
      ),
    );
  }
}
