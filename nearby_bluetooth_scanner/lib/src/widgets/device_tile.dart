import 'package:flutter/material.dart';
import 'package:nearby_bluetooth_scanner/nearby_bluetooth_scanner.dart';

class DeviceTile extends StatelessWidget {
  final ScanResultModel device;
  final void Function()? onTap;

  const DeviceTile({
    super.key,
    required this.device,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bluetooth),
      title: Text(
        device.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(device.id),
      onTap: onTap,
    );
  }
}
