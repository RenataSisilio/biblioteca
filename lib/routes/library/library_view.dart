import 'package:flutter/material.dart';

import '../../services/controllers/library_controller.dart';
import '../../get_it.dart';
import '../shelf/shelf_page.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LibraryController>();
    final categories = controller.getCategories();

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ShelfPage(categories[index]),
          ),
        ),
        title: Text(categories[index]),
      ),
    );
  }
}
