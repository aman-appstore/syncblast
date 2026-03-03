import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:syncblast/screens/onboarding_screen.dart'; // Hum agle step mein banayenge

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SyncBlastApp()));
}

class SyncBlastApp extends StatelessWidget {
  const SyncBlastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // Default colors agar phone Monet support nahi karta (Android 12 se niche)
        ColorScheme lightColorScheme =
            lightDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.light,
            );

        ColorScheme darkColorScheme =
            darkDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.dark,
            );

        return MaterialApp(
          title: 'SyncBlast',
          debugShowCheckedModeBanner: false,
          // Theme ko Light mode par set karna
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed:
                Colors.deepPurple, // Dynamic colors automatically pick honge
            scaffoldBackgroundColor: const Color(
              0xFFFBF8FF,
            ), // Soft clean background
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
