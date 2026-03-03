import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncblast/providers/device_provider.dart';

class LobbyScreen extends ConsumerWidget {
  const LobbyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceListProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background Pulsating Glow
          Center(
            child:
                Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .scale(
                      duration: 1.seconds,
                      begin: const Offset(1, 1),
                      end: const Offset(1.5, 1.5),
                    )
                    .fadeOut(),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "THE TRIBE",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${devices.length}/20 Devices Connected",
                  style: const TextStyle(color: Colors.grey),
                ),

                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Central Host Icon (Aman's Phone)
                      const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.cyanAccent,
                            child: Icon(
                              Icons.bolt,
                              color: Colors.black,
                              size: 40,
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(duration: 2.seconds),

                      // Circular Grid of Slaves
                      ...List.generate(devices.length, (index) {
                        final angle =
                            (index * 2 * math.pi) /
                            (devices.length > 0 ? devices.length : 1);
                        const radius = 130.0;
                        final x = radius * math.cos(angle);
                        final y = radius * math.sin(angle);

                        return Transform.translate(
                              offset: Offset(x, y),
                              child: _buildDeviceNode(
                                context,
                                devices[index],
                                ref,
                              ),
                            )
                            .animate()
                            .scale(curve: Curves.elasticOut, duration: 600.ms)
                            .fadeIn();
                      }),
                    ],
                  ),
                ),

                // Bottom Action Bar
                _buildBottomControls(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceNode(
    BuildContext context,
    ConnectedDevice device,
    WidgetRef ref,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () =>
              ref.read(deviceListProvider.notifier).toggleMute(device.id),
          child:
              CircleAvatar(
                    radius: 25,
                    backgroundColor: device.isMuted
                        ? Colors.redAccent
                        : Colors.white24,
                    child: Icon(
                      device.isMuted ? Icons.volume_off : Icons.phone_android,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .shake(hz: 4, curve: Curves.easeInOut), // Beat Vibration Feel
        ),
        const SizedBox(height: 4),
        Text(
          device.name,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
        Text(
          "${device.batteryLevel.toInt()}%",
          style: const TextStyle(fontSize: 8, color: Colors.greenAccent),
        ),
      ],
    );
  }

  Widget _buildBottomControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circleIconButton(Icons.mic, "Broadcast", Colors.orange),
          _circleIconButton(Icons.play_arrow, "Start Sync", Colors.greenAccent),
          _circleIconButton(Icons.flash_on, "Sync Flash", Colors.yellow),
        ],
      ),
    );
  }

  Widget _circleIconButton(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: color,
          child: Icon(icon, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
