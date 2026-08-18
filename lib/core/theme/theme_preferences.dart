import 'package:flutter/material.dart';

class ThemePreferences {
  const ThemePreferences({
    this.isLightMode = false,
    this.secondaryColor = const Color(0xFF178BFF),
    this.wallpaperPresetId = 'midnight',
    this.customWallpaperPath,
    this.wallpaperOpacity = 0.34,
  });

  final bool isLightMode;
  final Color secondaryColor;
  final String wallpaperPresetId;
  final String? customWallpaperPath;
  final double wallpaperOpacity;

  Color get surfaceColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF02040A);

  Color get baseTextColor =>
      isLightMode ? const Color(0xFF101418) : const Color(0xFFF8FBFF);

  ThemePreferences copyWith({
    bool? isLightMode,
    Color? secondaryColor,
    String? wallpaperPresetId,
    String? customWallpaperPath,
    double? wallpaperOpacity,
    bool clearCustomWallpaperPath = false,
  }) {
    return ThemePreferences(
      isLightMode: isLightMode ?? this.isLightMode,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      wallpaperPresetId: wallpaperPresetId ?? this.wallpaperPresetId,
      customWallpaperPath: clearCustomWallpaperPath
          ? null
          : customWallpaperPath ?? this.customWallpaperPath,
      wallpaperOpacity: wallpaperOpacity ?? this.wallpaperOpacity,
    );
  }
}
