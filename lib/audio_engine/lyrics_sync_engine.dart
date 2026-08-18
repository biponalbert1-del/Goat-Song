class LyricsLine {
  const LyricsLine({required this.time, required this.text});

  final Duration time;
  final String text;
}

class LyricsSyncEngine {
  const LyricsSyncEngine();

  LyricsLine? currentLine(List<LyricsLine> lines, Duration position) {
    LyricsLine? current;
    for (final LyricsLine line in lines) {
      if (line.time <= position) {
        current = line;
      }
    }
    return current;
  }
}
