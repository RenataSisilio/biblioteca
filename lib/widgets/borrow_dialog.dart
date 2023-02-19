import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../get_it.dart';
import '../models/book.dart';
import '../services/controllers/library_controller.dart';
import 'date_picker_form_field.dart';

class BorrowDialog extends StatelessWidget {
  const BorrowDialog(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final formKey = GlobalKey<FormState>();
    final user = TextEditingController();
    final date = TextEditingController();

    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Autocomplete(
              fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) =>
                  TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (String value) {
                  onFieldSubmitted();
                },
                decoration: InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                final List<String> result = controller.users.fold(
                  <String>[],
                  (res, element) {
                    if (element.toLowerCase().startsWith(
                          textEditingValue.text.toLowerCase(),
                        )) {
                      res.add(element);
                    }
                    return res;
                  },
                ).toList();
                result.addAll(
                  controller.users
                      .where(
                        (element) => element.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                      )
                      .where((element) => !result.contains(element)),
                );
                user.text = textEditingValue.text;
                return result;
              },
              onSelected: (option) => user.text = option,
            ),
            DatePickerFormField(date, label: 'Data'),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            final dateSave = DateFormat('dd/MM/yyyy').parse(date.text);
            await controller.borrow(book, user.text, dateSave);
            navigator.pop();
          },
          child: const Text('EMPRESTAR'),
        ),
      ],
    );
  }
}
