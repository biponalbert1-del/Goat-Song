import 'player_track.dart';

enum PlayerRepeatMode {
  off,
  all,
  one;

  PlayerRepeatMode get next {
    return switch (this) {
      PlayerRepeatMode.off => PlayerRepeatMode.all,
      PlayerRepeatMode.all => PlayerRepeatMode.one,
      PlayerRepeatMode.one => PlayerRepeatMode.off,
    };
  }

  String get label {
    return switch (this) {
      PlayerRepeatMode.off => 'Off',
      PlayerRepeatMode.all => 'Tout',
      PlayerRepeatMode.one => '1',
    };
  }
}

class PlayerViewState {
  const PlayerViewState({
    required this.track,
    this.position = Duration.zero,
    this.isPlaying = false,
    this.isShuffleEnabled = false,
    this.repeatMode = PlayerRepeatMode.off,
    this.isNightclubEnabled = false,
    this.crossfadeSeconds = 18,
    this.eqPreset = 'Club',
    this.hasQueue = false,
    this.isLoading = false,
    this.errorMessage,
  });

  final PlayerTrack? track;
  final Duration position;
  final bool isPlaying;
  final bool isShuffleEnabled;
  final PlayerRepeatMode repeatMode;
  final bool isNightclubEnabled;
  final int crossfadeSeconds;
  final String eqPreset;
  final bool hasQueue;
  final bool isLoading;
  final String? errorMessage;

  bool get hasTrack => track != null;

  double get progress {
    final PlayerTrack? currentTrack = track;
    if (currentTrack == null || currentTrack.duration.inMilliseconds <= 0) {
      return 0;
    }

    final double value =
        position.inMilliseconds / currentTrack.duration.inMilliseconds;
    return value.clamp(0, 1).toDouble();
  }

  Duration get safePosition {
    final PlayerTrack? currentTrack = track;
    if (currentTrack == null) {
      return Duration.zero;
    }

    if (position < Duration.zero) {
      return Duration.zero;
    }

    if (position > currentTrack.duration) {
      return currentTrack.duration;
    }

    return position;
  }

  String get positionLabel => formatDuration(safePosition);

  String get durationLabel => formatDuration(track?.duration ?? Duration.zero);

  String get remainingLabel {
    final PlayerTrack? currentTrack = track;
    if (currentTrack == null) {
      return '-00:00';
    }

    return '-${formatDuration(currentTrack.duration - safePosition)}';
  }

  PlayerViewState copyWith({
    PlayerTrack? track,
    bool clearTrack = false,
    Duration? position,
    bool? isPlaying,
    bool? isShuffleEnabled,
    PlayerRepeatMode? repeatMode,
    bool? isNightclubEnabled,
    int? crossfadeSeconds,
    String? eqPreset,
    bool? hasQueue,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PlayerViewState(
      track: clearTrack ? null : track ?? this.track,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
      repeatMode: repeatMode ?? this.repeatMode,
      isNightclubEnabled: isNightclubEnabled ?? this.isNightclubEnabled,
      crossfadeSeconds: crossfadeSeconds ?? this.crossfadeSeconds,
      eqPreset: eqPreset ?? this.eqPreset,
      hasQueue: hasQueue ?? this.hasQueue,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  static String formatDuration(Duration duration) {
    final int totalSeconds = duration.inSeconds.abs();
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds ~/ 60) % 60;
    final int seconds = totalSeconds % 60;

    String twoDigits(int value) => value.toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }

    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
