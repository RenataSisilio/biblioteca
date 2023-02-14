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
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                book.numStr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey),
              ),
            ),
            Text(
              book.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              book.author ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: OverflowBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    book.category,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: book.status == Status.available
                            ? Colors.green
                            : Colors.red,
                        radius: 4,
                      ),
                      Text(
                        book.status == Status.available
                            ? ' Disponível'
                            : ' Emprestado\n para ${book.lastUser}',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(4.0))),
                    onPressed: () => book.status != Status.borrowed
                        ? showDialog(
                            context: context,
                            builder: (context) => BorrowDialog(book),
                          ).then((_) => setState(() {}))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Este livro já está emprestado'),
                            ),
                          ),
                    child: const Text(
                      'Emprestar',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(4.0))),
                    onPressed: () => book.status != Status.available
                        ? showDialog(
                            context: context,
                            builder: (context) => GiveBackDialog(book),
                          ).then((_) => setState(() {}))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Este livro não está emprestado'),
                            ),
                          ),
                    child: const Text(
                      'Devolver',
                      textAlign: TextAlign.center,
                    ),
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
