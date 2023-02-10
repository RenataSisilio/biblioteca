import 'package:flutter/material.dart';

import '../get_it.dart';
import '../models/book.dart';
import '../services/controllers/library_controller.dart';
import 'borrow_dialog.dart';
import 'give_back_dialog.dart';

class BookInfo extends StatefulWidget {
  const BookInfo(this.bookIndex, {super.key});

  final int bookIndex;

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final controller = getIt.get<LibraryController>();

  @override
  Widget build(BuildContext context) {
    Book book = controller.books[widget.bookIndex];

    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(book.title),
            Text(book.author ?? ''),
            Text(book.category),
            Text(book.numStr),
            book.status == Status.available
                ? const Text('Disponível')
                : Text('Emprestado para ${book.lastUser}'),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => BorrowDialog(book),
                    ).then((_) => setState(() {})),
                    child: const Text('Emprestar'),
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => GiveBackDialog(book),
                    ).then((_) => setState(() {})),
                    child: const Text('Devolver'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
