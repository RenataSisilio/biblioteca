import 'package:biblioteca/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/controllers/library_controller.dart';
import 'library_view.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryController, LibraryState>(
      bloc: getIt.get<LibraryController>(),
      builder: (context, state) {
        if (state == LibraryState.success ||
            state == LibraryState.offlineSuccess) {
          return const LibraryView();
        }
        if (state == LibraryState.error) {
          return const Center(child: Text('Erro'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
