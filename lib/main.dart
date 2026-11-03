import 'package:flutter/material.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/core/theme.dart';
import 'package:music_servis/features/assistant/aura_pages.dart';
import 'package:music_servis/features/auth/auth_pages.dart';
import 'package:music_servis/features/events/event_pages.dart';
import 'package:music_servis/features/home/detail_pages.dart';
import 'package:music_servis/features/home/discovery_pages.dart';
import 'package:music_servis/features/home/home_pages.dart';
import 'package:music_servis/features/music/library_pages.dart';
import 'package:music_servis/features/music/player_pages.dart';
import 'package:music_servis/features/music/search_pages.dart';
import 'package:music_servis/features/onboarding/onboarding_pages.dart';
import 'package:music_servis/features/profile/profile_pages.dart';

void main() {
  runApp(const MusicServisApp());
}

class MusicServisApp extends StatefulWidget {
  const MusicServisApp({
    super.key,
    this.initialRoute = const String.fromEnvironment(
      'INITIAL_ROUTE',
      defaultValue: AppRoutes.onboarding,
    ),
    this.initialDarkTheme = const bool.fromEnvironment('DARK_THEME'),
  });

  final String initialRoute;
  final bool initialDarkTheme;

  @override
  State<MusicServisApp> createState() => _MusicServisAppState();
}

class _MusicServisAppState extends State<MusicServisApp> {
  late final _themeController = AppThemeController()
    ..isDark = widget.initialDarkTheme;

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeScope(
      notifier: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, _) => MaterialApp(
          title: 'Aura Music',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _themeController.isDark ? ThemeMode.dark : ThemeMode.light,
          initialRoute: widget.initialRoute,
          routes: {
            AppRoutes.onboarding: (_) => const OnboardingPage(),
            AppRoutes.welcome: (_) => const WelcomePage(),
            AppRoutes.login: (_) => const LoginPage(),
            AppRoutes.hello: (_) => const HelloPage(),
            AppRoutes.preferences: (_) => const PreferencesPage(),
            AppRoutes.preferenceSong: (_) => const PreferenceSongPage(),
            AppRoutes.preferencesComplete: (_) =>
                const PreferencesCompletePage(),
            AppRoutes.home: (_) => const HomePage(),
            AppRoutes.recommendations: (_) => const RecommendationsPage(),
            AppRoutes.chart: (_) => const ChartPage(),
            AppRoutes.newSingle: (_) => const NewSinglePage(),
            AppRoutes.newAlbum: (_) => const NewAlbumPage(),
            AppRoutes.album: (_) => const AlbumPage(),
            AppRoutes.artist: (_) => const ArtistPage(),
            AppRoutes.radio: (_) => const RadioPage(),
            AppRoutes.alternative: (_) => const AlternativePage(),
            AppRoutes.alternativeTuner: (_) => const AlternativeTunerPage(),
            AppRoutes.genres: (_) => const GenresPage(),
            AppRoutes.genreList: (_) => const GenreListPage(),
            AppRoutes.rock: (_) => const RockPage(),
            AppRoutes.events: (_) => const EventsPage(),
            AppRoutes.eventDetail: (_) => const EventDetailPage(),
            AppRoutes.zone: (_) => const ZonePage(),
            AppRoutes.zoneSeats: (_) => const ZoneSeatsPage(),
            AppRoutes.payment: (_) => const PaymentPage(),
            AppRoutes.ticket: (_) => const TicketPage(),
            AppRoutes.myMusic: (_) => const MyMusicPage(),
            AppRoutes.player: (_) => const PlayerPage(),
            AppRoutes.equalizer: (_) => const EqualizerPage(),
            AppRoutes.lyrics: (_) => const LyricsPage(),
            AppRoutes.karaoke: (_) => const KaraokePage(),
            AppRoutes.search: (_) => const SearchPage(),
            AppRoutes.identify: (_) => const IdentifyPage(),
            AppRoutes.identifyListening: (_) => const IdentifyListeningPage(),
            AppRoutes.identifyResult: (_) => const IdentifyResultPage(),
            AppRoutes.menu: (_) => const MenuPage(),
            AppRoutes.aura: (_) => const AuraPage(),
            AppRoutes.auraChat: (_) => const AuraChatPage(),
            AppRoutes.profile: (_) => const ProfilePage(),
            AppRoutes.subscription: (_) => const SubscriptionPage(),
            AppRoutes.settings: (_) => const SettingsPage(),
          },
        ),
      ),
    );
  }
}
