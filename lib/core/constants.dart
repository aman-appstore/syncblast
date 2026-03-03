import 'package:flutter/material.dart';

class AppColors {
  // Party mode colors
  static const Color masterColor = Color(0xFFD0BCFF);
  static const Color slaveColor = Color(0xFFCCC2DC);
  static const Color accentNeon = Color(0xFF38E5FF);
}

class AppStyles {
  // Liquid Animation settings
  static const Duration liquidDuration = Duration(milliseconds: 800);
  static const Curve liquidCurve = Curves.elasticOut;

  static BoxDecoration glassCard(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    );
  }
}
