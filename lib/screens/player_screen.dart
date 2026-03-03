import 'package:file_picker/file_picker.dart';
import 'package:syncblast/services/audio_engine.dart';

// Master Jab Gaana Select Karega:
void pickAndPlay() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
  );

  if (result != null) {
    String filePath = result.files.single.path!;
    // Master ab streaming shuru karega
    AudioEngine().streamAudioFile(filePath, "255.255.255.255");
  }
}
