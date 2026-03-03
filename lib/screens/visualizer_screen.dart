import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncblast/services/visualizer_engine.dart';

class VisualizerScreen extends StatelessWidget {
  final List<int> currentWave;

  const VisualizerScreen({super.key, required this.currentWave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🌊 Dynamic Waves
          Center(
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 300),
                  painter: VisualizerEngine(
                    waveData: currentWave,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(duration: 2.seconds, color: Colors.white24),

          // 🔋 Eco-Mode Battery Indicator
          Positioned(
            top: 40,
            right: 20,
            child: Column(
              children: [
                const Icon(
                  Icons.battery_charging_full,
                  color: Colors.greenAccent,
                  size: 16,
                ),
                const Text(
                  "ECO-MODE ACTIVE",
                  style: TextStyle(fontSize: 8, color: Colors.greenAccent),
                ),
              ],
            ),
          ),

          // 💿 Album Art Background Blur
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/album_art_placeholder.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
