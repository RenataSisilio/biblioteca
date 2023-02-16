import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/bottom_bar.dart';
import '../get_it.dart';
import '../services/controllers/connection_controller.dart';
import 'home/home_page.dart';
import 'library/library_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final connectionController = getIt.get<ConnectionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca Contemplativa'),
        actions: [
          BlocBuilder<ConnectionController, ConnectState>(
            bloc: connectionController,
            builder: (context, state) {
              return IconButton(
                onPressed: () => connectionController.checkConnection(),
                icon: Icon(state == ConnectState.online
                    ? Icons.sync
                    : Icons.sync_problem),
              );
            },
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          LibraryPage(),
        ],
      ),
      bottomNavigationBar: BottomBar(pageController: pageController),
    );
  }
}
