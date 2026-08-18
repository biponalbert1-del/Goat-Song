import 'package:flutter_test/flutter_test.dart';
import 'package:goat_song/features/player/models/player_track.dart';
import 'package:goat_song/features/player/models/player_view_state.dart';

void main() {
  group('PlayerViewState', () {
    test('calcule la progression et les labels de temps', () {
      final PlayerViewState state = PlayerViewState(
        track: PlayerTrack.demo(),
        position: const Duration(minutes: 1, seconds: 42),
      );

      expect(state.progress, closeTo(102 / 266, 0.001));
      expect(state.positionLabel, '01:42');
      expect(state.durationLabel, '04:26');
      expect(state.remainingLabel, '-02:44');
    });

    test('borne la progression au morceau courant', () {
      final PlayerViewState state = PlayerViewState(
        track: PlayerTrack.demo(),
        position: const Duration(minutes: 9),
      );

      expect(state.progress, 1);
      expect(state.positionLabel, '04:26');
      expect(state.remainingLabel, '-00:00');
    });

    test('cycle le mode repetition', () {
      expect(PlayerRepeatMode.off.next, PlayerRepeatMode.all);
      expect(PlayerRepeatMode.all.next, PlayerRepeatMode.one);
      expect(PlayerRepeatMode.one.next, PlayerRepeatMode.off);
    });
  });
}
