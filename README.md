# 📡 Nearby Bluetooth Scanner

A lightweight and plug-and-play Flutter package to **scan nearby Bluetooth Low Energy (BLE) devices** on **Android & iOS** — without pairing.

---

## ✨ Features

✔ BLE Scan (Android + iOS)  
✔ No pairing required  
✔ Shows device name + MAC/UUID  
✔ Real nearby devices (no dummy values)  
✔ Simple widget – drop & use  
✔ Callback when a device is found  
✔ Works on production apps  

> ⚠️ Note: Only BLE devices are discoverable (classic Bluetooth may not appear)

---

## 🎬 Demo Preview
![nearby bluetooth scanner](https://github.com/user-attachments/assets/d277617e-a9d1-4469-bf97-31806d041bbb)


---

## 📦 Installation
### Add dependency:

```yaml
dependencies:
  nearby_bluetooth_scanner:
    path: '../flutter_near_by_bluetooth/nearby_bluetooth_scanner'
```
##

### Using GitHub (Recommended during development) :
```yaml
dependencies:
  flutter_near_by_bluetooth:
    git:
      url: https://github.com/<your-github>/flutter_near_by_bluetooth.git
```
##

### 🚀 Import:
```dart
import 'package:nearby_bluetooth_scanner/nearby_bluetooth_scanner.dart';
```

---

## 🧩 Usage
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Bluetooth Scanner')),
      body: NearbyBluetoothScanner(
        onDeviceFound: (device) {
          print("${device.name} - ${device.id}");
        },
      ),
    );
  }
}
```

---

## 🔌 Android Setup
Add required permissions in   
`android/app/src/main/AndroidManifest.xml`
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />

<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />

<uses-feature android:name="android.hardware.bluetooth" android:required="false" />
<uses-feature android:name="android.hardware.bluetooth_le" android:required="false" />

<!-- Optional but recommended -->
<service
    android:name="com.reu.bluetooth.flutterblueplus.ForegroundService"
    android:exported="false"/>
```

📌 Make sure:   
- Bluetooth is ON
- GPS / Location ON
- Run on a **real device** (Android emulator does not support Bluetooth)

---

## 🍏 iOS Setup
Open `ios/Runner/Info.plist`   
Add inside `<dict>:`
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app needs Bluetooth to scan nearby devices.</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app uses Bluetooth for BLE scanning.</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Location may be required for scanning BLE devices.</string>
```
📌 Test only on **real iPhone** (iOS Simulator cannot scan BLE)

---

## 📊 Output Behavior
- Shows BLE device name if advertised
- If no name → falls back to `Unknown Device`
- Real nearby devices only — no mock data
- Phones appear ONLY if broadcasting via AirDrop/Nearby Share

---

## 🧪 Best Testing Devices
- Smart watches (Mi Band, Amazfit, Huawei, Fitbit)
- AirPods / BLE earbuds
- BLE beacons / IoT modules
- Phones with Nearby Share / AirDrop ON

---

## 📁 Folder Structure
```text
lib/
├── nearby_bluetooth_scanner.dart
└── src/
    ├── scanner_widget.dart
    ├── bluetooth_manager.dart
    ├── models/
    │   └── scan_result_model.dart
    └── widgets/
        └── device_tile.dart
```

---

## 🪪 License
```text
Copyright (c) 2026 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
