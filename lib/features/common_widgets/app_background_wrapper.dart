import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/theme/theme_preferences.dart';
import '../../core/theme/wallpaper_preset.dart';
import '../settings/widgets/wallpaper_preview.dart';

class AppBackgroundWrapper extends StatelessWidget {
  const AppBackgroundWrapper({
    super.key,
    required this.preferences,
    required this.child,
  });

  final ThemePreferences preferences;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ImageProvider? wallpaper = _wallpaperProvider();
    final Color base = preferences.isLightMode ? Colors.white : Colors.black;
    final WallpaperPreset preset =
        WallpaperPreset.byId(preferences.wallpaperPresetId);

    return ColoredBox(
      color: base,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (wallpaper == null)
            CustomPaint(
              painter: WallpaperPresetPainter(
                pattern: preset.pattern,
                accentColor: preferences.secondaryColor,
                isLightMode: preferences.isLightMode,
              ),
            )
          else
            Image(
              image: wallpaper,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ColoredBox(
            color: base.withValues(alpha: 1 - preferences.wallpaperOpacity),
          ),
          child,
        ],
      ),
    );
  }

  ImageProvider? _wallpaperProvider() {
    if (preferences.customWallpaperPath case final String path
        when path.isNotEmpty) {
      return FileImage(File(path));
    }
    return null;
  }
}
