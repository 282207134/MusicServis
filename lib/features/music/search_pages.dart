import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: controller,
          autofocus: false,
          decoration: const InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search, size: 20),
            suffixIcon: Icon(Icons.close, size: 20),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.cyan,
              child: Icon(Icons.mic, color: Colors.white),
            ),
            title: const Text('Magic search'),
            subtitle: const Text('Determine which song is playing'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.identify),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('History', style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Clean',
                  style: TextStyle(color: AppColors.muted),
                ),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CoverImage(
              asset: 'assets/images/heart_shaped_box.png',
              size: 54,
              circle: true,
            ),
            title: const Text('Nirvana'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.artist),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CoverImage(
              asset: 'assets/images/breaking_benjamin.png',
              size: 54,
              circle: true,
            ),
            title: const Text('Breaking Benjamin'),
            onTap: () => Navigator.pushNamed(context, AppRoutes.artist),
          ),
          const SizedBox(height: 20),
          Text('Genres', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _GenreRow(
            'Pop',
            'Pop music, Disco, K-pop',
            Color(0xFFFFC857),
            Icons.music_note,
          ),
          const _GenreRow(
            'Indie',
            'Independent artists',
            Color(0xFF35D49A),
            Icons.rocket_launch_outlined,
          ),
          const _GenreRow(
            'Rock',
            'Rock, rock and roll, Progressive rock',
            Color(0xFFF05691),
            Icons.music_note,
          ),
          const _GenreRow(
            'Metal',
            'Classic, nu metal, epic, progressive',
            AppColors.purple,
            Icons.music_note,
          ),
        ],
      ),
    );
  }
}

class IdentifyPage extends StatelessWidget {
  const IdentifyPage({super.key});

  @override
  Widget build(BuildContext context) => const _IdentifyView(stage: 0);
}

class IdentifyListeningPage extends StatelessWidget {
  const IdentifyListeningPage({super.key});

  @override
  Widget build(BuildContext context) => const _IdentifyView(stage: 1);
}

class IdentifyResultPage extends StatefulWidget {
  const IdentifyResultPage({super.key});

  @override
  State<IdentifyResultPage> createState() => _IdentifyResultPageState();
}

class _IdentifyResultPageState extends State<IdentifyResultPage> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'Identify'),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const CoverImage(
                  asset: DemoData.saint,
                  size: 220,
                  circle: true,
                ),
                const SizedBox(height: 28),
                Text(
                  'Let Me Live My Life',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(
                  'Saint Asonia',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 30),
                PlayButton(
                  playing: playing,
                  size: 68,
                  onPressed: () => setState(() => playing = !playing),
                ),
                const SizedBox(height: 38),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.identify,
                  ),
                  child: Text(
                    'TRY AGAIN',
                    style: TextStyle(
                      color: context.palette.ink,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IdentifyView extends StatelessWidget {
  const _IdentifyView({required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'Identify'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  stage == 0
                      ? AppRoutes.identifyListening
                      : AppRoutes.identifyResult,
                ),
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (stage == 1) ...[
                        _ring(280, const Color(0x14349EF2)),
                        _ring(225, const Color(0x25349EF2)),
                        _ring(170, const Color(0x35349EF2)),
                      ] else
                        _ring(160, const Color(0x0D349EF2)),
                      const PlayButton(size: 92),
                      const Icon(Icons.mic, color: Colors.white, size: 40),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                stage == 0 ? 'Tap to identify music' : 'Listening to music',
                style: const TextStyle(color: AppColors.muted, fontSize: 15),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ring(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

class _GenreRow extends StatelessWidget {
  const _GenreRow(this.title, this.subtitle, this.color, this.icon);

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () => Navigator.pushNamed(context, AppRoutes.genres),
    );
  }
}
