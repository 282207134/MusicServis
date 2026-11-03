import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class MyMusicPage extends StatelessWidget {
  const MyMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.music_note, 'Track'),
      (Icons.album, 'Albums'),
      (Icons.person_outline, 'Artist'),
      (Icons.queue_music, 'Playlist'),
      (Icons.download_for_offline_outlined, 'Offline'),
    ];
    return Scaffold(
      appBar: MusicAppBar(
        title: 'My music',
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              gradient: appGradient,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '360 tracks',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '34 hours',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.shuffle, color: Colors.white),
                SizedBox(width: 22),
                Icon(Icons.play_circle_outline, color: Colors.white, size: 30),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...items.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(item.$1, size: 21, color: AppColors.muted),
              title: Text(item.$2, style: const TextStyle(fontSize: 14)),
              onTap: () => Navigator.pushNamed(context, AppRoutes.album),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Last listened',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 66,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) => CoverImage(
                asset: DemoData.singles[index].cover,
                size: 62,
                circle: true,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...DemoData.popularTracks
              .take(3)
              .map(
                (track) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CoverImage(asset: track.cover, size: 64),
                  title: Text(track.artist),
                  subtitle: Text('${track.title}  ·  8 albums — 88 tracks'),
                  trailing: const Icon(Icons.more_vert, color: AppColors.muted),
                  onTap: () => Navigator.pushNamed(context, AppRoutes.artist),
                ),
              ),
        ],
      ),
    );
  }
}
