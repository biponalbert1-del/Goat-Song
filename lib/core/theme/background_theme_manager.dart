import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'theme_preferences.dart';
import 'wallpaper_preset.dart';

class BackgroundThemeManager extends ChangeNotifier {
  static const String _boxName = 'theme_preferences';
  static const String _lightKey = 'is_light_mode';
  static const String _secondaryKey = 'secondary_color';
  static const String _wallpaperPresetKey = 'wallpaper_preset';
  static const String _legacyWallpaperAssetKey = 'wallpaper_asset';
  static const String _customWallpaperKey = 'custom_wallpaper';
  static const String _wallpaperOpacityKey = 'wallpaper_opacity';
  static const int _defaultSecondaryColor = 0xFF178BFF;

  BackgroundThemeManager(this._box) {
    _preferences = _readPreferences();
  }

  final ThemePreferenceStore _box;
  late ThemePreferences _preferences;

  ThemePreferences get preferences => _preferences;

  static Future<BackgroundThemeManager> create() async {
    final Box<dynamic> box = await Hive.openBox<dynamic>(_boxName);
    return BackgroundThemeManager(HiveThemePreferenceStore(box));
  }

  void setBrightnessMode(bool isLightMode) {
    _update(_preferences.copyWith(isLightMode: isLightMode));
  }

  void setSecondaryColor(Color color) {
    _update(_preferences.copyWith(secondaryColor: color));
  }

  void setWallpaperPreset(String presetId) {
    _update(
      _preferences.copyWith(
        wallpaperPresetId: presetId,
        clearCustomWallpaperPath: true,
      ),
    );
  }

  void setCustomWallpaper(String path) {
    _update(_preferences.copyWith(customWallpaperPath: path));
  }

  void setWallpaperOpacity(double opacity) {
    _update(_preferences.copyWith(wallpaperOpacity: opacity.clamp(0.0, 0.75)));
  }

  void reset() {
    _update(const ThemePreferences());
  }

  ThemePreferences _readPreferences() {
    final int secondaryValue =
        _box.get(_secondaryKey, defaultValue: _defaultSecondaryColor) as int;
    final String? savedPreset = _box.get(_wallpaperPresetKey) as String?;
    final String? legacyAsset = _box.get(_legacyWallpaperAssetKey) as String?;

    return ThemePreferences(
      isLightMode: _box.get(_lightKey, defaultValue: false) as bool,
      secondaryColor: Color(secondaryValue),
      wallpaperPresetId: WallpaperPreset.migrateLegacyAsset(
        savedPreset ?? legacyAsset,
      ),
      customWallpaperPath: _box.get(_customWallpaperKey) as String?,
      wallpaperOpacity:
          (_box.get(_wallpaperOpacityKey, defaultValue: 0.34) as num)
              .toDouble(),
    );
  }

  Future<void> _persist(ThemePreferences preferences) async {
    await _box.put(_lightKey, preferences.isLightMode);
    await _box.put(_secondaryKey, preferences.secondaryColor.toARGB32());
    await _box.put(_wallpaperPresetKey, preferences.wallpaperPresetId);
    await _box.delete(_legacyWallpaperAssetKey);
    await _box.put(_customWallpaperKey, preferences.customWallpaperPath);
    await _box.put(_wallpaperOpacityKey, preferences.wallpaperOpacity);
  }

  void _update(ThemePreferences next) {
    _preferences = next;
    unawaited(_persist(next));
    notifyListeners();
  }
}

abstract class ThemePreferenceStore {
  dynamic get(dynamic key, {dynamic defaultValue});

  Future<void> put(dynamic key, dynamic value);

  Future<void> delete(dynamic key);
}

class HiveThemePreferenceStore implements ThemePreferenceStore {
  HiveThemePreferenceStore(this._box);

  final Box<dynamic> _box;

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> put(dynamic key, dynamic value) {
    return _box.put(key, value);
  }

  @override
  Future<void> delete(dynamic key) {
    return _box.delete(key);
  }
}
