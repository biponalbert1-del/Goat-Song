class ReplayGainProcessor {
  const ReplayGainProcessor();

  double normalize(double gainDb) {
    return gainDb.clamp(-12, 12).toDouble();
  }
}
