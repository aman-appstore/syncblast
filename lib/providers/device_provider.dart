import 'package:flutter_riverpod/flutter_riverpod.dart';

// Device ka model class
class ConnectedDevice {
  final String id;
  final String name;
  final double batteryLevel;
  final bool isMuted;

  ConnectedDevice({
    required this.id,
    required this.name,
    this.batteryLevel = 100,
    this.isMuted = false,
  });
}

// Devices ki list ko manage karne wala provider
class DeviceListNotifier extends StateNotifier<List<ConnectedDevice>> {
  DeviceListNotifier() : super([]);

  void addDevice(ConnectedDevice device) {
    if (!state.any((d) => d.id == device.id)) {
      state = [...state, device];
    }
  }

  void removeDevice(String id) {
    state = [
      for (final d in state)
        if (d.id != id) d,
    ];
  }

  void toggleMute(String id) {
    state = [
      for (final d in state)
        if (d.id == id)
          ConnectedDevice(
            id: d.id,
            name: d.name,
            isMuted: !d.isMuted,
            batteryLevel: d.batteryLevel,
          )
        else
          d,
    ];
  }
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, List<ConnectedDevice>>((ref) {
      return DeviceListNotifier();
    });
