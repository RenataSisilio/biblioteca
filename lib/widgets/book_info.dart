import 'package:flutter/material.dart';

import '../models/book.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({
    super.key,
    required this.selectedBook,
  });

  final Book selectedBook;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(selectedBook.title),
            Text(selectedBook.author ?? ''),
            Text(selectedBook.category),
            Text(selectedBook.numStr),
            selectedBook.status == Status.available
                ? const Text('Disponível')
                : Text('Emprestado para ${selectedBook.lastUser}'),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Emprestar'),
                  ),
                ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
