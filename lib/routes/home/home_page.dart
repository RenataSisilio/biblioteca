import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import 'home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryController, LibraryState>(
      bloc: getIt.get<LibraryController>(),
      builder: (context, state) {
        if (state == LibraryState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state == LibraryState.error) {
          return const Center(child: Text('Erro'));
        }
        return const HomeView();
      },
    );
  }
}
