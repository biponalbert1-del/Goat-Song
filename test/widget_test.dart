import 'package:flutter_test/flutter_test.dart';

import 'package:goat_song/audio_engine/crossfade_controller.dart';
import 'package:goat_song/audio_engine/sleep_timer_engine.dart';

void main() {
  test('crossfade starts when remaining time reaches threshold', () {
    final CrossfadeController controller = CrossfadeController(
      threshold: const Duration(seconds: 18),
    );

    expect(
      controller.shouldStartNextTrack(
        const Duration(minutes: 3, seconds: 45),
        const Duration(minutes: 4),
      ),
      isTrue,
    );
  });

  test('sleep timer fades during the last thirty seconds', () {
    const SleepTimerEngine engine = SleepTimerEngine();

    expect(engine.volumeForRemaining(const Duration(seconds: 15)), 0.5);
    expect(engine.volumeForRemaining(Duration.zero), 0);
  });
}
