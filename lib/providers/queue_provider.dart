import 'package:flutter_riverpod/flutter_riverpod.dart';

class Song {
  final String id;
  final String title;
  final String path;
  final String addedBy;

  Song({
    required this.id,
    required this.title,
    required this.path,
    this.addedBy = "Master",
  });
}

class QueueNotifier extends StateNotifier<List<Song>> {
  QueueNotifier() : super([]);

  void addToQueue(Song song) {
    state = [...state, song];
  }

  // 🚫 VETO POWER: Master kisi bhi gaane ko nikaal sakta hai
  void removeFromQueue(String id) {
    state = state.where((song) => song.id != id).toList();
  }

  void clearQueue() {
    state = [];
  }

  void moveSong(int oldIndex, int newIndex) {
    final list = [...state];
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = list;
  }
}

final queueProvider = StateNotifierProvider<QueueNotifier, List<Song>>((ref) {
  return QueueNotifier();
});
