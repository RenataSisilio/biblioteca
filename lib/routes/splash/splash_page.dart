import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../get_it.dart';
import '../../services/controllers/library_controller.dart';
import '../../services/repositories/firebase_library_repository.dart';
import '../../services/repositories/spref_library_repository.dart';
import '../main_page.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeDependencyInjection();
      controller.init(
        firestore: getIt.get<FirebaseLibraryRepository>(),
        libraryController: getIt.get<LibraryController>(),
        sPrefRepository: getIt.get<SPrefLibraryRepository>(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashController, SplashState>(
        bloc: controller,
        listener: (context, state) {
          if (state == SplashState.online || state == SplashState.offline) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
