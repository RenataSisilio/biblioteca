import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import 'library_view.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryController, LibraryState>(
      bloc: getIt.get<LibraryController>(),
      builder: (context, state) {
        if(state == LibraryState.loading){
          return const Center(child: CircularProgressIndicator());
        }
        if (state == LibraryState.error) {
          return const Center(child: Text('Erro'));
        }
          return const LibraryView();
      },
    );
  }
}
