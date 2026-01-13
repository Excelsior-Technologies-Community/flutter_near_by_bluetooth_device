import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothManager {
  StreamSubscription? adapterSubscription;
  bool adapterReady = false;

  BluetoothManager() {
    adapterSubscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
          adapterReady = state == BluetoothAdapterState.on;
        });
  }

  Future<bool> requestPermissions() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();

    return await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted &&
        await Permission.location.isGranted;
  }

  void dispose() {
    adapterSubscription?.cancel();
  }
}
