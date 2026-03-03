import 'package:torch_light/torch_light.dart';

class FlashSyncService {
  static bool _isOn = false;

  // ⚡ Beat Detect hone par trigger karna
  static Future<void> triggerFlash() async {
    try {
      await TorchLight.enableTorch();
      await Future.delayed(
        const Duration(milliseconds: 50),
      ); // Choti "Burst" flash
      await TorchLight.disableTorch();
    } catch (e) {
      print("Flash error: $e");
    }
  }

  // AI Logic: Sirf un phones par flash chalana jinki battery > 20% hai
  static void smartFlash(double batteryLevel, bool isBeat) {
    if (batteryLevel > 20 && isBeat) {
      triggerFlash();
    }
  }
}
