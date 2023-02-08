import 'package:flutter/material.dart';

import '../../controllers/library_controller.dart';
import '../../widgets/bottom_bar.dart';
import 'home_view.dart';
import 'library_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = LibraryController();
    final list = controller.getBooks();
    final pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca Contemplativa'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeView(books: list),
          LibraryView(books: list),
        ],
      ),
      bottomNavigationBar: BottomBar(pageController: pageController),
    );
  }
}
