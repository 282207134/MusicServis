import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/shared/widgets.dart';

const _profileAsset = 'assets/images/profile.png';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _open(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final drawerWidth = MediaQuery.sizeOf(context).width * .84;
    return Scaffold(
      backgroundColor: context.palette.faint,
      body: Stack(
        children: [
          Positioned.fill(left: drawerWidth - 18, child: const _MenuBackdrop()),
          Container(
            width: drawerWidth,
            height: double.infinity,
            decoration: BoxDecoration(
              color: context.palette.background,
              boxShadow: [
                BoxShadow(
                  color: Color(0x26349EF2),
                  blurRadius: 30,
                  offset: Offset(12, 0),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _open(context, AppRoutes.aura),
                      child: const AuraLogo(size: 48),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () => _open(context, AppRoutes.profile),
                      child: Row(
                        children: [
                          const CoverImage(
                            asset: _profileAsset,
                            size: 60,
                            circle: true,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jane Foster',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'J_Foster@gmail.com',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.muted,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _MenuItem(
                            label: 'Home',
                            selected: true,
                            onTap: () => _open(context, AppRoutes.home),
                          ),
                          _MenuItem(
                            label: 'My music',
                            onTap: () => _open(context, AppRoutes.myMusic),
                          ),
                          _MenuItem(
                            label: 'Notification',
                            badge: '1',
                            onTap: () => _open(context, AppRoutes.auraChat),
                          ),
                          _MenuItem(
                            label: 'Recommendations',
                            onTap: () =>
                                _open(context, AppRoutes.recommendations),
                          ),
                          _MenuItem(
                            label: 'Genres',
                            onTap: () => _open(context, AppRoutes.genres),
                          ),
                          _MenuItem(
                            label: 'Radio',
                            onTap: () => _open(context, AppRoutes.radio),
                          ),
                          _MenuItem(
                            label: 'Events',
                            onTap: () => _open(context, AppRoutes.events),
                          ),
                          _MenuItem(
                            label: 'Settings',
                            onTap: () => _open(context, AppRoutes.settings),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => _open(context, AppRoutes.onboarding),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          minimumSize: const Size(0, 54),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'LOG OUT',
                          style: TextStyle(
                            color: AppColors.pink,
                            fontSize: 16,
                            letterSpacing: .5,
                          ),
                        ),
                      ),
                    ),
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

class _MenuBackdrop extends StatelessWidget {
  const _MenuBackdrop();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        color: context.palette.faint,
        padding: const EdgeInsets.fromLTRB(24, 70, 0, 0),
        child: Opacity(
          opacity: .55,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Icon(Icons.menu, color: context.palette.ink),
              SizedBox(height: 24),
              CoverImage(
                asset: 'assets/images/saint_asonia.png',
                width: 140,
                height: 120,
              ),
              SizedBox(height: 18),
              Text('Dark side', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 34),
              CoverImage(
                asset: 'assets/images/rescue_me.png',
                size: 54,
                circle: true,
                hole: true,
              ),
              SizedBox(height: 34),
              Text('Chart', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 20),
              CoverImage(
                asset: 'assets/images/piece_of_me.png',
                size: 54,
                circle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.label,
    required this.onTap,
    this.selected = false,
    this.badge,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.palette.ink,
                      fontSize: 20,
                      height: 1.2,
                    ),
                  ),
                ),
                if (badge != null) ...[
                  const SizedBox(width: 7),
                  Container(
                    width: 21,
                    height: 21,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ],
            ),
            if (selected) ...[
              const SizedBox(height: 3),
              Container(width: 52, height: 2, color: AppColors.cyan),
            ],
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 334,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _profileAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: const Color(0xFFADB2AE)),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x14000000), Color(0x52000000)],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.menu,
                                ),
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.onboarding,
                                ),
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const CoverImage(
                              asset: _profileAsset,
                              size: 110,
                              circle: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Jane Foster',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'J_Foster@gmail.com',
                            style: TextStyle(
                              color: Color(0xDDFFFFFF),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 28),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Music subscription',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Listen to music in high quality even without the Internet and get additional features of our service',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 26),
                  GradientButton(
                    label: 'SUBSCRIBE NOW',
                    height: 60,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.subscription),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => _message(context, 'Gift code entry'),
                    child: Text(
                      'ENTER GIFT CODE',
                      style: TextStyle(
                        color: context.palette.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => _message(context, 'Purchases restored'),
                    child: Text(
                      'RESTORE PURCHASES',
                      style: TextStyle(
                        color: context.palette.ink,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AuraLogo(size: 56),
                  IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.profile,
                        );
                      }
                    },
                    icon: const Icon(Icons.close, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 68),
              Text(
                '90 days free with\nsubscription',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 34),
              const _SubscriptionFeature(
                icon: Icons.play_circle_outline,
                label: 'Listen to any tracks',
              ),
              const _SubscriptionFeature(
                icon: Icons.cloud_download_outlined,
                label: 'without the Internet',
              ),
              const _SubscriptionFeature(
                icon: Icons.surround_sound_outlined,
                label: 'High quality',
              ),
              const _SubscriptionFeature(
                icon: Icons.speaker_group_outlined,
                label: 'Without advertising',
              ),
              const SizedBox(height: 46),
              const _TrialButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionFeature extends StatelessWidget {
  const _SubscriptionFeature({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Icon(icon, color: AppColors.cyan, size: 31),
          const SizedBox(width: 18),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _TrialButton extends StatelessWidget {
  const _TrialButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: appGradient,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33349EF2),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Your 90-day trial is ready')),
                );
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TRY FOR FREE',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(height: 2),
                Text(
                  'Next - \$3 per month',
                  style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _connection = 0;
  bool _highQuality = false;
  bool _notifications = true;

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    const connections = [
      (Icons.language, 'Wi-Fi & Internet'),
      (Icons.wifi, 'Wi-Fi only'),
      (Icons.power_settings_new, 'Offline mode'),
    ];
    return Scaffold(
      appBar: MusicAppBar(
        title: 'Settings',
        leading: Icons.menu,
        onLeading: () => Navigator.pushNamed(context, AppRoutes.menu),
      ),
      body: ContentScroll(
        padding: const EdgeInsets.fromLTRB(25, 16, 25, 32),
        children: [
          const Text(
            'Internet connection',
            style: TextStyle(color: AppColors.muted, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(connections.length, (index) {
              final item = connections[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == connections.length - 1 ? 0 : 12,
                  ),
                  child: _NetworkCard(
                    icon: item.$1,
                    label: item.$2,
                    selected: _connection == index,
                    onTap: () => setState(() => _connection = index),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 38),
          _SettingRow(
            label: 'Dark theme',
            value: AppThemeScope.of(context).isDark,
            onChanged: (value) => AppThemeScope.of(context).isDark = value,
          ),
          _SettingRow(
            label: 'High sound quality',
            value: _highQuality,
            onChanged: (value) => setState(() => _highQuality = value),
          ),
          _SettingRow(
            label: 'Notifications',
            subtitle: 'We send notifications about new tracks, albums and collections and other important things',
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          const SizedBox(height: 6),
          _SettingsLink(
            label: 'Downloaded tracks',
            subtitle: 'No music downloaded',
            onTap: () => _message('No music downloaded'),
          ),
          _SettingsLink(
            label: 'Where to save music?',
            subtitle: 'In the device memory',
            onTap: () => _message('Music is saved in the device memory'),
          ),
          _SettingsLink(
            label: 'Import tracks',
            onTap: () => _message('Import tracks'),
          ),
          _SettingsLink(
            label: 'Share the app',
            onTap: () => _message('Share the app'),
          ),
          _SettingsLink(label: 'Help', onTap: () => _message('Help')),
          _SettingsLink(
            label: 'About the application',
            onTap: () => _message('Music Servis'),
          ),
        ],
      ),
    );
  }
}

class _NetworkCard extends StatelessWidget {
  const _NetworkCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : AppColors.muted;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 88,
      decoration: BoxDecoration(
        gradient: selected ? appGradient : null,
        color: selected ? null : context.palette.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18349EF2),
            blurRadius: 16,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: foreground, size: 29),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 11,
                    height: 1.1,
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

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(label, style: Theme.of(context).textTheme.bodyLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      height: 1.25,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: _PillSwitch(
              key: ValueKey(label),
              value: value,
              onChanged: () => onChanged(!value),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillSwitch extends StatelessWidget {
  const _PillSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: value,
      child: GestureDetector(
        onTap: onChanged,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 64,
          height: 32,
          decoration: BoxDecoration(
            gradient: value ? appGradient : null,
            color: value ? null : context.palette.control,
            borderRadius: BorderRadius.circular(18),
            border: value ? Border.all(color: AppColors.cyan) : null,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Align(
                    alignment: value
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      value ? 'ON' : 'OFF',
                      style: TextStyle(
                        color: value ? Colors.white : AppColors.muted,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 180),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x18000000), blurRadius: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsLink extends StatelessWidget {
  const _SettingsLink({
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            if (subtitle != null)
              Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
