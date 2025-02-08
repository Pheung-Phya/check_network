import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxList<ConnectivityResult> connectionStatus =
      RxList<ConnectivityResult>();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } on Platform catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    connectionStatus.assignAll(result);
    print('Connectivity changed: $connectionStatus');
    bool hasInternet =
        result.any((status) => status != ConnectivityResult.none);
    isConnected.value = hasInternet;

    if (hasInternet) {
      print('fetch product information');
    }
  }
}
