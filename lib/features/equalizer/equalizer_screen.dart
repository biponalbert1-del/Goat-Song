import 'package:flutter/material.dart';

class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bands = <String>['60', '170', '310', '600', '1K', '3K', '6K', '14K'];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Equalizer Pro',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: bands
                        .map(
                          (String band) => Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: Slider(
                                      value: 0.55,
                                      onChanged: (_) {},
                                    ),
                                  ),
                                ),
                                Text(band, maxLines: 1),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
