import 'package:bloc_app/core/services/dependecy_injecrtion.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const CryptoWatchApp());
}

class CryptoWatchApp extends StatelessWidget {
  const CryptoWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoWatch Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Injected optimized styling metrics
      home: const SplashScreen(), // Initial startup node
    );
  }
}