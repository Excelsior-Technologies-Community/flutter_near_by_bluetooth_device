import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceTile extends StatelessWidget {
  final BluetoothDevice device;
  final String advName;

  const DeviceTile({
    super.key,
    required this.device,
    required this.advName,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
    advName.isNotEmpty ? advName : device.platformName.isNotEmpty
        ? device.platformName
        : "Unknown Device";

    return ListTile(
      title: Text(displayName),
      subtitle: Text(device.remoteId.str),
      trailing: const Icon(Icons.bluetooth),
    );
  }
}
