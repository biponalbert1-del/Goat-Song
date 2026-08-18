import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/background_theme_manager.dart';
import 'features/common_widgets/app_background_wrapper.dart';
import 'features/equalizer/equalizer_screen.dart';
import 'features/library/screens/library_main_screen.dart';
import 'features/player/models/player_track.dart';
import 'features/player/models/player_view_state.dart';
import 'features/player/ui/main_player_screen.dart';
import 'features/settings/background_picker_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final BackgroundThemeManager themeManager =
      await BackgroundThemeManager.create();
  runApp(GoatSongApp(themeManager: themeManager));
}

class GoatSongApp extends StatelessWidget {
  const GoatSongApp({super.key, required this.themeManager});

  final BackgroundThemeManager themeManager;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeManager,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GOAT SONG',
          theme: AppTheme.build(themeManager.preferences),
          home: GoatSongShell(themeManager: themeManager),
        );
      },
    );
  }
}

class GoatSongShell extends StatefulWidget {
  const GoatSongShell({super.key, required this.themeManager});

  final BackgroundThemeManager themeManager;

  @override
  State<GoatSongShell> createState() => _GoatSongShellState();
}

class _GoatSongShellState extends State<GoatSongShell> {
  int _index = 0;
  late PlayerViewState _playerState = PlayerViewState(
    track: PlayerTrack.demo(),
    position: const Duration(minutes: 1, seconds: 42),
    isPlaying: true,
    isShuffleEnabled: false,
    repeatMode: PlayerRepeatMode.off,
    isNightclubEnabled: false,
    hasQueue: false,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.themeManager,
      builder: (BuildContext context, Widget? child) {
        final preferences = widget.themeManager.preferences;
        final List<Widget> pages = <Widget>[
          MainPlayerScreen(
            state: _playerState,
            onPlayPause: _togglePlayPause,
            onSeek: _seek,
            onShuffleToggle: _toggleShuffle,
            onRepeatToggle: _cycleRepeat,
            onNightclubToggle: _toggleNightclub,
            onPrevious: _previous,
            onNext: _next,
          ),
          const LibraryMainScreen(),
          const EqualizerScreen(),
          BackgroundPickerScreen(manager: widget.themeManager),
        ];

        return Scaffold(
          body: AppBackgroundWrapper(
            preferences: preferences,
            child: IndexedStack(index: _index, children: pages),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (int value) {
              setState(() => _index = value);
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.play_circle_outline_rounded),
                selectedIcon: Icon(Icons.play_circle_rounded),
                label: 'Player',
              ),
              NavigationDestination(
                icon: Icon(Icons.library_music_outlined),
                selectedIcon: Icon(Icons.library_music_rounded),
                label: 'Library',
              ),
              NavigationDestination(
                icon: Icon(Icons.equalizer_rounded),
                selectedIcon: Icon(Icons.equalizer_rounded),
                label: 'EQ',
              ),
              NavigationDestination(
                icon: Icon(Icons.wallpaper_outlined),
                selectedIcon: Icon(Icons.wallpaper_rounded),
                label: 'Theme',
              ),
            ],
          ),
        );
      },
    );
  }

  void _togglePlayPause() {
    if (!_playerState.hasTrack) {
      return;
    }

    setState(() {
      _playerState = _playerState.copyWith(
        isPlaying: !_playerState.isPlaying,
      );
    });
  }

  void _seek(double progress) {
    final PlayerTrack? track = _playerState.track;
    if (track == null) {
      return;
    }

    setState(() {
      _playerState = _playerState.copyWith(
        position: Duration(
          milliseconds: (track.duration.inMilliseconds * progress).round(),
        ),
      );
    });
  }

  void _toggleShuffle() {
    setState(() {
      _playerState = _playerState.copyWith(
        isShuffleEnabled: !_playerState.isShuffleEnabled,
      );
    });
  }

  void _cycleRepeat() {
    setState(() {
      _playerState = _playerState.copyWith(
        repeatMode: _playerState.repeatMode.next,
      );
    });
  }

  void _toggleNightclub() {
    setState(() {
      _playerState = _playerState.copyWith(
        isNightclubEnabled: !_playerState.isNightclubEnabled,
      );
    });
  }

  void _previous() {
    setState(() {
      _playerState = _playerState.copyWith(
        position: Duration.zero,
        isPlaying: true,
      );
    });
  }

  void _next() {
    setState(() {
      _playerState = _playerState.copyWith(
        position: Duration.zero,
        isPlaying: true,
      );
    });
  }
}
