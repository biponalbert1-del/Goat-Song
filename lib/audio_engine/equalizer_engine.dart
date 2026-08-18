class EqualizerEngine {
  EqualizerEngine({List<double>? bands}) : bands = bands ?? List<double>.filled(8, 0);

  final List<double> bands;

  void setBandGain(int index, double gain) {
    bands[index] = gain.clamp(-12, 12);
  }
}
