import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:syncblast/services/network_service.dart';

class AudioEngine {
  static const int chunkSize = 8192; // 8KB ke packets taaki lag na ho
  bool isStreaming = false;

  // 🎵 MASTER: Audio file ko packets mein convert karke bhejna
  Future<void> streamAudioFile(String filePath, String targetIP) async {
    final file = File(filePath);
    final Uint8List bytes = await file.readAsBytes();
    isStreaming = true;

    int totalBytes = bytes.length;
    int sentBytes = 0;

    // UDP Socket setup for Streaming
    final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

    while (sentBytes < totalBytes && isStreaming) {
      int end = (sentBytes + chunkSize < totalBytes)
          ? sentBytes + chunkSize
          : totalBytes;

      // Packet banana: [Header (Sequence No) + Audio Data]
      // Header zaroori hai taaki Slave ko pata chale kaunsa part pehle bajana hai
      List<int> packet = bytes.sublist(sentBytes, end);

      // Sabhi Slaves ko bhejna (Broadcast ya Unicast)
      socket.send(packet, InternetAddress(targetIP), 8889);

      sentBytes = end;

      // Chota delay taaki network choke na ho (Micro-optimization)
      await Future.delayed(const Duration(milliseconds: 5));
    }
  }

  void stopStreaming() {
    isStreaming = false;
  }
}
