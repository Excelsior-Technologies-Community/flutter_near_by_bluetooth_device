import 'package:flutter/material.dart';
import '../core/bluetooth_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../widgets/device_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BluetoothManager bluetoothManager = BluetoothManager();
  final List<ScanResult> scanResults = [];
  bool isScanning = false;

  void startScanning() {
    setState(() {
      scanResults.clear();
      isScanning = true;
    });

    bluetoothManager.scanSubscription =
        FlutterBluePlus.scanResults.listen((results) {
          for (var r in results) {
            if (!scanResults.any((e) => e.device.remoteId == r.device.remoteId)) {
              setState(() {
                scanResults.add(r);
              });
            }
          }
        });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));

    Future.delayed(const Duration(seconds: 6), () {
      setState(() => isScanning = false);
    });
  }

  @override
  void dispose() {
    bluetoothManager.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Bluetooth Devices")),

      floatingActionButton: FloatingActionButton(
        onPressed: isScanning ? null : startScanning,
        child: Icon(isScanning ? Icons.sync : Icons.search),
      ),

      body: scanResults.isEmpty
          ? Center(
        child: Text(
          isScanning
              ? "Scanning...\nBluetooth & Location ON rakho"
              : "No Devices Found\nTap Search",
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: scanResults.length,
        itemBuilder: (_, i) {
          final r = scanResults[i];
          return DeviceTile(
            device: r.device,
            advName: r.advertisementData.advName,
          );
        },
      ),
    );
  }
}
