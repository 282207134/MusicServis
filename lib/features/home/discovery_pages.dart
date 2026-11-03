import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class RadioPage extends StatelessWidget {
  const RadioPage({super.key});

  @override
  Widget build(BuildContext context) {
    const stations = [
      ('Rockabilly Radio', 'Psychobilly', 'assets/images/rock.png'),
      (
        'Wild Rock Radio',
        'Nightwish - Planet Hell',
        'assets/images/alternative.png',
      ),
      ('Rock On', 'AC/DC - Big Balls', 'assets/images/saint_asonia.png'),
      ('Paradise', 'Jethro Tull - Nothing Is Easy', 'assets/images/ember.png'),
    ];
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Radio',
        leading: Icons.menu,
        onLeading: () => Navigator.pushNamed(context, AppRoutes.menu),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ContentScroll(
        children: [
          const SectionHeader('Service station', onSeeAll: _noOp),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _stationCard(
                  'Alternative',
                  'assets/images/alternative.png',
                  () => Navigator.pushNamed(context, AppRoutes.alternative),
                ),
                const SizedBox(width: 14),
                _stationCard(
                  'Rock',
                  'assets/images/rock.png',
                  () => Navigator.pushNamed(context, AppRoutes.rock),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const SectionHeader('Radio station', onSeeAll: _noOp),
          ...stations.map(
            (station) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CoverImage(asset: station.$3, size: 58, circle: true),
              title: Text(station.$1),
              subtitle: Text(station.$2),
              onTap: () => Navigator.pushNamed(context, AppRoutes.alternative),
            ),
          ),
        ],
      ),
    );
  }
}

class AlternativePage extends StatefulWidget {
  const AlternativePage({super.key});

  @override
  State<AlternativePage> createState() => _AlternativePageState();
}

class _AlternativePageState extends State<AlternativePage> {
  bool playing = true;
  bool favorite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Alternative',
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.alternativeTuner),
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const CoverImage(asset: DemoData.saint, size: 238, circle: true),
            const SizedBox(height: 28),
            Text(
              'Let Me Live My Life',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text(
              'Saint Asonia',
              style: TextStyle(color: AppColors.muted),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => setState(() => favorite = !favorite),
                  icon: Icon(
                    Icons.favorite,
                    color: favorite ? AppColors.pink : AppColors.muted,
                  ),
                ),
                PlayButton(
                  playing: playing,
                  onPressed: () => setState(() => playing = !playing),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.lyrics),
                  icon: const Icon(Icons.graphic_eq, color: AppColors.cyan),
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Waveform(height: 42),
            ),
            const SizedBox(height: 24),
            _miniPlayer(context),
          ],
        ),
      ),
    );
  }
}

class AlternativeTunerPage extends StatefulWidget {
  const AlternativeTunerPage({super.key});

  @override
  State<AlternativeTunerPage> createState() => _AlternativeTunerPageState();
}

class _AlternativeTunerPageState extends State<AlternativeTunerPage> {
  double energy = .35;
  double feeling = .78;
  int filter = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'Alternative'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            const Center(
              child: Text(
                'What music will play?',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            const SizedBox(height: 34),
            Text('Energy', style: Theme.of(context).textTheme.headlineMedium),
            _tunerSlider(
              'Quietly',
              'Energetic',
              energy,
              (value) => setState(() => energy = value),
            ),
            const SizedBox(height: 30),
            Text('Feeling', style: Theme.of(context).textTheme.headlineMedium),
            _tunerSlider(
              'Sad',
              'Happy',
              feeling,
              (value) => setState(() => feeling = value),
            ),
            const SizedBox(height: 34),
            Text('Tracks', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ['ALL', 'RARE', 'FAVORITE', 'POPULAR']
                  .asMap()
                  .entries
                  .map((entry) {
                    return SoftTab(
                      label: entry.value,
                      selected: filter == entry.key,
                      onTap: () => setState(() => filter = entry.key),
                    );
                  })
                  .toList(),
            ),
            const SizedBox(height: 40),
            _miniPlayer(context),
          ],
        ),
      ),
    );
  }

  Widget _tunerSlider(
    String left,
    String right,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(left, style: const TextStyle(color: AppColors.muted)),
            Text(right, style: const TextStyle(color: AppColors.muted)),
          ],
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.cyan,
          inactiveColor: const Color(0xFFE9F4F2),
        ),
      ],
    );
  }
}

class GenresPage extends StatelessWidget {
  const GenresPage({super.key});

  @override
  Widget build(BuildContext context) => const _GenreLandingPage(
    title: 'Genres',
    headline: 'Music of all genres',
    image: 'assets/images/genres.png',
  );
}

class RockPage extends StatelessWidget {
  const RockPage({super.key});

  @override
  Widget build(BuildContext context) => const _GenreLandingPage(
    title: 'Rock',
    headline: 'Rock',
    image: 'assets/images/rock.png',
  );
}

class _GenreLandingPage extends StatelessWidget {
  const _GenreLandingPage({
    required this.title,
    required this.headline,
    required this.image,
  });

  final String title;
  final String headline;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MusicAppBar(
        title: title,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.genreList),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 245,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(image, fit: BoxFit.cover),
                Container(color: Colors.black38),
                Center(
                  child: Text(
                    headline,
                    style: const TextStyle(color: Colors.white, fontSize: 27),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 22, 25, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader('Hot playlists', onSeeAll: _noOp),
                SizedBox(
                  height: 172,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      _PlaylistTile(
                        'Beautiful and sad',
                        'assets/images/genres.png',
                      ),
                      _PlaylistTile(
                        'Intelligent music',
                        'assets/images/alternative.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const SectionHeader('Popular artist', onSeeAll: _noOp),
                SizedBox(
                  height: 92,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: DemoData.singles.take(5).map((album) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: CoverImage(
                          asset: album.cover,
                          size: 76,
                          circle: true,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SectionHeader('New albums', onSeeAll: _noOp),
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, _) => const SizedBox(width: 14),
                    itemBuilder: (context, index) =>
                        AlbumCard(album: DemoData.albums[index], width: 140),
                  ),
                ),
                const SizedBox(height: 22),
                const SectionHeader('Popular tracks', onSeeAll: _noOp),
                ...DemoData.tracks
                    .take(5)
                    .map(
                      (track) => TrackTile(
                        track: track,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.player),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GenreListPage extends StatefulWidget {
  const GenreListPage({super.key});

  @override
  State<GenreListPage> createState() => _GenreListPageState();
}

class _GenreListPageState extends State<GenreListPage> {
  final selected = {'Rock'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'LIST OF GENRES', leading: Icons.close),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: DemoData.genres.map((genre) {
              final active = selected.contains(genre);
              return GestureDetector(
                onTap: () => setState(
                  () => active ? selected.remove(genre) : selected.add(genre),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: active ? AppColors.cyan : context.palette.faint,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        genre,
                        style: TextStyle(
                          color: active ? Colors.white : context.palette.ink,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        active ? Icons.expand_less : Icons.expand_more,
                        size: 15,
                        color: active ? Colors.white : context.palette.ink,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (selected.contains('Rock')) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: appGradient,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Wrap(
                spacing: 22,
                runSpacing: 20,
                children: DemoData.genres.take(8).skip(1).map((genre) {
                  return Text(
                    genre,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  );
                }).toList(),
              ),
            ),
          ],
          const SizedBox(height: 24),
          GradientButton(
            label: 'SHOW ROCK MUSIC',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.rock),
          ),
        ],
      ),
    );
  }
}

Widget _stationCard(String title, String asset, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 285,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(asset, fit: BoxFit.cover),
            Container(color: Colors.black26),
            Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 27),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _miniPlayer(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, AppRoutes.player),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 16)],
      ),
      child: Row(
        children: [
          const CoverImage(asset: DemoData.saint, size: 48, circle: true),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Let Me Live My Life'),
                Text(
                  'Saint Asonia',
                  style: TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.pause, color: AppColors.cyan),
          ),
        ],
      ),
    ),
  );
}

class _PlaylistTile extends StatelessWidget {
  const _PlaylistTile(this.title, this.asset);

  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoverImage(asset: asset, width: 145, height: 125),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 13)),
          const Text(
            '50 tracks',
            style: TextStyle(color: AppColors.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

void _noOp() {}
