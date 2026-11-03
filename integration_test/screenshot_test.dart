import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const screens = {
    '06_welcome': AppRoutes.welcome,
    '07_login': AppRoutes.login,
    '08_hello': AppRoutes.hello,
    '09_preferences_1': AppRoutes.preferences,
    '10_preferences_2': AppRoutes.preferenceSong,
    '11_preferences_3': AppRoutes.preferencesComplete,
    '12_home': AppRoutes.home,
    '13_recommendations': AppRoutes.recommendations,
    '14_chart': AppRoutes.chart,
    '15_new_single': AppRoutes.newSingle,
    '16_new_album': AppRoutes.newAlbum,
    '17_album': AppRoutes.album,
    '18_artist': AppRoutes.artist,
    '19_radio': AppRoutes.radio,
    '20_alternative': AppRoutes.alternative,
    '21_alternative_detail': AppRoutes.alternativeTuner,
    '22_genres': AppRoutes.genres,
    '23_genre_list': AppRoutes.genreList,
    '24_rock': AppRoutes.rock,
    '25_events': AppRoutes.events,
    '26_event_detail': AppRoutes.eventDetail,
    '27_zone': AppRoutes.zone,
    '28_zone_seats': AppRoutes.zoneSeats,
    '29_payment': AppRoutes.payment,
    '30_ticket': AppRoutes.ticket,
    '31_my_music': AppRoutes.myMusic,
    '32_player': AppRoutes.player,
    '33_equalizer': AppRoutes.equalizer,
    '34_lyrics': AppRoutes.lyrics,
    '35_karaoke': AppRoutes.karaoke,
    '36_search': AppRoutes.search,
    '37_identify': AppRoutes.identify,
    '38_identify_listening': AppRoutes.identifyListening,
    '39_identify_result': AppRoutes.identifyResult,
    '40_menu': AppRoutes.menu,
    '41_aura': AppRoutes.aura,
    '42_aura_chat': AppRoutes.auraChat,
    '43_profile': AppRoutes.profile,
    '44_profile_edit': AppRoutes.subscription,
    '45_settings': AppRoutes.settings,
  };

  testWidgets('capture all app screens', (tester) async {
    await tester.pumpWidget(const MusicServisApp());
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();

    const onboarding = [
      '01_onboarding_1',
      '02_onboarding_2',
      '03_onboarding_3',
      '04_onboarding_4',
      '05_onboarding_5',
    ];
    for (var index = 0; index < onboarding.length; index++) {
      if (index > 0) {
        await tester.drag(find.byType(PageView), const Offset(-375, 0));
        await tester.pumpAndSettle();
      }
      await binding.takeScreenshot(onboarding[index]);
    }

    for (final entry in screens.entries) {
      await tester.pumpWidget(
        MusicServisApp(
          key: ValueKey(entry.value),
          initialRoute: entry.value,
          initialDarkTheme: const bool.fromEnvironment('DARK_THEME'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 250)),
      );
      await tester.pump();
      await binding.takeScreenshot(entry.key);
    }
  }, timeout: const Timeout(Duration(minutes: 10)));
}
