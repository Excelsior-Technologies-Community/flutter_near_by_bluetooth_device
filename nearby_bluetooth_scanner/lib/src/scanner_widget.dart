import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nearby_bluetooth_scanner/src/widgets/device_tile.dart';
import 'bluetooth_manager.dart';
import 'models/scan_result_model.dart';

class NearbyBluetoothScanner extends StatefulWidget {
  final Function(ScanResultModel)? onDeviceFound;

  const NearbyBluetoothScanner({super.key, this.onDeviceFound});

  @override
  State<NearbyBluetoothScanner> createState() => _NearbyBluetoothScannerState();
}

class _NearbyBluetoothScannerState extends State<NearbyBluetoothScanner> {
  final BluetoothManager manager = BluetoothManager();
  final List<ScanResult> scanResults = [];
  bool scanning = false;

  void startScan() async {
    bool allowed = await manager.requestPermissions();
    if (!allowed) return;

    setState(() {
      scanResults.clear();
      scanning = true;
    });

    FlutterBluePlus.scanResults.listen((results) {
      for (var r in results) {
        if (!scanResults.any((e) => e.device.remoteId == r.device.remoteId)) {
          scanResults.add(r);

          final model = ScanResultModel(
            name: r.advertisementData.advName.isNotEmpty
                ? r.advertisementData.advName
                : r.device.platformName.isNotEmpty
                ? r.device.platformName
                : "Unknown Device",
            id: r.device.remoteId.str,
          );

          widget.onDeviceFound?.call(model);
          setState(() {});
        }
      }
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));

    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() => scanning = false);
      }
    });
  }

  @override
  void dispose() {
    manager.dispose();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: Icon(scanning ? Icons.sync : Icons.search),
          onPressed: scanning ? null : startScan,
          label: const Text("Scan Devices"),
        ),
        Expanded(
          child: scanResults.isEmpty
              ? const Center(child: Text("No Devices"))
              : ListView.builder(
            itemCount: scanResults.length,
            itemBuilder: (_, i) {
              final r = scanResults[i];
              final advName = r.advertisementData.advName;
              final name = advName.isNotEmpty
                  ? advName
                  : r.device.platformName.isNotEmpty
                  ? r.device.platformName
                  : "Unknown Device";

              return DeviceTile(
                device: ScanResultModel(
                  name: name,
                  id: r.device.remoteId.str,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
