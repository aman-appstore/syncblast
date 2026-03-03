import 'package:flutter_riverpod/flutter_riverpod.dart';

class AISettings {
  final bool autoTuneEnabled;
  final bool batteryGuard;
  final bool duckingEnabled;

  AISettings({
    this.autoTuneEnabled = true,
    this.batteryGuard = true,
    this.duckingEnabled = true,
  });
}

final aiSettingsProvider = StateProvider<AISettings>((ref) => AISettings());
