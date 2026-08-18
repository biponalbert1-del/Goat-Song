import 'package:flutter/material.dart';

class LibraryMainScreen extends StatelessWidget {
  const LibraryMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_LibraryEntry> entries = <_LibraryEntry>[
      const _LibraryEntry('Titres', Icons.music_note_rounded),
      const _LibraryEntry('Albums', Icons.album_rounded),
      const _LibraryEntry('Artistes', Icons.person_rounded),
      const _LibraryEntry('Favoris', Icons.favorite_rounded),
      const _LibraryEntry('Lus recemment', Icons.history_rounded),
      const _LibraryEntry('Playlists', Icons.queue_music_rounded),
    ];

    return SafeArea(
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.18,
        ),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          final _LibraryEntry entry = entries[index];
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      entry.icon,
                      size: 34,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      entry.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LibraryEntry {
  const _LibraryEntry(this.label, this.icon);

  final String label;
  final IconData icon;
}
