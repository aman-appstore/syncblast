import 'package:vibration/vibration.dart';

class HapticPulseEngine {
  // 💓 Beat par halki vibration (Premium Pulse)
  static void triggerBeatPulse() async {
    if (await Vibration.hasVibrator() ?? false) {
      // Sirf 10ms ki vibration jo music ki beat feel karwaye
      Vibration.vibrate(duration: 10, amplitude: 128);
    }
  }

  // ⚠️ Warning Vibration (Jab device disconnect ho)
  static void triggerWarning() {
    Vibration.vibrate(pattern: [0, 100, 50, 100]);
  }
}
