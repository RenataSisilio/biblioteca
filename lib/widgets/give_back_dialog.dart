import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

    return BlocBuilder<LibraryController, LibraryState>(
      bloc: controller,
      builder: (context, state) {
        return state == LibraryState.saving
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : AlertDialog(
                content: Form(
                  key: formKey,
                  child: DatePickerFormField(date),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final dateSave =
                          DateFormat('dd/MM/yyyy').parse(date.text);
                      await controller.giveBack(book, dateSave);
                      navigator.pop();
                    },
                    child: const Text('DEVOLVER'),
                  ),
                ],
              );
      },
    );
  }
}
