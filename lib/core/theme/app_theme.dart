import 'package:flutter/material.dart';

import 'theme_preferences.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData build(ThemePreferences preferences) {
    final Color accent = preferences.secondaryColor;
    final bool light = preferences.isLightMode;
    final Color background =
        light ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final Color surface =
        light ? const Color(0xFFF3F6FA) : const Color(0xFF07101A);
    final Color text =
        light ? const Color(0xFF101418) : const Color(0xFFF8FBFF);

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: light ? Brightness.light : Brightness.dark,
      primary: accent,
      secondary: accent,
      surface: surface,
    ).copyWith(
      primary: accent,
      secondary: accent,
      surface: surface,
      onSurface: text,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: light ? Brightness.light : Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',
      textTheme: Typography.material2021()
          .black
          .apply(
            bodyColor: text,
            displayColor: text,
          )
          .merge(Typography.material2021().white),
      sliderTheme: SliderThemeData(
        activeTrackColor: accent,
        thumbColor: accent,
        overlayColor: accent.withValues(alpha: 0.16),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: light
            ? Colors.white.withValues(alpha: 0.92)
            : Colors.black.withValues(alpha: 0.72),
        indicatorColor: accent.withValues(alpha: 0.22),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: text, fontWeight: FontWeight.w700),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: _onAccent(accent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: text,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        color: light
            ? Colors.white.withValues(alpha: 0.86)
            : const Color(0xFF09131F).withValues(alpha: 0.86),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static Color _onAccent(Color color) {
    return color.computeLuminance() > 0.48 ? Colors.black : Colors.white;
  }
}
