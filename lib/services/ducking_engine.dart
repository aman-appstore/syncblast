import 'dart:async';

class DuckingEngine {
  double _currentVolume = 1.0;
  Timer? _fadeTimer;

  // 🔊 Fade Out: Jab Master Mic On kare
  void fadeOut(Function(double) onUpdate) {
    _fadeTimer?.cancel();
    _fadeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentVolume > 0.2) {
        _currentVolume -= 0.1;
        onUpdate(_currentVolume);
      } else {
        timer.cancel();
      }
    });
  }

  // 🔉 Fade In: Jab Master Mic Off kare
  void fadeIn(Function(double) onUpdate) {
    _fadeTimer?.cancel();
    _fadeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_currentVolume < 1.0) {
        _currentVolume += 0.1;
        onUpdate(_currentVolume);
      } else {
        timer.cancel();
      }
    });
  }
}
