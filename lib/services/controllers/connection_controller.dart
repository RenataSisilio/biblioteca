import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectState { online, offline }

class ConnectionController extends Cubit<ConnectState> {
  ConnectionController() : super(ConnectState.offline) {
    checkConnection();
    init();
  }

  void init() async {
    while (true) {
      await Future.delayed(const Duration(minutes: 5));
      checkConnection();
    }
  }

  Future<void> checkConnection() async {
    final connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none &&
        connection != ConnectivityResult.bluetooth) {
      emit(ConnectState.online);
    } else {
      emit(ConnectState.offline);
    }
  }
}
