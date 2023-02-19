import 'package:flutter/material.dart';

import '../get_it.dart';
import '../services/controllers/library_controller.dart';

class UserNameFormField extends StatelessWidget {
  const UserNameFormField(this.user, {super.key});

  final TextEditingController user;

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    return Autocomplete(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
        decoration: const InputDecoration(
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
    );
  }
}
