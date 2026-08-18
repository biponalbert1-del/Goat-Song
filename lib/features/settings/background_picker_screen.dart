import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../../core/theme/background_theme_manager.dart';
import '../../core/theme/wallpaper_preset.dart';
import 'widgets/wallpaper_preview.dart';

class BackgroundPickerScreen extends StatelessWidget {
  const BackgroundPickerScreen({
    super.key,
    required this.manager,
  });

  final BackgroundThemeManager manager;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.primary;
    final preferences = manager.preferences;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: <Widget>[
          Text(
            'Personnalisation',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            preferences.customWallpaperPath == null
                ? WallpaperPreset.byId(preferences.wallpaperPresetId).label
                : 'Image personnelle',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 18),
          Card(
            child: SwitchListTile(
              value: preferences.isLightMode,
              onChanged: manager.setBrightnessMode,
              secondary: Icon(
                preferences.isLightMode
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                color: accent,
              ),
              title: const Text('Theme clair'),
              subtitle:
                  const Text('Blanc en mode clair, noir en mode premium.'),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 116,
                      child: preferences.customWallpaperPath == null
                          ? WallpaperPreview(
                              preset: WallpaperPreset.byId(
                                preferences.wallpaperPresetId,
                              ),
                              accentColor: accent,
                              isLightMode: preferences.isLightMode,
                              showIcon: false,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(preferences.customWallpaperPath!),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: accent.withValues(alpha: 0.14),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: accent,
                                        size: 34,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    children: <Widget>[
                      IconButton.filledTonal(
                        tooltip: 'Reinitialiser',
                        onPressed: manager.reset,
                        icon: const Icon(Icons.restart_alt_rounded),
                      ),
                      const SizedBox(height: 8),
                      IconButton.filledTonal(
                        tooltip: 'Image locale',
                        onPressed: () => _pickCustomWallpaper(context),
                        icon: const Icon(Icons.add_photo_alternate_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.palette_rounded, color: accent),
                      const SizedBox(width: 10),
                      Text(
                        'Couleur secondaire',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ColorPicker(
                    color: preferences.secondaryColor,
                    onColorChanged: manager.setSecondaryColor,
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.wheel: true,
                      ColorPickerType.primary: false,
                      ColorPickerType.accent: false,
                    },
                    enableShadesSelection: false,
                    wheelDiameter: 220,
                    borderRadius: 8,
                    heading: const SizedBox.shrink(),
                    subheading: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.wallpaper_rounded, color: accent),
                      const SizedBox(width: 10),
                      Text(
                        'Fond d ecran',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final double itemWidth = (constraints.maxWidth - 10) / 2;
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: WallpaperPreset.values.map(
                          (WallpaperPreset preset) {
                            final bool selected =
                                preferences.customWallpaperPath == null &&
                                    preferences.wallpaperPresetId == preset.id;
                            return _WallpaperChoice(
                              width: itemWidth,
                              preset: preset,
                              selected: selected,
                              accent: accent,
                              isLightMode: preferences.isLightMode,
                              onTap: () =>
                                  manager.setWallpaperPreset(preset.id),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: () => _pickCustomWallpaper(context),
                    icon: const Icon(Icons.add_photo_alternate_rounded),
                    label: const Text('Choisir une image'),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Opacite du fond',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Slider(
                    value: preferences.wallpaperOpacity,
                    min: 0,
                    max: 0.75,
                    onChanged: manager.setWallpaperOpacity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickCustomWallpaper(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result?.files.single.path case final String path) {
      manager.setCustomWallpaper(path);
    }
  }
}

class _WallpaperChoice extends StatelessWidget {
  const _WallpaperChoice({
    required this.width,
    required this.preset,
    required this.selected,
    required this.accent,
    required this.isLightMode,
    required this.onTap,
  });

  final double width;
  final WallpaperPreset preset;
  final bool selected;
  final Color accent;
  final bool isLightMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.clamp(132, 260).toDouble(),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? accent : Colors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 76,
                  child: WallpaperPreview(
                    preset: preset,
                    accentColor: accent,
                    isLightMode: isLightMode,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Icon(
                      selected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: selected ? accent : null,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        preset.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
