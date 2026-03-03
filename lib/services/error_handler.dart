import 'dart:io';

class TribeGuard {
  // 🛡️ Auto-Reconnect Logic
  static void monitorConnection(String masterIP, Function onReconnect) {
    // Agar 5 seconds tak Master se packet nahi aaya, toh re-discovery shuru karo
    Stream.periodic(const Duration(seconds: 5)).listen((_) async {
      final isAlive = await _checkMasterPulse(masterIP);
      if (!isAlive) {
        print("Connection Lost! Re-joining Tribe...");
        onReconnect();
      }
    });
  }

  static Future<bool> _checkMasterPulse(String ip) async {
    try {
      final result = await InternetAddress.lookup(
        ip,
      ).timeout(const Duration(seconds: 2));
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
