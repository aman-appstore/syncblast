import 'dart:io';

class SlaveAudioReceiver {
  RawDatagramSocket? _socket;
  final List<int> _audioBuffer = [];

  Future<void> startListening() async {
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889);
    print("Slave: Ready to receive audio packets...");

    _socket?.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? dg = _socket?.receive();
        if (dg != null) {
          // Packet ko buffer mein add karna
          _audioBuffer.addAll(dg.data);

          // Jab buffer kafi bada ho jaye (e.g. 100KB), tab bajana shuru karo
          if (_audioBuffer.length > 102400) {
            _playBufferedChunk();
          }
        }
      }
    });
  }

  void _playBufferedChunk() {
    // Yahan hum Native side (Kotlin/Swift) ko byte data bhejenge
    // Flutter direct raw bytes play karne mein slow hai
    print("Playing 100KB chunk...");
  }
}
