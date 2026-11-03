import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MusicAppBar(
        title: '',
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _hero(
            image: DemoData.ember,
            height: 320,
            onPlay: () => Navigator.pushNamed(context, AppRoutes.player),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ember', style: Theme.of(context).textTheme.headlineLarge),
                const Text(
                  'Breaking Benjamin  ·  2018',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                ...DemoData.emberTracks.asMap().entries.map((entry) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.player),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 26,
                            child: Text(
                              '${entry.key + 1}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Expanded(child: Text(entry.value)),
                          Text(
                            '3:${20 + entry.key}'.padLeft(4, '0'),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                SectionHeader(
                  'More albums',
                  onSeeAll: () =>
                      Navigator.pushNamed(context, AppRoutes.newAlbum),
                ),
                _albumRail(const [
                  Album(
                    'Dark Before Dawn',
                    'Breaking Benjamin',
                    'assets/images/dark_before_dawn.png',
                    '2015',
                  ),
                  Album(
                    'Dear Agony',
                    'Breaking Benjamin',
                    'assets/images/dear_agony.png',
                    '2009',
                  ),
                  Album('Ember', 'Breaking Benjamin', DemoData.ember, '2018'),
                ]),
                const SizedBox(height: 28),
                SectionHeader(
                  'New albums',
                  subtitle: 'Alternative',
                  onSeeAll: () =>
                      Navigator.pushNamed(context, AppRoutes.newAlbum),
                ),
                _albumRail(DemoData.albums.take(3).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MusicAppBar(
        title: '',
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _hero(
            image: 'assets/images/breaking_benjamin.png',
            height: 250,
            onPlay: () => Navigator.pushNamed(context, AppRoutes.player),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 16, 25, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Breaking Benjamin',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Alternative',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 12),
                const Text(
                  'American rock band from Wilkes-Barre, Pennsylvania, founded in 1999 by lead singer and guitarist Benjamin Burnley and drummer Jeremy Hummel.',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader('Popular tracks', onSeeAll: _noOp),
                ...DemoData.popularTracks.map(
                  (track) => TrackTile(
                    track: track,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.player),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader('Albums', onSeeAll: _noOp),
                _albumRail(const [
                  Album(
                    'Dark Before Dawn',
                    'Breaking Benjamin',
                    'assets/images/dark_before_dawn.png',
                    '2015',
                  ),
                  Album(
                    'Dear Agony',
                    'Breaking Benjamin',
                    'assets/images/dear_agony.png',
                    '2009',
                  ),
                  Album('Ember', 'Breaking Benjamin', DemoData.ember, '2018'),
                ]),
                const SizedBox(height: 28),
                const SectionHeader('Similar artists', onSeeAll: _noOp),
                _albumRail(const [
                  Album(
                    'Saint Asonia',
                    'Alternative',
                    'assets/images/saint_asonia_band.png',
                    '',
                  ),
                  Album(
                    'The Pretty Reckless',
                    'Rock, alternative',
                    'assets/images/pretty_reckless.png',
                    '',
                  ),
                  Album(
                    'Breaking Benjamin',
                    'Rock, alternative',
                    'assets/images/breaking_benjamin.png',
                    '',
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _noOp() {}

Widget _hero({
  required String image,
  required double height,
  required VoidCallback onPlay,
}) {
  return SizedBox(
    height: height,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(image, fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black26, Colors.transparent, Colors.black38],
            ),
          ),
        ),
        Positioned(
          right: 24,
          bottom: 20,
          child: PlayButton(size: 56, onPressed: onPlay),
        ),
      ],
    ),
  );
}

Widget _albumRail(List<Album> albums) {
  return SizedBox(
    height: 215,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: albums.length,
      separatorBuilder: (_, _) => const SizedBox(width: 16),
      itemBuilder: (context, index) => AlbumCard(
        album: albums[index],
        width: 145,
        onTap: () => Navigator.pushNamed(context, AppRoutes.album),
      ),
    ),
  );
}
