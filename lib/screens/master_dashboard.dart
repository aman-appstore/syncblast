import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncblast/providers/device_provider.dart';
import 'package:syncblast/providers/queue_provider.dart';
import 'package:syncblast/providers/ai_settings_provider.dart';

class MasterDashboard extends ConsumerWidget {
  const MasterDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceListProvider);
    final queue = ref.watch(queueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MASTER CONTROL",
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_input_component),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 🎚 Global Equalizer Preview (Visual only for now)
          _buildQuickActions(context),

          const Divider(),

          // 📱 Connected Devices List with Individual Volume
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: Text(device.name),
                  subtitle: Slider(
                    value: 0.8, // Default 80% volume
                    onChanged: (val) {
                      // Logic to send Volume Packet to specific Slave IP
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.block,
                      color: Colors.red.withValues(alpha: 0.7),
                    ),
                    onPressed: () => ref
                        .read(deviceListProvider.notifier)
                        .removeDevice(device.id),
                  ),
                );
              },
            ),
          ),

          // 🎵 Veto Queue Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "UPCOMING TRACKS (VETO QUEUE)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            flex: 2,
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) =>
                  ref.read(queueProvider.notifier).moveSong(oldIndex, newIndex),
              children: [
                for (final song in queue)
                  ListTile(
                    key: ValueKey(song.id),
                    leading: const Icon(Icons.music_note),
                    title: Text(song.title),
                    subtitle: Text("Added by ${song.addedBy}"),
                    trailing: const Icon(Icons.drag_handle),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionButton(
            context,
            Icons.volume_off,
            "Mute All",
            Colors.redAccent,
          ),
          _actionButton(context, Icons.sync, "Magic Sync", Colors.blueAccent),
          _actionButton(
            context,
            Icons.campaign,
            "Mic Mode",
            Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

Widget _actionButton(
  BuildContext context,
  IconData icon,
  String label,
  Color color,
) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.2),
        child: Icon(icon, color: color),
      ),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 10)),
    ],
  );
}

Widget _buildAISettings(BuildContext context, WidgetRef ref) {
  final ai = ref.watch(aiSettingsProvider);

  return Card(
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 5,
    child: ExpansionTile(
      leading: const Icon(
        Icons.psychology,
        color: Colors.purpleAccent,
        size: 30,
      ),
      title: const Text(
        "AI SMART CONTROLS",
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
      subtitle: const Text("Auto-optimize sound & mic levels"),
      children: [
        // 🔊 Auto-Tuning Toggle
        SwitchListTile(
          secondary: const Icon(Icons.graphic_eq, color: Colors.cyanAccent),
          title: const Text("Anti-Distortion AI"),
          subtitle: const Text("Speaker ko fatne se bachaye"),
          value: ai.autoTuneEnabled,
          onChanged: (val) {
            // AI settings update karne ka logic
            ref.read(aiSettingsProvider.notifier).state = AISettings(
              autoTuneEnabled: val,
              duckingEnabled: ai.duckingEnabled,
            );
          },
        ),

        // 🎙 Ducking Toggle
        SwitchListTile(
          secondary: const Icon(
            Icons.record_voice_over,
            color: Colors.orangeAccent,
          ),
          title: const Text("Smart Ducking"),
          subtitle: const Text("Mic on hote hi music fade kare"),
          value: ai.duckingEnabled,
          onChanged: (val) {
            ref.read(aiSettingsProvider.notifier).state = AISettings(
              duckingEnabled: val,
              autoTuneEnabled: ai.autoTuneEnabled,
            );
          },
        ),
      ],
    ),
  );
}
