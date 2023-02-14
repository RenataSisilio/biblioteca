import 'package:biblioteca/services/controllers/library_controller.dart';
import 'package:biblioteca/services/repositories/firebase_library_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

enum SplashState { loading, online, offline }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);

  void init({
    required FirebaseLibraryRepository firestore,
    required LibraryController libraryController,
  }) async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      firestore.init();
      libraryController.getBooks();
      emit(SplashState.online);
    } catch (e) {
      emit(SplashState.offline);
    }
  }
}
