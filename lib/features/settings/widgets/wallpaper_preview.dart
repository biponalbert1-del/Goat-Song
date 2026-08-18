import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/wallpaper_preset.dart';

class WallpaperPreview extends StatelessWidget {
  const WallpaperPreview({
    super.key,
    required this.preset,
    required this.accentColor,
    required this.isLightMode,
    this.borderRadius = 8,
    this.showIcon = true,
  });

  final WallpaperPreset preset;
  final Color accentColor;
  final bool isLightMode;
  final double borderRadius;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CustomPaint(
        painter: WallpaperPresetPainter(
          pattern: preset.pattern,
          accentColor: accentColor,
          isLightMode: isLightMode,
        ),
        child: showIcon
            ? Center(
                child: Icon(
                  preset.icon,
                  color: _foreground.withValues(alpha: 0.9),
                  size: 26,
                ),
              )
            : const SizedBox.expand(),
      ),
    );
  }

  Color get _foreground {
    return isLightMode ? const Color(0xFF101418) : Colors.white;
  }
}

class WallpaperPresetPainter extends CustomPainter {
  const WallpaperPresetPainter({
    required this.pattern,
    required this.accentColor,
    required this.isLightMode,
  });

  final WallpaperPattern pattern;
  final Color accentColor;
  final bool isLightMode;

  @override
  void paint(Canvas canvas, Size size) {
    final Color base = isLightMode ? Colors.white : Colors.black;
    final Color surface =
        isLightMode ? const Color(0xFFF1F5F9) : const Color(0xFF04070D);
    final Rect rect = Offset.zero & size;

    final Paint background = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          base,
          Color.lerp(surface, accentColor, isLightMode ? 0.08 : 0.20)!,
          surface,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, background);

    switch (pattern) {
      case WallpaperPattern.midnight:
        _paintMidnight(canvas, size);
      case WallpaperPattern.cassette:
        _paintCassette(canvas, size);
      case WallpaperPattern.studio:
        _paintStudio(canvas, size);
      case WallpaperPattern.vinyl:
        _paintVinyl(canvas, size);
    }
  }

  void _paintMidnight(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = accentColor.withValues(alpha: isLightMode ? 0.18 : 0.26)
      ..strokeWidth = 1.2;

    for (double x = -size.width; x < size.width * 2; x += 28) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        line,
      );
    }

    final Paint glow = Paint()
      ..color = accentColor.withValues(alpha: isLightMode ? 0.10 : 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.20), 56, glow);
  }

  void _paintCassette(Canvas canvas, Size size) {
    final RRect body = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.10,
        size.height * 0.24,
        size.width * 0.80,
        size.height * 0.52,
      ),
      const Radius.circular(8),
    );
    final Paint bodyPaint = Paint()
      ..color = (isLightMode ? Colors.white : const Color(0xFF121820))
          .withValues(alpha: 0.58);
    final Paint stroke = Paint()
      ..color = accentColor.withValues(alpha: 0.42)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(body, bodyPaint);
    canvas.drawRRect(body, stroke);

    for (final double dx in <double>[0.32, 0.68]) {
      canvas.drawCircle(
        Offset(size.width * dx, size.height * 0.50),
        size.shortestSide * 0.13,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = accentColor.withValues(alpha: 0.58),
      );
      canvas.drawCircle(
        Offset(size.width * dx, size.height * 0.50),
        size.shortestSide * 0.045,
        Paint()..color = accentColor.withValues(alpha: 0.36),
      );
    }
  }

  void _paintStudio(Canvas canvas, Size size) {
    final Paint bar = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(4, size.width * 0.025)
      ..color = accentColor.withValues(alpha: 0.52);

    for (int i = 0; i < 13; i++) {
      final double x = size.width * (0.12 + i * 0.065);
      final double wave = math.sin(i * 1.3) * 0.20 + 0.52;
      canvas.drawLine(
        Offset(x, size.height * (0.5 - wave * 0.35)),
        Offset(x, size.height * (0.5 + wave * 0.35)),
        bar,
      );
    }
  }

  void _paintVinyl(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.58, size.height * 0.50);
    final double maxRadius = size.shortestSide * 0.52;
    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = accentColor.withValues(alpha: 0.34);

    for (double radius = maxRadius; radius > maxRadius * 0.16; radius -= 15) {
      canvas.drawCircle(center, radius, ring);
    }
    canvas.drawCircle(
      center,
      maxRadius * 0.18,
      Paint()..color = accentColor.withValues(alpha: 0.42),
    );
  }

  @override
  bool shouldRepaint(covariant WallpaperPresetPainter oldDelegate) {
    return oldDelegate.pattern != pattern ||
        oldDelegate.accentColor != accentColor ||
        oldDelegate.isLightMode != isLightMode;
  }
}
