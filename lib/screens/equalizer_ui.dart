import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EqualizerSheet extends ConsumerWidget {
  const EqualizerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "AUTO-EQUALIZER",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProfileIcon(
                context,
                Icons.whatshot,
                "Party",
                AudioProfile.party,
              ),
              _buildProfileIcon(
                context,
                Icons.speaker_group,
                "Bass",
                AudioProfile.bassBoost,
              ),
              _buildProfileIcon(
                context,
                Icons.record_voice_over,
                "Vocals",
                AudioProfile.vocalClear,
              ),
              _buildProfileIcon(
                context,
                Icons.linear_scale,
                "Flat",
                AudioProfile.flat,
              ),
            ],
          ),

          const SizedBox(height: 40),
          // Custom Sliders for Master (Manual override)
          _buildEQSlider("Bass (60Hz)", 0.8),
          _buildEQSlider("Mid (1kHz)", 0.5),
          _buildEQSlider("Treble (12kHz)", 0.7),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileIcon(
    BuildContext context,
    IconData icon,
    String label,
    AudioProfile profile,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Logic: Send EQ Command to all Slaves
            print("Applying $label Profile to Tribe");
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildEQSlider(String label, double value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(label, style: const TextStyle(fontSize: 10)),
        ),
        Expanded(
          child: Slider(value: value, onChanged: (v) {}),
        ),
      ],
    );
  }
}
