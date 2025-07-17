import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

enum NetworkStatus { connected, disconnected, connecting }

class NetworkCheckController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final Rx<NetworkStatus> networkStatus = NetworkStatus.connected.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      networkStatus.value = NetworkStatus.disconnected;
    } else {
      // Only set to connected if previously disconnected
      if (networkStatus.value == NetworkStatus.disconnected) {
        networkStatus.value = NetworkStatus.connected;
      } else {
        networkStatus.value = NetworkStatus.connected;
      }
    }
  }
}
