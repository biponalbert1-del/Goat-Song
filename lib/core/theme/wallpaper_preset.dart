import 'package:flutter/material.dart';

class WallpaperPreset {
  const WallpaperPreset({
    required this.id,
    required this.label,
    required this.icon,
    required this.pattern,
  });

  final String id;
  final String label;
  final IconData icon;
  final WallpaperPattern pattern;

  static const String defaultId = 'midnight';

  static const List<WallpaperPreset> values = <WallpaperPreset>[
    WallpaperPreset(
      id: defaultId,
      label: 'Midnight',
      icon: Icons.nightlight_round,
      pattern: WallpaperPattern.midnight,
    ),
    WallpaperPreset(
      id: 'cassette',
      label: 'Cassette',
      icon: Icons.album_rounded,
      pattern: WallpaperPattern.cassette,
    ),
    WallpaperPreset(
      id: 'studio',
      label: 'Studio',
      icon: Icons.graphic_eq_rounded,
      pattern: WallpaperPattern.studio,
    ),
    WallpaperPreset(
      id: 'vinyl',
      label: 'Vinyl',
      icon: Icons.radio_button_checked_rounded,
      pattern: WallpaperPattern.vinyl,
    ),
  ];

  static WallpaperPreset byId(String? id) {
    return values.firstWhere(
      (WallpaperPreset preset) => preset.id == id,
      orElse: () => values.first,
    );
  }

  static String migrateLegacyAsset(String? value) {
    return switch (value) {
      'assets/images/wallpapers/vintage_cassette_bg.png' => 'cassette',
      'assets/images/wallpapers/abstract_dark_bg.png' => 'studio',
      'assets/images/wallpapers/default_bg.png' => defaultId,
      final String id
          when values.any((WallpaperPreset preset) => preset.id == id) =>
        id,
      _ => defaultId,
    };
  }
}

enum WallpaperPattern {
  midnight,
  cassette,
  studio,
  vinyl,
}
