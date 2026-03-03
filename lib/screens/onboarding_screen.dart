import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncblast/providers/connection_provider.dart'; // Connection logic
import 'package:syncblast/screens/lobby_screen.dart'; // Master Lobby

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  // Permissions & Action Logic
  Future<void> _handleAction(bool isHost) async {
    // 1. Ask Permissions
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.nearbyWifiDevices,
      Permission.microphone, // For Mic-Mode
    ].request();

    if (statuses.values.every((status) => status.isGranted)) {
      if (isHost) {
        // MASTER LOGIC: Start Broadcasting and go to Lobby
        ref.read(connectionProvider.notifier).hostTribe("Aman's Tribe");
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LobbyScreen()),
          );
        }
      } else {
        // SLAVE LOGIC: Open Search Sheet
        ref.read(connectionProvider.notifier).startSearching();
        _showJoinSheet(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permissions Denied! SyncBlast needs them to work."),
        ),
      );
    }
  }

  // JOIN TRIBE: Discovered devices ki list dikhane ke liye
  void _showJoinSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final connection = ref.watch(connectionProvider);
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Searching for Tribes...",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                if (connection.discoveredTribes.isEmpty)
                  const LinearProgressIndicator().animate().shimmer(),

                ...connection.discoveredTribes
                    .map(
                      (tribe) => ListTile(
                        leading: const Icon(
                          Icons.wifi_tethering,
                          color: Colors.cyanAccent,
                        ),
                        title: Text(tribe['name']!),
                        subtitle: Text("IP: ${tribe['ip']}"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Logic to connect to this IP (Part 5 mein aayega)
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UI Code same rahega jo Part 2 mein tha, bas buttons ke 'onTap' change honge:
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bolt,
                    size: 80,
                    color: Colors.cyanAccent,
                  ).animate().scale(),
                  const SizedBox(height: 10),
                  Text(
                    "SYNCBLAST",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.black,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Updated Host Button
                  _buildLiquidButton(
                    context,
                    title: "HOST TRIBE",
                    subtitle: "Be the Master DJ",
                    icon: Icons.radar,
                    color: Colors.deepPurpleAccent,
                    onTap: () => _handleAction(true),
                  ),

                  const SizedBox(height: 20),

                  // Updated Join Button
                  _buildLiquidButton(
                    context,
                    title: "JOIN TRIBE",
                    subtitle: "Connect & Sync",
                    icon: Icons.cell_tower,
                    color: Colors.blueAccent,
                    onTap: () => _handleAction(false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // UI Helpers (Same as Part 2 but integrated)
  Widget _buildBackground() {
    return Container(
      color: Colors.black,
    ).animate().shimmer(color: Colors.deepPurple.withOpacity(0.1));
  }

  Widget _buildLiquidButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withOpacity(0.5)),
          color: color.withOpacity(0.1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
