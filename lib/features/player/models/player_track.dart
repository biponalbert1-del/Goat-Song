class PlayerTrack {
  const PlayerTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.sourceLabel,
    required this.qualityLabel,
  });

  factory PlayerTrack.demo() {
    return const PlayerTrack(
      id: 'demo-midnight-tape',
      title: 'Midnight Tape Demo',
      artist: 'GOAT SONG Studio',
      album: 'Cassette Club Sessions',
      duration: Duration(minutes: 4, seconds: 26),
      sourceLabel: 'Demo locale',
      qualityLabel: 'Hi-Fi 320 kbps',
    );
  }

  final String id;
  final String title;
  final String artist;
  final String album;
  final Duration duration;
  final String sourceLabel;
  final String qualityLabel;
}
