import 'package:syncblast/services/audio_engine.dart';

class GlobalCommandService {
  // 🛑 EMERGENCY STOP: Saare Slaves ko turant kill karna
  static void sendKillSignal(String broadcastIP) {
    final String command = "COMMAND|SYSTEM_KILL|NOW";
    // Hum AudioEngine ka vahi socket use karenge jo Part 5 mein banaya tha
    // Line 8:
    AudioEngine.sendRawCommand(command, broadcastIP);
  }

  // 🔊 SYNC VOLUME: Sabhi phones ka volume ek saath 100% karna (Drop ke waqt)
  static void blastVolume(String broadcastIP) {
    final String command = "COMMAND|VOLUME_SET|1.0";
    // Line 14:
    AudioEngine.sendRawCommand(command, broadcastIP);
  }
}
