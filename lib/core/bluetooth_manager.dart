import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothManager {
  StreamSubscription? scanSubscription;
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

  void startScan(void Function(BluetoothDevice device) onDeviceFound) async {
    bool granted = await requestPermissions();
    if (!granted || !adapterReady) {
      await FlutterBluePlus.turnOn();
      return;
    }

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));

    scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (var r in results) {
        onDeviceFound(r.device);
      }
    });

  }

  void stopScan() {
    FlutterBluePlus.stopScan();
    scanSubscription?.cancel();
    adapterSubscription?.cancel();
  }
}
