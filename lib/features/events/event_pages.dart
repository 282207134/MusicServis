import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';
import 'package:music_servis/shared/widgets.dart';

const _imagineImage = 'assets/images/imagine_dragons.png';
const _rockImage = 'assets/images/event_rock.png';
const _tributeImage = 'assets/images/event_tribute.png';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth = screenWidth < 390 ? screenWidth - 50 : 340.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 66,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.menu),
          icon: const Icon(Icons.menu),
        ),
        title: const Column(
          children: [
            Text('Events', style: TextStyle(fontSize: 20)),
            SizedBox(height: 2),
            Text(
              'Moscow, Russia',
              style: TextStyle(color: AppColors.muted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search, size: 27),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(25, 14, 25, 32),
        children: [
          SizedBox(
            height: 266,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) => SizedBox(
                width: cardWidth,
                child: index == 0
                    ? const _EventCard(
                        image: _imagineImage,
                        title: 'Imagine Dragons',
                        venue: 'Moscow, big sports arena «Luzhniki»',
                        date: 'August 29, 19:00',
                        tags: ['CONCERT', 'ROCK'],
                      )
                    : const _EventCard(
                        image: _tributeImage,
                        title: 'Tribute To Grigory Leps',
                        venue: 'Moscow, Olympic',
                        date: 'July 16, 20:00',
                        tags: ['STAGE', 'POP'],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          SectionHeader('Moscow halls', onSeeAll: () {}),
          const _VenueTile(
            image: _rockImage,
            title: 'Kremlin palace',
            subtitle: 'Concert hall',
          ),
          const _VenueTile(
            image: _imagineImage,
            title: 'Olympic',
            subtitle: 'Concert hall, sports complex',
          ),
          const _VenueTile(
            image: _tributeImage,
            title: 'Otkritie Arena',
            subtitle: 'Concert hall, stadion',
          ),
          const _VenueTile(
            image: _rockImage,
            title: 'Crocus City Hall',
            subtitle: 'Concert halls',
          ),
          const SizedBox(height: 25),
          SectionHeader('Popular music', onSeeAll: () {}),
          SizedBox(
            height: 256,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              itemBuilder: (context, index) => SizedBox(
                width: cardWidth,
                child: index == 0
                    ? const _EventCard(
                        image: _tributeImage,
                        title: 'Tribute To Grigory Leps',
                        venue: 'Moscow, Olympic',
                        date: 'July 16, 20:00',
                        tags: ['STAGE', 'POP'],
                        imageHeight: 164,
                      )
                    : const _EventCard(
                        image: _imagineImage,
                        title: 'Imagine Dragons',
                        venue: 'Moscow, big sports arena «Luzhniki»',
                        date: 'August 29, 19:00',
                        tags: ['CONCERT', 'ROCK'],
                        imageHeight: 164,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          const SectionHeader('In genres'),
          const _GenreCard(
            image: _rockImage,
            title: 'Rock',
            events: '254 Events',
          ),
          const SizedBox(height: 12),
          const _GenreCard(
            image: _tributeImage,
            title: 'Rap',
            events: '204 Events',
          ),
          const SizedBox(height: 12),
          const _GenreCard(
            image: _imagineImage,
            title: 'Classic',
            events: '204 Events',
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.image,
    required this.title,
    required this.venue,
    required this.date,
    required this.tags,
    this.imageHeight = 174,
  });

  final String image;
  final String title;
  final String venue;
  final String date;
  final List<String> tags;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRoutes.eventDetail),
      borderRadius: BorderRadius.circular(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x24000000),
                  blurRadius: 13,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: Stack(
              children: [
                CoverImage(
                  asset: image,
                  width: double.infinity,
                  height: imageHeight,
                  radius: 7,
                ),
                Positioned(
                  left: 14,
                  bottom: 13,
                  child: Row(
                    children: [
                      for (final tag in tags)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 3),
          Text(
            venue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(date, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _VenueTile extends StatelessWidget {
  const _VenueTile({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          CoverImage(asset: image, size: 64, circle: true),
          const SizedBox(width: 17),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenreCard extends StatelessWidget {
  const _GenreCard({
    required this.image,
    required this.title,
    required this.events,
  });

  final String image;
  final String title;
  final String events;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xB3000000), Color(0x16000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    events,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            backgroundColor: context.palette.background,
            foregroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _imagineImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x08000000), Color(0x9E000000)],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 25,
                    right: 25,
                    bottom: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Imagine Dragons',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Moscow, big sports arena «Luzhniki»',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'August 29, 19:00',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 36, 25, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientButton(
                    label: 'BUY TICKETS',
                    height: 60,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.zone),
                  ),
                  const SizedBox(height: 42),
                  Text(
                    'About the concert',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Attention! Due to the change in the timing of the concert, doors will open one hour earlier. Join us for an unforgettable night of music, light and energy at Luzhniki.',
                    maxLines: _expanded ? null : 2,
                    overflow: _expanded ? null : TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 42),
                        foregroundColor: AppColors.muted,
                      ),
                      child: Text(_expanded ? 'READ LESS' : 'READ MORE'),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CoverImage(
                          asset: _imagineImage,
                          width: double.infinity,
                          height: 100,
                          radius: 7,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CoverImage(
                          asset: _tributeImage,
                          width: double.infinity,
                          height: 100,
                          radius: 7,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Stack(
                          children: [
                            CoverImage(
                              asset: _rockImage,
                              width: double.infinity,
                              height: 100,
                              radius: 7,
                            ),
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: const Center(
                                  child: Text(
                                    '+5',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  Text(
                    'Best track',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 15),
                  for (final track in DemoData.eventTracks)
                    _EventTrack(track: track),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventTrack extends StatelessWidget {
  const _EventTrack({required this.track});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          CoverImage(asset: track.cover, size: 60, circle: true, hole: true),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(track.title, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  '${track.artist} · ${track.duration}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: AppColors.muted, size: 20),
        ],
      ),
    );
  }
}

class ZonePage extends StatefulWidget {
  const ZonePage({super.key});

  @override
  State<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
  double _zoom = 1;

  void _openZone(double verticalPosition) {
    final radioactive = verticalPosition < .42;
    Navigator.pushNamed(
      context,
      AppRoutes.zoneSeats,
      arguments: {
        'zone': radioactive ? 'Radioactive zone' : 'Dance orchestra',
        'price': radioactive ? 250 : 220,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MusicAppBar(title: 'Imagine Dragons'),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 20),
          child: Column(
            children: [
              const _PriceLegend(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapUp: (details) => _openZone(
                              details.localPosition.dy / constraints.maxHeight,
                            ),
                            child: CustomPaint(
                              painter: _VenuePainter(
                                zoom: _zoom,
                                background: context.palette.faint,
                                foreground: context.palette.ink,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: constraints.maxHeight * .43,
                          child: _ZoomControls(
                            onZoomIn: () => setState(
                              () => _zoom = math.min(1.3, _zoom + .1),
                            ),
                            onZoomOut: () => setState(
                              () => _zoom = math.max(.8, _zoom - .1),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text(
                'Tap a zone to choose your seats',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceLegend extends StatelessWidget {
  const _PriceLegend();

  @override
  Widget build(BuildContext context) {
    const prices = [80, 100, 120, 220, 250];
    const colors = [
      Color(0xFF55B8D4),
      Color(0xFF48BFB0),
      Color(0xFFE9B692),
      Color(0xFFF43F68),
      Color(0xFFA568B1),
    ];
    return Row(
      children: [
        for (var i = 0; i < prices.length; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == prices.length - 1 ? 0 : 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 4, color: colors[i]),
                  const SizedBox(height: 7),
                  Text(
                    '\$ ${prices[i]}+',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ZoomControls extends StatelessWidget {
  const _ZoomControls({required this.onZoomIn, required this.onZoomOut});

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ZoomButton(icon: Icons.add, onPressed: onZoomIn),
        const SizedBox(height: 14),
        _ZoomButton(icon: Icons.remove, onPressed: onZoomOut),
      ],
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: context.palette.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x26349EF2),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon)),
    );
  }
}

class _VenuePainter extends CustomPainter {
  const _VenuePainter({
    required this.zoom,
    required this.background,
    required this.foreground,
  });

  final double zoom;
  final Color background;
  final Color foreground;

  @override
  void paint(Canvas canvas, Size size) {
    final fit = math.min(size.width / 320, size.height / 270) * zoom;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(fit);
    canvas.translate(-160, -135);

    const blue = Color(0xFF45ADD0);
    const teal = Color(0xFF47B9A9);
    const peach = Color(0xFFF1B091);
    const pink = Color(0xFFF43F68);
    const purple = Color(0xFFA466AD);
    const border = Colors.white;

    void seat(
      double x,
      double y,
      double w,
      double h,
      Color color, [
      double angle = 0,
    ]) {
      canvas.save();
      canvas.translate(x + w / 2, y + h / 2);
      canvas.rotate(angle);
      final rect = Rect.fromCenter(center: Offset.zero, width: w, height: h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(1)),
        Paint()..color = color,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(1)),
        Paint()
          ..color = border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      canvas.restore();
    }

    void centeredText(
      String value,
      Offset center,
      double fontSize,
      Color color,
    ) {
      final painter = TextPainter(
        text: TextSpan(
          text: value,
          style: TextStyle(color: color, fontSize: fontSize),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        center - Offset(painter.width / 2, painter.height / 2),
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(26, 38, 268, 207),
        const Radius.circular(72),
      ),
      Paint()..color = background,
    );
    canvas.drawLine(
      const Offset(88, 35),
      const Offset(232, 35),
      Paint()
        ..color = foreground
        ..strokeWidth = 4,
    );
    centeredText('Scene', const Offset(160, 25), 11, AppColors.muted);

    canvas.drawRect(
      const Rect.fromLTWH(88, 45, 144, 46),
      Paint()..color = purple,
    );
    canvas.drawRect(
      const Rect.fromLTWH(88, 45, 144, 46),
      Paint()
        ..color = border
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        const Rect.fromLTWH(88, 91, 144, 102),
        bottomLeft: const Radius.circular(29),
        bottomRight: const Radius.circular(29),
      ),
      Paint()..color = pink,
    );
    centeredText('Radioactive zone', const Offset(160, 68), 11, Colors.white);
    centeredText('Dance orchestra', const Offset(160, 140), 11, Colors.white);

    for (var row = 0; row < 8; row++) {
      seat(70, 45 + row * 18, 9, 15, row < 5 ? purple : pink);
      seat(80, 45 + row * 18, 7, 15, row < 5 ? purple : pink);
      seat(233, 45 + row * 18, 7, 15, row < 5 ? purple : pink);
      seat(241, 45 + row * 18, 9, 15, row < 5 ? purple : pink);
    }
    for (var row = 0; row < 3; row++) {
      seat(39, 56 + row * 19, 9, 16, peach);
      seat(50, 56 + row * 19, 9, 16, peach);
      seat(261, 56 + row * 19, 9, 16, peach);
      seat(272, 56 + row * 19, 9, 16, peach);
    }
    for (var row = 0; row < 4; row++) {
      seat(39, 115 + row * 18, 9, 15, teal);
      seat(50, 115 + row * 18, 9, 15, teal);
      seat(261, 115 + row * 18, 9, 15, teal);
      seat(272, 115 + row * 18, 9, 15, teal);
    }
    for (var i = 0; i < 6; i++) {
      final angle = -.48 + i * .14;
      seat(39 + i * 4, 182 + i * 6, 10, 22, blue, angle);
      seat(271 - i * 4, 182 + i * 6, 10, 22, blue, -angle);
    }
    for (var i = 0; i < 5; i++) {
      seat(67 + i * 8, 174 + i * 4, 9, 18, pink, -.5 + i * .13);
      seat(244 - i * 8, 174 + i * 4, 9, 18, pink, .5 - i * .13);
    }
    for (var i = 0; i < 8; i++) {
      seat(105 + i * 15, 193, 12, 16, peach);
      seat(105 + i * 15, 209, 12, 10, peach);
    }
    for (var row = 0; row < 2; row++) {
      for (var col = 0; col < 8; col++) {
        seat(95 + col * 17, 225 + row * 15, 14, 12, teal);
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_VenuePainter oldDelegate) =>
      oldDelegate.zoom != zoom ||
      oldDelegate.background != background ||
      oldDelegate.foreground != foreground;
}

class ZoneSeatsPage extends StatefulWidget {
  const ZoneSeatsPage({super.key});

  @override
  State<ZoneSeatsPage> createState() => _ZoneSeatsPageState();
}

class _ZoneSeatsPageState extends State<ZoneSeatsPage> {
  final Set<int> _selected = {62, 63};
  double _zoom = 1;

  bool _available(int index) {
    final row = index ~/ 12;
    return row >= 2 && (row * 17 + index % 12 * 11) % 29 != 0;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = _routeArguments(context);
    final zone = arguments['zone'] as String? ?? 'Dance orchestra';
    final price = arguments['price'] as int? ?? 220;
    final count = _selected.length;
    return Scaffold(
      appBar: const MusicAppBar(title: 'Imagine Dragons'),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(25, 12, 25, 14),
        child: GradientButton(
          label:
              'Buy $count ${count == 1 ? 'ticket' : 'tickets'} for \$${count * price}',
          height: 60,
          onPressed: () {
            if (count == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Choose at least one seat')),
              );
              return;
            }
            Navigator.pushNamed(
              context,
              AppRoutes.payment,
              arguments: {'zone': zone, 'count': count, 'total': count * price},
            );
          },
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 0),
          child: Column(
            children: [
              const _PriceLegend(),
              const SizedBox(height: 35),
              Text(
                zone,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Transform.scale(
                        scale: _zoom,
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 18),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 12,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 11,
                              ),
                          itemCount: 168,
                          itemBuilder: (context, index) {
                            final available = _available(index);
                            final selected = _selected.contains(index);
                            return GestureDetector(
                              onTap: available
                                  ? () => setState(() {
                                      if (selected) {
                                        _selected.remove(index);
                                      } else {
                                        _selected.add(index);
                                      }
                                    })
                                  : null,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? Colors.white
                                      : available
                                      ? AppColors.pink
                                      : context.palette.control,
                                  border: selected
                                      ? Border.all(
                                          color: AppColors.pink,
                                          width: 2,
                                        )
                                      : null,
                                ),
                                child: selected
                                    ? const Icon(
                                        Icons.check,
                                        size: 11,
                                        color: AppColors.pink,
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 100,
                      child: _ZoomControls(
                        onZoomIn: () =>
                            setState(() => _zoom = math.min(1.25, _zoom + .1)),
                        onZoomOut: () =>
                            setState(() => _zoom = math.max(.8, _zoom - .1)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _cardController = TextEditingController(text: '4515 4756 8748 1145');
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _nameController = TextEditingController();
  final _cvvController = TextEditingController();
  int _method = 0;
  bool _saveCard = true;

  @override
  void dispose() {
    _cardController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _nameController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: context.palette.ink, fontSize: 18),
      floatingLabelStyle: const TextStyle(color: AppColors.muted, fontSize: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: AppColors.cyan, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = _routeArguments(context);
    return Scaffold(
      appBar: const MusicAppBar(title: 'Payment'),
      body: ContentScroll(
        padding: const EdgeInsets.fromLTRB(25, 24, 25, 28),
        children: [
          Row(
            children: [
              Expanded(
                child: _PaymentMethod(
                  label: 'Card',
                  selected: _method == 0,
                  onTap: () => setState(() => _method = 0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentMethod(
                  label: 'PayPal',
                  selected: _method == 1,
                  onTap: () => setState(() => _method = 1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentMethod(
                  label: 'ApplePay',
                  selected: _method == 2,
                  onTap: () => setState(() => _method = 2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 46),
          TextField(
            controller: _cardController,
            keyboardType: TextInputType.number,
            decoration: _decoration('Card number'),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration('Month'),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration('Year'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _nameController,
            decoration: _decoration('Name'),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: _decoration('CVV'),
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Text(
                  'The last three digits\non the back of the card',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Transform.scale(
                scale: .85,
                alignment: Alignment.centerLeft,
                child: Switch(
                  value: _saveCard,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.cyan,
                  onChanged: (value) => setState(() => _saveCard = value),
                ),
              ),
              const SizedBox(width: 5),
              const Text('Save card?', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 42),
          GradientButton(
            label: 'To pay for the tickets',
            height: 60,
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.ticket,
              arguments: arguments,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 60,
        decoration: BoxDecoration(
          color: selected ? null : context.palette.surface,
          gradient: selected ? appGradient : null,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16349EF2),
              blurRadius: 13,
              offset: Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : context.palette.ink,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = _routeArguments(context);
    final count = arguments['count'] as int? ?? 2;
    final total = arguments['total'] as int? ?? 440;
    final zone = arguments['zone'] as String? ?? 'Dance orchestra';
    return Scaffold(
      appBar: const MusicAppBar(title: 'Your ticket'),
      body: ContentScroll(
        padding: const EdgeInsets.fromLTRB(25, 22, 25, 28),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x24000000),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: const CoverImage(
              asset: _imagineImage,
              width: double.infinity,
              height: 180,
              radius: 7,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Imagine Dragons',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 3),
          Text(
            'Moscow, big sports arena «Luzhniki»',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'August 29, 19:00',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 27),
          Text(
            '$count ${count == 1 ? 'ticket' : 'tickets'} in ${zone.toLowerCase()}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Price Total \$ $total',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 37),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: CustomPaint(
              painter: _BarcodePainter(color: context.palette.ink),
            ),
          ),
          const SizedBox(height: 2),
          const Center(
            child: Text(
              'Imagine Dragons 124475',
              style: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 34),
          GradientButton(
            label: 'Save for control',
            height: 60,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ticket saved for control')),
              );
            },
          ),
          const SizedBox(height: 35),
          Center(
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket ready to share')),
                );
              },
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.share_outlined, size: 30),
                    SizedBox(width: 10),
                    Text('SHARE', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarcodePainter extends CustomPainter {
  const _BarcodePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    var x = 0.0;
    var index = 0;
    while (x < size.width) {
      final width = index % 5 == 0
          ? 2.4
          : index % 3 == 0
          ? 1.5
          : .8;
      final gap = index % 4 == 0 ? 2.3 : 1.2;
      canvas.drawRect(
        Rect.fromLTWH(x, 0, math.min(width, size.width - x), size.height),
        paint,
      );
      x += width + gap;
      index++;
    }
  }

  @override
  bool shouldRepaint(_BarcodePainter oldDelegate) => oldDelegate.color != color;
}

Map<String, dynamic> _routeArguments(BuildContext context) {
  final arguments = ModalRoute.of(context)?.settings.arguments;
  if (arguments is Map<String, dynamic>) return arguments;
  if (arguments is Map) return Map<String, dynamic>.from(arguments);
  return const {};
}
