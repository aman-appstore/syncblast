import 'package:flutter/material.dart';

class VisualizerEngine extends CustomPainter {
  final List<int> waveData; // Raw PCM data from stream
  final Color color;

  VisualizerEngine({required this.waveData, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final middle = size.height / 2;
    final spacing = size.width / waveData.length;

    path.moveTo(0, middle);

    for (int i = 0; i < waveData.length; i++) {
      // Math: Normalize wave data to fit screen height
      double x = i * spacing;
      double y = middle + (waveData[i] - 128) * (size.height / 256);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Drawing the "Liquid" effect
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
