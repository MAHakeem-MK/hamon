import 'package:connectivity/connectivity.dart';

class NetworkInfo {
  Future<bool> get isConnected async {
    return (await Connectivity().checkConnectivity() != ConnectivityResult.none);
  }
}
