import 'package:connectivity_plus/connectivity_plus.dart';

class InternetUtil {

  static Future<bool> isConnected() async {
    List<ConnectivityResult> result = await getConnectivityStatus();
    return isStateConnected(result);
  }

  static Future<List<ConnectivityResult>> getConnectivityStatus() async {
    return await (Connectivity().checkConnectivity());
  }

  static bool isStateConnected(List<ConnectivityResult> result) {
    return result.contains(ConnectivityResult.mobile)
        || result.contains(ConnectivityResult.wifi)
        || result.contains(ConnectivityResult.other);
  }

  static bool isStateConnectedToWifi(ConnectivityResult result) {
    return result == ConnectivityResult.wifi;
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile )) {
      // Mobile network detected
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-Fi network detected
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      // No network connection
    }
  }
}