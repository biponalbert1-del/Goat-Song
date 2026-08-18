import 'package:flutter/material.dart';

import '../models/player_view_state.dart';
import 'rotating_cassette.dart';

class MainPlayerScreen extends StatelessWidget {
  const MainPlayerScreen({
    super.key,
    required this.state,
    required this.onPlayPause,
    required this.onSeek,
    required this.onShuffleToggle,
    required this.onRepeatToggle,
    required this.onNightclubToggle,
    required this.onPrevious,
    required this.onNext,
  });

  final PlayerViewState state;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;
  final VoidCallback onShuffleToggle;
  final VoidCallback onRepeatToggle;
  final VoidCallback onNightclubToggle;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.primary;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool canControl = state.hasTrack && !state.isLoading;
    final String title = state.track?.title ?? 'Aucun morceau';
    final String artist = state.track?.artist ?? 'Ajoute ta musique locale';

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        children: <Widget>[
          _PlayerHeader(hasQueue: state.hasQueue),
          const SizedBox(height: 24),
          RotatingCassette(
            isPlaying: state.isPlaying && canControl,
            accentColor: accent,
            trackTitle: title,
            artist: artist,
            progress: state.progress,
          ),
          const SizedBox(height: 24),
          if (state.errorMessage != null)
            _StatusBanner(
              icon: Icons.error_outline_rounded,
              text: state.errorMessage!,
            )
          else if (state.isLoading)
            const _StatusBanner(
              icon: Icons.sync_rounded,
              text: 'Chargement du morceau...',
            )
          else if (!state.hasTrack)
            const _StatusBanner(
              icon: Icons.library_add_rounded,
              text: 'La mediatheque est prete a recevoir les premiers titres.',
            ),
          if (state.errorMessage != null || state.isLoading || !state.hasTrack)
            const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            artist,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge?.copyWith(
              color: accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (state.track != null) ...<Widget>[
            const SizedBox(height: 8),
            Text(
              '${state.track!.album} - ${state.track!.qualityLabel}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.72),
              ),
            ),
          ],
          const SizedBox(height: 22),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 5,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: state.progress,
              onChanged: canControl ? onSeek : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(state.positionLabel),
              Text(state.remainingLabel),
            ],
          ),
          const SizedBox(height: 20),
          _ModeRail(
            state: state,
            onShuffleToggle: canControl ? onShuffleToggle : null,
            onRepeatToggle: canControl ? onRepeatToggle : null,
            onNightclubToggle: onNightclubToggle,
          ),
          const SizedBox(height: 18),
          _TransportControls(
            isPlaying: state.isPlaying,
            canControl: canControl,
            onPlayPause: onPlayPause,
            onPrevious: onPrevious,
            onNext: onNext,
          ),
          const SizedBox(height: 26),
          _PremiumPanel(
            title: 'Mix DJ',
            icon: Icons.tune_rounded,
            children: <Widget>[
              _Metric(label: 'Crossfade', value: '${state.crossfadeSeconds}s'),
              _Metric(
                label: 'Nightclub',
                value: state.isNightclubEnabled ? 'On' : 'Off',
              ),
              _Metric(label: 'EQ preset', value: state.eqPreset),
            ],
          ),
          const SizedBox(height: 14),
          _PremiumPanel(
            title: 'Session',
            icon: Icons.graphic_eq_rounded,
            children: <Widget>[
              _Metric(
                label: 'Source',
                value: state.track?.sourceLabel ?? 'Vide',
              ),
              _Metric(label: 'Repeat', value: state.repeatMode.label),
              _Metric(
                label: 'Queue',
                value: state.hasQueue ? 'Active' : 'Demo',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlayerHeader extends StatelessWidget {
  const _PlayerHeader({required this.hasQueue});

  final bool hasQueue;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.primary;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'GOAT SONG',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
              Text(
                hasQueue ? 'Queue premium active' : 'Cassette Club Player',
                style: textTheme.bodyMedium?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Recherche',
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
        ),
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.primary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(icon, color: accent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeRail extends StatelessWidget {
  const _ModeRail({
    required this.state,
    required this.onShuffleToggle,
    required this.onRepeatToggle,
    required this.onNightclubToggle,
  });

  final PlayerViewState state;
  final VoidCallback? onShuffleToggle;
  final VoidCallback? onRepeatToggle;
  final VoidCallback onNightclubToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _ModeButton(
            tooltip: 'Aleatoire',
            label: 'Shuffle',
            icon: Icons.shuffle_rounded,
            isActive: state.isShuffleEnabled,
            onPressed: onShuffleToggle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ModeButton(
            tooltip: 'Repeter',
            label: 'Repeat ${state.repeatMode.label}',
            icon: state.repeatMode == PlayerRepeatMode.one
                ? Icons.repeat_one_rounded
                : Icons.repeat_rounded,
            isActive: state.repeatMode != PlayerRepeatMode.off,
            onPressed: onRepeatToggle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ModeButton(
            tooltip: 'Mode boite de nuit',
            label: 'Club',
            icon: Icons.nightlife_rounded,
            isActive: state.isNightclubEnabled,
            onPressed: onNightclubToggle,
          ),
        ),
      ],
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.tooltip,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  });

  final String tooltip;
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color foreground =
        isActive ? colorScheme.onPrimary : colorScheme.onSurface;
    final Color background = isActive
        ? colorScheme.primary
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.72);

    return Tooltip(
      message: tooltip,
      child: FilledButton.tonalIcon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _TransportControls extends StatelessWidget {
  const _TransportControls({
    required this.isPlaying,
    required this.canControl,
    required this.onPlayPause,
    required this.onPrevious,
    required this.onNext,
  });

  final bool isPlaying;
  final bool canControl;
  final VoidCallback onPlayPause;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox.square(
          dimension: 52,
          child: IconButton.filledTonal(
            tooltip: 'Precedent',
            onPressed: canControl ? onPrevious : null,
            icon: const Icon(Icons.skip_previous_rounded),
          ),
        ),
        const SizedBox(width: 18),
        SizedBox.square(
          dimension: 76,
          child: IconButton.filled(
            tooltip: isPlaying ? 'Pause' : 'Lecture',
            onPressed: canControl ? onPlayPause : null,
            iconSize: 42,
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
          ),
        ),
        const SizedBox(width: 18),
        SizedBox.square(
          dimension: 52,
          child: IconButton.filledTonal(
            tooltip: 'Suivant',
            onPressed: canControl ? onNext : null,
            icon: const Icon(Icons.skip_next_rounded),
          ),
        ),
      ],
    );
  }
}

class _PremiumPanel extends StatelessWidget {
  const _PremiumPanel({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final Color accent = Theme.of(context).colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: accent),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(children: children),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
