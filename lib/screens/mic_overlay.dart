import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MicOverlay extends StatefulWidget {
  final bool isActive;
  const MicOverlay({super.key, required this.isActive});

  @override
  State<MicOverlay> createState() => _MicOverlayState();
}

class _MicOverlayState extends State<MicOverlay> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return const SizedBox.shrink();

    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pulsing Mic Icon
            Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withValues(alpha: 0.2),
                  ),
                  child: const Icon(
                    Icons.mic,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                )
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.3, 1.3),
                  duration: 600.ms,
                )
                .boxShadow(
                  begin: const BoxShadow(
                    color: Colors.transparent,
                    blurRadius: 0,
                  ),
                  end: BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.5),
                    blurRadius: 30,
                  ),
                ), // <--- Ye comma lagana mat bhoolna

            const SizedBox(height: 30),
            const Text(
              "BROADCASTING LIVE",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),

            const Text(
              "Music Dimmed (Auto-Ducking)",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
