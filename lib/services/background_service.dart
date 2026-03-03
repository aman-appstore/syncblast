import 'package:audio_service/audio_service.dart';

// 💊 Smart Pill / Notification Controller
class SyncBlastAudioHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  SyncBlastAudioHandler() {
    // Initial state set karna
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.pause,
          MediaControl.stop,
          const MediaControl(
            androidIcon: 'drawable/ic_mic',
            label: 'Mic On',
            action: MediaAction.custom,
          ),
        ],
        systemActions: const {MediaAction.seek},
        playing: true,
        processingState: AudioProcessingState.ready,
      ),
    );
  }

  // Master jab gaana badlega toh notification update hogi
  void updateMetadata(String title, String artist, String artUri) {
    mediaItem.add(
      MediaItem(
        id: 'syncblast_stream',
        album: 'SyncBlast Tribe',
        title: title,
        artist: artist,
        artUri: Uri.parse(artUri),
      ),
    );
  }

  @override
  Future<void> play() async =>
      playbackState.add(playbackState.value.copyWith(playing: true));

  @override
  Future<void> pause() async =>
      playbackState.add(playbackState.value.copyWith(playing: false));

  @override
  Future<void> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'mic_on') {
      // Mic mode trigger karne ka logic
    }
  }
}
