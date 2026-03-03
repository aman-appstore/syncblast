import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncblast/providers/queue_provider.dart';
import 'package:syncblast/screens/master_dashboard.dart';

class SyncFileExplorer extends ConsumerWidget {
  const SyncFileExplorer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // File Picker for Multiple Songs
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.audio,
            allowMultiple: true,
          );

          if (result != null) {
            for (var file in result.files) {
              ref
                  .read(queueProvider.notifier)
                  .addToQueue(
                    Song(
                      id: DateTime.now().toString(),
                      title: file.name,
                      path: file.path!,
                    ),
                  );
            }
          }
        },
        label: const Text("Add Music"),
        icon: const Icon(Icons.library_music),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(floating: true, title: Text("MY LIBRARY")),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Select songs to add to the Tribe Queue",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          // List of added songs (Abhi ke liye queue provider se)
          const SliverFillRemaining(
            child:
                MasterDashboard(), // Ya jo playlist widget aapne pehle banaya
          ),
        ],
      ),
    );
  }
}
