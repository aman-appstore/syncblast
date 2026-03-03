import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SmartPillWidget extends StatelessWidget {
  final String songTitle;
  final bool isMicActive;

  const SmartPillWidget({
    super.key,
    required this.songTitle,
    this.isMicActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // 💿 Rotating Vinyl Icon
          const Icon(
            Icons.music_note,
            color: Colors.cyanAccent,
            size: 18,
          ).animate(onPlay: (c) => c.repeat()).rotate(duration: 3.seconds),

          const SizedBox(width: 8),

          // 🎵 Animated Text (Marquee)
          Expanded(
            child: Text(
              isMicActive ? "MIC BROADCASTING..." : songTitle,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 📊 Mini Visualizer
          _miniVisualizer(),
        ],
      ),
    ).animate().fadeIn().scale(curve: Curves.easeOutBack);
  }

  Widget _miniVisualizer() {
    return Row(
      children: List.generate(
        3,
        (index) =>
            Container(
                  width: 2,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  color: Colors.cyanAccent,
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleY(
                  begin: 0.2,
                  end: 1.2,
                  duration: (400 + (index * 100)).ms,
                ),
      ),
    );
  }
}
