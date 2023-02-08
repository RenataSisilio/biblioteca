import 'package:biblioteca/controllers/library_controller.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

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
      body: HomeView(books: list),
    );
  }
}
