import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/data/demo_data.dart';

class MusicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MusicAppBar({
    super.key,
    required this.title,
    this.leading = Icons.arrow_back_ios_new,
    this.onLeading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final IconData leading;
  final VoidCallback? onLeading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      leading: IconButton(
        icon: Icon(leading, size: 20),
        onPressed:
            onLeading ??
            () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
      ),
      actions: actions,
    );
  }
}

class AuraLogo extends StatelessWidget {
  const AuraLogo({super.key, this.size = 66, this.light = false});

  final double size;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _AuraLogoPainter(light: light)),
    );
  }
}

class _AuraLogoPainter extends CustomPainter {
  const _AuraLogoPainter({required this.light});

  final bool light;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: light
            ? const [Colors.white, Color(0x88FFFFFF), Colors.white]
            : const [
                AppColors.cyan,
                AppColors.blue,
                AppColors.purple,
                AppColors.cyan,
              ],
      ).createShader(rect);
    canvas.drawArc(
      rect.deflate(paint.strokeWidth / 2),
      -1.2,
      5.25,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_AuraLogoPainter oldDelegate) =>
      oldDelegate.light != light;
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 52,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: appGradient,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26349EF2),
              blurRadius: 16,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onPressed,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    this.playing = false,
    this.size = 76,
    this.onPressed,
  });

  final bool playing;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: appGradient,
        boxShadow: [
          BoxShadow(
            color: Color(0x44349EF2),
            blurRadius: 20,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        iconSize: size * .36,
        color: Colors.white,
        icon: Icon(playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.asset,
    this.size = 64,
    this.width,
    this.height,
    this.circle = false,
    this.hole = false,
    this.radius = 3,
    this.fit = BoxFit.cover,
  });

  final String asset;
  final double size;
  final double? width;
  final double? height;
  final bool circle;
  final bool hole;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      asset,
      width: width ?? size,
      height: height ?? size,
      fit: fit,
      errorBuilder: (_, _, _) => Container(
        width: width ?? size,
        height: height ?? size,
        color: context.palette.faint,
        child: const Icon(Icons.music_note, color: AppColors.muted),
      ),
    );
    final clipped = circle
        ? ClipOval(child: image)
        : ClipRRect(borderRadius: BorderRadius.circular(radius), child: image);
    if (!hole) return clipped;
    return Stack(
      alignment: Alignment.center,
      children: [
        clipped,
        Container(
          width: (width ?? size) * .19,
          height: (height ?? size) * .19,
          decoration: BoxDecoration(
            color: context.palette.background,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.onSeeAll, this.subtitle});

  final String title;
  final VoidCallback? onSeeAll;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                if (subtitle != null)
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text(
                'See all',
                style: TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

class TrackTile extends StatelessWidget {
  const TrackTile({
    super.key,
    required this.track,
    this.index,
    this.onTap,
    this.compact = false,
  });

  final Track track;
  final int? index;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: compact ? 7 : 9),
        child: Row(
          children: [
            if (index != null)
              SizedBox(
                width: 27,
                child: Text(
                  '${index! + 1}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            CoverImage(
              asset: track.cover,
              size: compact ? 48 : 56,
              circle: true,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${track.artist}  ·  ${track.duration}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, color: AppColors.muted, size: 20),
          ],
        ),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    super.key,
    required this.album,
    this.circular = false,
    this.onTap,
    this.width = 150,
  });

  final Album album;
  final bool circular;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) => InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoverImage(
                asset: album.cover,
                size: constraints.maxWidth,
                circle: circular,
                hole: circular,
              ),
              const SizedBox(height: 10),
              Text(
                album.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                album.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (!circular)
                Text(album.year, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class Waveform extends StatelessWidget {
  const Waveform({
    super.key,
    this.height = 54,
    this.progress = .68,
    this.color = AppColors.cyan,
  });

  final double height;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _WaveformPainter(
        progress: progress,
        color: color,
        inactiveColor: context.palette.control,
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  const _WaveformPainter({
    required this.progress,
    required this.color,
    required this.inactiveColor,
  });

  final double progress;
  final Color color;
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    const count = 52;
    final step = size.width / count;
    final paint = Paint()..strokeWidth = 1.7;
    for (var i = 0; i < count; i++) {
      final amplitude = (math.sin(i * 1.77).abs() * .65 + .15) * size.height;
      paint.color = i / count <= progress ? color : inactiveColor;
      final x = i * step + step / 2;
      canvas.drawLine(
        Offset(x, (size.height - amplitude) / 2),
        Offset(x, (size.height + amplitude) / 2),
        paint,
      );
    }
    final knobX = size.width * progress;
    canvas.drawCircle(
      Offset(knobX, size.height / 2),
      4,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_WaveformPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.inactiveColor != inactiveColor;
}

class PageDots extends StatelessWidget {
  const PageDots({
    super.key,
    required this.index,
    required this.count,
    this.light = false,
  });

  final int index;
  final int count;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        return Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == index
                ? AppColors.cyan
                : light
                ? Colors.white70
                : context.palette.control,
          ),
        );
      }),
    );
  }
}

class SoftTab extends StatelessWidget {
  const SoftTab({
    super.key,
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
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
        decoration: BoxDecoration(
          gradient: selected ? appGradient : null,
          color: selected ? null : context.palette.faint,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : context.palette.ink,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ContentScroll extends StatelessWidget {
  const ContentScroll({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(25, 12, 25, 30),
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView(padding: padding, children: children),
    );
  }
}
