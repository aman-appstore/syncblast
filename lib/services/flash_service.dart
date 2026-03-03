import 'package:torch_light/torch_light.dart';

class FlashSyncService {
  static bool isOn = false;

  static Future<void> triggerFlash() async {
    if (isOn) return;
    try {
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(milliseconds: 50));
      await TorchLight.disableTorch();
    } catch (e) {
      print("Flash error: $e");
    }
  }

  static void smartFlash(double batteryLevel, bool isBeat) {
    if (batteryLevel > 20 && isBeat) {
      triggerFlash();
    }
  }
}
