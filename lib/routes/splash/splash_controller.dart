import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../../services/controllers/library_controller.dart';
import '../../services/repositories/firebase_library_repository.dart';
import '../../services/repositories/spref_library_repository.dart';

enum SplashState { loading, online, offline }

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashState.loading);

  void init({
    required FirebaseLibraryRepository firestore,
    required LibraryController libraryController,
    SPrefLibraryRepository? sPrefRepository,
  }) async {
    try {
      final connection = await Connectivity().checkConnectivity();
      if (connection != ConnectivityResult.none &&
          connection != ConnectivityResult.bluetooth) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        firestore.init();
      }
      await sPrefRepository?.init();
      await libraryController.getBooks();
      emit(SplashState.online);
    } catch (e) {
      await sPrefRepository?.init();
      await libraryController.getBooks();
      emit(SplashState.offline);
    }
  }
}
