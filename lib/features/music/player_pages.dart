import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool playing = true;
  bool favorite = false;
  bool shuffle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Player',
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.equalizer),
            icon: const Icon(Icons.tune),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.lyrics),
            icon: const Icon(Icons.lyrics_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(25, 12, 25, 20),
          children: [
            const SizedBox(height: 8),
            const Center(
              child: CoverImage(asset: DemoData.saint, size: 265, circle: true),
            ),
            const SizedBox(height: 28),
            Center(
              child: Text(
                'Let Me Live My Life',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Center(
              child: Text(
                'Saint Asonia',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => setState(() => favorite = !favorite),
                  icon: Icon(
                    Icons.favorite,
                    color: favorite ? AppColors.pink : AppColors.muted,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: AppColors.muted),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => setState(() => shuffle = !shuffle),
                  icon: Icon(
                    Icons.shuffle,
                    color: shuffle ? AppColors.cyan : AppColors.muted,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous, color: AppColors.muted),
                ),
                PlayButton(
                  playing: playing,
                  size: 82,
                  onPressed: () => setState(() => playing = !playing),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next, color: AppColors.cyan),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.repeat, color: AppColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Waveform(height: 52),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2:21',
                  style: TextStyle(color: AppColors.muted, fontSize: 11),
                ),
                Text(
                  '3:05',
                  style: TextStyle(color: AppColors.muted, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EqualizerPage extends StatefulWidget {
  const EqualizerPage({super.key});

  @override
  State<EqualizerPage> createState() => _EqualizerPageState();
}

class _EqualizerPageState extends State<EqualizerPage> {
  bool enabled = true;
  int preset = 2;
  double bass = .62;
  double virtualizer = .45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Equalizer',
        actions: [
          Switch(
            value: enabled,
            onChanged: (value) => setState(() => enabled = value),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['BLUES', 'JAZZ', 'ROCK', 'HEAVY METAL']
                  .asMap()
                  .entries
                  .map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SoftTab(
                        label: entry.value,
                        selected: preset == entry.key,
                        onTap: () => setState(() => preset = entry.key),
                      ),
                    );
                  })
                  .toList(),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 270,
            child: CustomPaint(
              painter: _EqualizerPainter(
                enabled: enabled,
                gridColor: context.palette.faint,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _knob(
                'Bass Boost',
                bass,
                (value) => setState(() => bass = value),
              ),
              _knob(
                'Virtualizer',
                virtualizer,
                (value) => setState(() => virtualizer = value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _knob(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        SizedBox(
          width: 112,
          height: 112,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: 5,
                color: AppColors.cyan,
                backgroundColor: context.palette.faint,
              ),
              Transform.rotate(
                angle: value * 4.8 - 2.4,
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Icon(Icons.circle, size: 7, color: AppColors.blue),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                  ),
                  child: Slider(value: value, onChanged: onChanged),
                ),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}

class LyricsPage extends StatelessWidget {
  const LyricsPage({super.key});

  @override
  Widget build(BuildContext context) => const _LyricsView(karaoke: false);
}

class KaraokePage extends StatelessWidget {
  const KaraokePage({super.key});

  @override
  Widget build(BuildContext context) => const _LyricsView(karaoke: true);
}

class _LyricsView extends StatelessWidget {
  const _LyricsView({required this.karaoke});

  final bool karaoke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 155,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(DemoData.saint),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    top: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Let Me Live My Life',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          'Saint Asonia',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        karaoke ? AppRoutes.lyrics : AppRoutes.karaoke,
                      ),
                      icon: Icon(
                        karaoke ? Icons.lyrics : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 22,
                ),
                itemCount: DemoData.lyrics.length,
                itemBuilder: (context, index) {
                  final highlighted = karaoke && index == 6;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: karaoke ? 10 : 2),
                    child: Text(
                      DemoData.lyrics[index],
                      textAlign: karaoke ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        color: highlighted
                            ? AppColors.pink
                            : karaoke
                            ? AppColors.muted
                            : context.palette.ink,
                        fontSize: karaoke ? 17 : 14,
                        height: 1.45,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 12),
              child: Waveform(height: 44),
            ),
          ],
        ),
      ),
    );
  }
}

class _EqualizerPainter extends CustomPainter {
  const _EqualizerPainter({required this.enabled, required this.gridColor});

  final bool enabled;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 0; i < 6; i++) {
      final x = size.width * i / 5;
      canvas.drawLine(Offset(x, 12), Offset(x, size.height - 25), grid);
    }
    for (var i = 0; i < 6; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final path = Path()..moveTo(0, size.height * .55);
    path.cubicTo(
      size.width * .15,
      size.height * .72,
      size.width * .28,
      size.height * .43,
      size.width * .42,
      size.height * .53,
    );
    path.cubicTo(
      size.width * .6,
      size.height * .7,
      size.width * .68,
      size.height * .12,
      size.width,
      size.height * .34,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = enabled ? AppColors.cyan : AppColors.muted
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(_EqualizerPainter oldDelegate) =>
      oldDelegate.enabled != enabled || oldDelegate.gridColor != gridColor;
}
