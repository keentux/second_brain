import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConnectivityCheckerHelper {
  /// Check internet connetion, true if connected, false otherwise
  Future<bool> checkConnectivity() async {
    final bool connected;
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn) {
      connected = true;
    } else {
      connected = false;
    }
    // return _handleResult(connectivityResult);
    return connected;
  }

  /// Return stream to listen conenctivity changes
  static Stream<ConnectivityResult> listenToConnectivityChanged() {
    return Connectivity().onConnectivityChanged;
  }
}
