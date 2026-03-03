import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:syncblast/screens/onboarding_screen.dart';

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
        // 1. Dynamic values ko handle karein (Lekin unhe directly use karein)
        final ColorScheme lightColorScheme =
            lightDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.light,
            );

        final ColorScheme darkColorScheme =
            darkDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.dark,
            );

        return MaterialApp(
          title: 'SyncBlast',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light, // Aapne light mode fix kiya hai
          // 2. Light Theme Configuration
          theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                lightColorScheme, // Humne seed ki jagah poora scheme use kiya
            scaffoldBackgroundColor: const Color(0xFFFBF8FF),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),

          // 3. Dark Theme Configuration
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),

          home: const OnboardingScreen(),
        );
      },
    );
  }
}
