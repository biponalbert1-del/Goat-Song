import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DynamicThemeExtractor {
  const DynamicThemeExtractor();

  Future<Color?> dominantColorFromImage(ImageProvider imageProvider) async {
    final PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return palette.vibrantColor?.color ??
        palette.dominantColor?.color ??
        palette.lightVibrantColor?.color;
  }
}
