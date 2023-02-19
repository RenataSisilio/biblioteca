import 'package:flutter/material.dart';

import '../../widgets/bottom_bar.dart';
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.15),
        child: Center(
          child: Image.asset(
            'assets/Minha Biblioteca Contemplativa.png',
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        ),
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
