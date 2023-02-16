import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import 'shelf_view.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: BlocBuilder<LibraryController, LibraryState>(
        bloc: getIt.get<LibraryController>(),
        builder: (context, state) {
          if (state == LibraryState.loading) {
          return const Center(child: CircularProgressIndicator());
          }
          if (state == LibraryState.error) {
            return const Center(child: Text('Erro'));
          }
            return ShelfView(category);
        },
      ),
    );
  }
}
