import 'package:get_it/get_it.dart';

import 'services/controllers/connection_controller.dart';
import 'services/controllers/library_controller.dart';
import 'services/repositories/firebase_library_repository.dart';
import 'services/repositories/spref_library_repository.dart';
import 'services/repositories/local_storage_library_repository.dart';

final getIt = GetIt.instance;

void initializeDependencyInjection() {
  getIt.registerSingleton<ConnectionController>(ConnectionController());
  getIt.registerSingleton<FirebaseLibraryRepository>(
    FirebaseLibraryRepository(),
  );
  getIt.registerSingleton<LocalStorageLibraryRepository>(
    LocalStorageLibraryRepository('lib/data.json'),
  );
  getIt.registerSingleton<SPrefLibraryRepository>(SPrefLibraryRepository());
  getIt.registerSingleton<LibraryController>(
    LibraryController(
      onlineRepo: getIt.get<FirebaseLibraryRepository>(),
      offlineRepo: getIt.get<SPrefLibraryRepository>(),
    ),
  );
}
