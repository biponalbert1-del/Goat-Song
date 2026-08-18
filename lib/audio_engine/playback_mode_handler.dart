enum PlaybackMode {
  normal,
  repeatAll,
  repeatOne,
  shuffle,
}

class PlaybackModeHandler {
  PlaybackModeHandler({this.mode = PlaybackMode.normal});

  PlaybackMode mode;

  PlaybackMode next() {
    const List<PlaybackMode> values = PlaybackMode.values;
    mode = values[(values.indexOf(mode) + 1) % values.length];
    return mode;
  }
}
