import 'package:flutter/scheduler.dart';

class PerformanceGuard {
  static void optimizeFrameRate(bool isAppInBackground) {
    if (isAppInBackground) {
      // Background mein animations ko 10 FPS par le aao battery bachane ke liye
      timeDilation = 5.0;
    } else {
      // Foreground mein wapas "Makhan" 120Hz/60Hz smoothness
      timeDilation = 1.0;
    }
  }
}
