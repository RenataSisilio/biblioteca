import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../widgets/book_info.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.books});

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final selectedBook = ValueNotifier<Book?>(null);
    final copy = [...books];
    for (var i = 1; i < copy.length; i++) {
      if (copy[i].title == copy[i - 1].title) {
        copy.remove(copy[i]);
        i--;
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Busque seu livro:'),
              Autocomplete(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<Book>.empty();
                  }
                  final List<Book> result = copy.fold(
                    <Book>[],
                    (res, element) {
                      if (element.title.toLowerCase().startsWith(
                            textEditingValue.text.toLowerCase(),
                          )) {
                        res.add(element);
                      }
                      return res;
                    },
                  ).toList();
                  result.addAll(
                    copy.where(
                      (element) => element.title.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          ),
                    ),
                  );
                  return result;
                },
                displayStringForOption: (option) => option.title,
                onSelected: (option) => selectedBook.value = option,
              ),
              const SizedBox(height: 24.0),
              ValueListenableBuilder(
                valueListenable: selectedBook,
                builder: (context, value, child) {
                  if (value == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: List.from(
                      books
                          .where(
                              (book) => book.title == selectedBook.value?.title)
                          .map(
                        (e) => BookInfo(selectedBook: e),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
