class SleepTimerEngine {
  const SleepTimerEngine();

  double volumeForRemaining(Duration remaining) {
    const Duration fadeWindow = Duration(seconds: 30);
    if (remaining >= fadeWindow) {
      return 1;
    }
    if (remaining <= Duration.zero) {
      return 0;
    }
    return remaining.inMilliseconds / fadeWindow.inMilliseconds;
  }
}
