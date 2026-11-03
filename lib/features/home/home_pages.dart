import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Home',
        leading: Icons.menu,
        onLeading: () => Navigator.pushNamed(context, AppRoutes.menu),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.aura),
            icon: const AuraLogo(size: 27),
          ),
        ],
      ),
      body: ContentScroll(
        children: [
          SectionHeader(
            'New release',
            subtitle: 'tracks, albums and compilations',
            onSeeAll: () => Navigator.pushNamed(context, AppRoutes.newSingle),
          ),
          _coverRail(DemoData.singles.take(4).toList(), circular: true),
          const SizedBox(height: 28),
          SectionHeader(
            'Chart',
            onSeeAll: () => Navigator.pushNamed(context, AppRoutes.chart),
          ),
          ...DemoData.tracks
              .take(5)
              .toList()
              .asMap()
              .entries
              .map(
                (entry) => TrackTile(
                  track: entry.value,
                  index: entry.key,
                  compact: true,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.player),
                ),
              ),
          const SizedBox(height: 24),
          SectionHeader(
            'Hot playlists',
            onSeeAll: () =>
                Navigator.pushNamed(context, AppRoutes.recommendations),
          ),
          _playlistGrid(),
          const SizedBox(height: 28),
          SectionHeader(
            'Selections',
            onSeeAll: () => Navigator.pushNamed(context, AppRoutes.genres),
          ),
          _selectionGrid(),
        ],
      ),
    );
  }
}

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Recommendations',
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tune))],
      ),
      body: ContentScroll(
        children: [
          const SectionHeader('Playlists'),
          _playlistGrid(),
          const SizedBox(height: 28),
          const SectionHeader('Tracks for you'),
          ...DemoData.tracks
              .take(6)
              .map(
                (track) => TrackTile(
                  track: track,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.player),
                ),
              ),
          const SizedBox(height: 24),
          SectionHeader(
            'New albums',
            onSeeAll: () => Navigator.pushNamed(context, AppRoutes.newAlbum),
          ),
          _coverRail(DemoData.albums.take(4).toList()),
        ],
      ),
    );
  }
}

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Chart',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
        ],
      ),
      body: ContentScroll(
        children: [
          Text(
            'Tracks that are\npopular right now',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerLeft,
            child: SoftTab(label: '↻  SHUFFLE', selected: true, onTap: () {}),
          ),
          const SizedBox(height: 14),
          ...DemoData.tracks.asMap().entries.map(
            (entry) => TrackTile(
              track: entry.value,
              index: entry.key,
              onTap: () => Navigator.pushNamed(context, AppRoutes.player),
            ),
          ),
        ],
      ),
    );
  }
}

class NewSinglePage extends StatelessWidget {
  const NewSinglePage({super.key});

  @override
  Widget build(BuildContext context) => const NewReleasePage(initialTab: 0);
}

class NewAlbumPage extends StatelessWidget {
  const NewAlbumPage({super.key});

  @override
  Widget build(BuildContext context) => const NewReleasePage(initialTab: 1);
}

class NewReleasePage extends StatefulWidget {
  const NewReleasePage({super.key, required this.initialTab});

  final int initialTab;

  @override
  State<NewReleasePage> createState() => _NewReleasePageState();
}

class _NewReleasePageState extends State<NewReleasePage> {
  late int tab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    final items = tab == 0 ? DemoData.singles : DemoData.albums;
    return Scaffold(
      appBar: MusicAppBar(
        title: 'New release',
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _releaseTab('Single', 0),
                const SizedBox(width: 28),
                _releaseTab('Album', 1),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(25, 4, 25, 28),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 24,
                  childAspectRatio: .68,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) => AlbumCard(
                  album: items[index],
                  circular: tab == 0,
                  width: double.infinity,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.album),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _releaseTab(String label, int index) {
    final selected = tab == index;
    return GestureDetector(
      onTap: () => setState(() => tab = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.cyan : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? context.palette.ink : AppColors.muted,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

Widget _coverRail(List<Album> albums, {bool circular = false}) {
  return SizedBox(
    height: circular ? 142 : 205,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: albums.length,
      separatorBuilder: (_, _) => const SizedBox(width: 16),
      itemBuilder: (context, index) => AlbumCard(
        album: albums[index],
        width: circular ? 82 : 135,
        circular: circular,
        onTap: () => Navigator.pushNamed(context, AppRoutes.album),
      ),
    ),
  );
}

Widget _playlistGrid() {
  const playlists = [
    ('Just rock it', 'assets/images/rock.png'),
    ('Hype', 'assets/images/alternative.png'),
    ("Loud new month's", 'assets/images/genres.png'),
    ('Alternative', 'assets/images/alternative.png'),
  ];
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 16,
    mainAxisSpacing: 22,
    childAspectRatio: .72,
    children: playlists.map((item) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoverImage(
            asset: item.$2,
            width: double.infinity,
            height: 145,
            radius: 5,
          ),
          const SizedBox(height: 9),
          Text(
            item.$1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const Text(
            '50 tracks  ·  547 likes',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColors.muted, fontSize: 11),
          ),
        ],
      );
    }).toList(),
  );
}

Widget _selectionGrid() {
  const selections = [
    ('Genre day', 'assets/images/genres.png'),
    ('Spring', 'assets/images/alternative.png'),
    ('Trend', 'assets/images/rock.png'),
    ('Eternal hits', 'assets/images/ember.png'),
    ('Soul', 'assets/images/backbone.png'),
    ('Rock', 'assets/images/rock.png'),
    ('Dance', 'assets/images/piece_of_me.png'),
    ('POP', 'assets/images/rescue_me.png'),
    ('Energetic', 'assets/images/numb.png'),
    ('Rap', 'assets/images/route_one.png'),
    ('Background', 'assets/images/genres.png'),
    ('Alternative', 'assets/images/alternative.png'),
  ];
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 16,
    mainAxisSpacing: 14,
    childAspectRatio: 1.65,
    children: selections.map((item) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.$2, fit: BoxFit.cover),
            Container(color: Colors.black26),
            Center(
              child: Text(
                item.$1,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
