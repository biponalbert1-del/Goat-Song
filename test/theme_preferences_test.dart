import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goat_song/core/theme/background_theme_manager.dart';
import 'package:goat_song/core/theme/wallpaper_preset.dart';

void main() {
  test('wallpaper preset migrates old asset paths', () {
    expect(
      WallpaperPreset.migrateLegacyAsset(
        'assets/images/wallpapers/vintage_cassette_bg.png',
      ),
      'cassette',
    );
    expect(WallpaperPreset.migrateLegacyAsset('unknown'), 'midnight');
  });

  test('theme manager persists color, preset and reset', () async {
    final _MemoryThemeStore store = _MemoryThemeStore();
    final BackgroundThemeManager manager = BackgroundThemeManager(store);

    manager.setSecondaryColor(Colors.green);
    manager.setWallpaperPreset('studio');
    manager.setBrightnessMode(true);
    await Future<void>.delayed(Duration.zero);

    expect(manager.preferences.secondaryColor, Colors.green);
    expect(manager.preferences.wallpaperPresetId, 'studio');
    expect(manager.preferences.isLightMode, isTrue);
    expect(store.values['secondary_color'], Colors.green.toARGB32());
    expect(store.values['wallpaper_preset'], 'studio');

    manager.reset();
    await Future<void>.delayed(Duration.zero);

    expect(manager.preferences.secondaryColor, const Color(0xFF178BFF));
    expect(manager.preferences.wallpaperPresetId, 'midnight');
    expect(manager.preferences.isLightMode, isFalse);
  });
}

class _MemoryThemeStore implements ThemePreferenceStore {
  final Map<dynamic, dynamic> values = <dynamic, dynamic>{};

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return values[key] ?? defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    values[key] = value;
  }

  @override
  Future<void> delete(dynamic key) async {
    values.remove(key);
  }
}
