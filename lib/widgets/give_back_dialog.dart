import 'package:flutter/material.dart';

import '../get_it.dart';
import '../models/book.dart';
import '../services/controllers/library_controller.dart';
import 'date_picker_form_field.dart';

class GiveBackDialog extends StatelessWidget {
  const GiveBackDialog(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final formKey = GlobalKey<FormState>();
    final date = TextEditingController();

    return AlertDialog(
      content: Form(
        key: formKey,
        child: DatePickerFormField(date, label: 'Data'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.giveBack(book);
            Navigator.of(context).pop();
          },
          child: const Text('DEVOLVER'),
        ),
      ],
    );
  }
}
