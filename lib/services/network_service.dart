import 'dart:io';
import 'dart:convert';
import 'dart:async';

class NetworkService {
  static const int port = 8888; // SyncBlast dedicated port
  RawDatagramSocket? _socket;
  Timer? _broadcastTimer;

  // 📡 MASTER: Broadcast shuru karna taaki Slaves dhund sakein
  Future<void> startBroadcasting(String tribeName) async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    _socket?.broadcastEnabled = true;

    // Har 2 second mein signal bhejna
    _broadcastTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final String message = "SYNCBLAST_HOST|$tribeName";
      final List<int> data = utf8.encode(message);

      // 255.255.255.255 matlab network ke har phone ko message bhejo
      _socket?.send(data, InternetAddress("255.255.255.255"), port);
      print("Broadcasting Tribe: $tribeName");
    });
  }

  // 🔍 SLAVE: Master ko dhundna
  Future<void> lookForTribe(Function(String ip, String name) onFound) async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    print("Searching for SyncBlast Tribe...");

    _socket?.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? dg = _socket?.receive();
        if (dg != null) {
          String message = utf8.decode(dg.data);
          if (message.startsWith("SYNCBLAST_HOST")) {
            List<String> parts = message.split("|");
            onFound(dg.address.address, parts[1]);
          }
        }
      }
    });
  }

  void stop() {
    _broadcastTimer?.cancel();
    _socket?.close();
  }
}
