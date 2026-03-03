import 'dart:async';
import 'package:record/record.dart';
import 'package:syncblast/services/audio_engine.dart';
import 'dart:typed_data';

class MicService {
  final _audioRecorder = AudioRecorder();
  StreamSubscription<Uint8List>? _micStreamSubscription;

  // 🎤 Mic shuru karna aur bytes ko stream karna
  Future<void> startBroadcastingMic(String broadcastIP) async {
    if (await _audioRecorder.hasPermission()) {
      // Audio stream config (Low bitrate for voice to ensure zero lag)
      const config = RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
      );

      final stream = await _audioRecorder.startStream(config);

      _micStreamSubscription = stream.listen((data) {
        // Voice data ko Master's Audio Engine ke zariye Slaves ko bhejna
        // Hum yahan 'High Priority' packet header use karenge
        AudioEngine.streamRawPackets(data, broadcastIP, isPriority: true);
      });
    }
  }

  Future<void> stopMic() async {
    await _micStreamSubscription?.cancel();
    await _audioRecorder.stop();
  }
}
