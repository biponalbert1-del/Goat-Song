class CrossfadeController {
  CrossfadeController({this.threshold = const Duration(seconds: 18)});

  Duration threshold;

  bool shouldStartNextTrack(Duration position, Duration duration) {
    if (duration == Duration.zero) {
      return false;
    }
    return duration - position <= threshold;
  }
}
