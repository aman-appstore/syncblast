import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';

class QRShareScreen extends StatelessWidget {
  const QRShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: NetworkInfo().getWifiIP(),
      builder: (context, snapshot) {
        final String masterIP = snapshot.data ?? "0.0.0.0";

        return Scaffold(
          appBar: AppBar(title: const Text("INVITE TRIBE")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Scan to Join SyncBlast",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                // QR Code Generator
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: QrImageView(
                    data: "SYNCBLAST|$masterIP",
                    version: QrVersions.auto,
                    size: 250.0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "IP: $masterIP",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
