import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotatingCassette extends StatefulWidget {
  const RotatingCassette({
    super.key,
    required this.isPlaying,
    required this.accentColor,
    required this.trackTitle,
    required this.artist,
    required this.progress,
  });

  final bool isPlaying;
  final Color accentColor;
  final String trackTitle;
  final String artist;
  final double progress;

  @override
  State<RotatingCassette> createState() => _RotatingCassetteState();
}

class _RotatingCassetteState extends State<RotatingCassette>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  @override
  void didUpdateWidget(covariant RotatingCassette oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  @override
  void initState() {
    super.initState();
    _syncAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.accentColor;
    final double progress = widget.progress.clamp(0, 1).toDouble();

    return AspectRatio(
      aspectRatio: 1.48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFF1A1E23),
              Color.lerp(const Color(0xFF111318), accent, 0.18)!,
              const Color(0xFF05070A),
            ],
          ),
          border: Border.all(color: accent.withValues(alpha: 0.38)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: accent.withValues(alpha: 0.28),
              blurRadius: 38,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    _Reel(
                      animation: _controller,
                      accent: accent,
                      tapeFill: 0.86 - progress * 0.38,
                    ),
                    Expanded(
                      child: _CassetteLabel(
                        accent: accent,
                        trackTitle: widget.trackTitle,
                        artist: widget.artist,
                        progress: progress,
                      ),
                    ),
                    _Reel(
                      animation: _controller,
                      accent: accent,
                      tapeFill: 0.44 + progress * 0.42,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _TapeMeter(accent: accent, progress: progress),
            ],
          ),
        ),
      ),
    );
  }

  void _syncAnimation() {
    if (widget.isPlaying) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }
}

class _CassetteLabel extends StatelessWidget {
  const _CassetteLabel({
    required this.accent,
    required this.trackTitle,
    required this.artist,
    required this.progress,
  });

  final Color accent;
  final String trackTitle;
  final String artist;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'GOAT SONG',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            trackTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            artist,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.72),
                ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 4,
              value: progress,
              backgroundColor: Colors.black.withValues(alpha: 0.38),
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _TapeMeter extends StatelessWidget {
  const _TapeMeter({required this.accent, required this.progress});

  final Color accent;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withValues(alpha: 0.42),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: List<Widget>.generate(
          18,
          (int index) {
            final double pulse = (index + progress * 18) % 6;
            final double height = 5 + pulse * 3;
            return Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: accent.withValues(
                      alpha: 0.18 + (index % 4) * 0.13,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Reel extends StatelessWidget {
  const _Reel({
    required this.animation,
    required this.accent,
    required this.tapeFill,
  });

  final Animation<double> animation;
  final Color accent;
  final double tapeFill;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double size = constraints.maxWidth.clamp(62, 82).toDouble();
        return SizedBox.square(
          dimension: size,
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: animation.value * math.pi * 2,
                child: child,
              );
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                border: Border.all(color: accent, width: 2),
              ),
              child: CustomPaint(
                painter: _ReelPainter(accent: accent, tapeFill: tapeFill),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReelPainter extends CustomPainter {
  const _ReelPainter({required this.accent, required this.tapeFill});

  final Color accent;
  final double tapeFill;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide / 2;
    final double tapeRadius = radius * tapeFill.clamp(0.28, 0.9);
    final Paint tapePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..style = PaintingStyle.fill;
    final Paint spokePaint = Paint()
      ..color = accent.withValues(alpha: 0.76)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Paint ringPaint = Paint()
      ..color = accent.withValues(alpha: 0.22)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, tapeRadius, tapePaint);
    canvas.drawCircle(center, radius * 0.72, ringPaint);

    for (int i = 0; i < 6; i++) {
      final double angle = i * math.pi / 3;
      final Offset start =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.23);
      final Offset end =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.60);
      canvas.drawLine(start, end, spokePaint);
    }

    canvas.drawCircle(center, radius * 0.12, spokePaint);
  }

  @override
  bool shouldRepaint(covariant _ReelPainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.tapeFill != tapeFill;
  }
}
