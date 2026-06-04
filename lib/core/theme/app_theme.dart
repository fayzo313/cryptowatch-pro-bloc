import 'package:flutter/material.dart';

class AppTheme {
  // Ultra-modern Dark Theme Palette
  static const Color background = Color(0xFF0D0E12);
  static const Color surface = Color(0xFF161820);
  static const Color primaryAccent = Color(0xFF00E676); // Neon mint green for positive indicators
  static const Color secondaryAccent = Color(0xFFFF5252); // Coral red for negative metrics
  static const Color textPrimary = Color(0xFFFFFFFF);
  // ignore: use_full_hex_values_for_flutter_colors
  // static const Color textSecondary = Color(0Header8A8F9F);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: background,
      primaryColor: primaryAccent,
      cardColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      colorScheme: const ColorScheme.dark(
        background: background,
        surface: surface,
        primary: primaryAccent,
        secondary: primaryAccent,
      ),
    );
  }
}

// Senior developer optimization: Clean context extensions for scannable UI code
extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}