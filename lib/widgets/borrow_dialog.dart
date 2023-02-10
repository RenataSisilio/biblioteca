import 'package:flutter/material.dart';

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
            TextFormField(
              controller: user,
              decoration: const InputDecoration(
                label: Text('Nome'),
              ),
            ),
            DatePickerFormField(date, label: 'Data'),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.borrow(book, user.text);
            Navigator.of(context).pop();
          },
          child: const Text('EMPRESTAR'),
        ),
      ],
    );
  }
}
