import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../get_it.dart';
import '../models/book.dart';
import '../services/controllers/library_controller.dart';
import 'date_picker_form_field.dart';
import 'user_name_form_field.dart';

class BorrowDialog extends StatelessWidget {
  const BorrowDialog(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final formKey = GlobalKey<FormState>();
    final user = TextEditingController();
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserNameFormField(user),
                      DatePickerFormField(date),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final dateSave =
                          DateFormat('dd/MM/yyyy').parse(date.text);
                      await controller.borrow(book, user.text, dateSave);
                      navigator.pop();
                    },
                    child: const Text('EMPRESTAR'),
                  ),
                ],
              );
      },
    );
  }
}
