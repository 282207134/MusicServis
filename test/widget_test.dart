import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/main.dart';

void main() {
  testWidgets('new user onboarding opens registration', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MusicServisApp());
    await tester.pumpAndSettle();

    expect(find.text('Millions of tracks'), findsOneWidget);

    await tester.tap(find.text("I'M A NEW USER"));
    await tester.pumpAndSettle();

    expect(find.text('WELCOME'), findsOneWidget);
    expect(find.text('REGISTER'), findsOneWidget);
  });

  testWidgets('settings switches the app between light and dark', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MusicServisApp(initialRoute: AppRoutes.settings),
    );
    await tester.pumpAndSettle();

    final settingsContext = tester.element(find.text('Settings'));
    expect(Theme.of(settingsContext).brightness, Brightness.light);

    await tester.tap(find.byKey(const ValueKey('Dark theme')));
    await tester.pumpAndSettle();

    expect(Theme.of(settingsContext).brightness, Brightness.dark);
    expect(
      Theme.of(settingsContext).scaffoldBackgroundColor,
      const Color(0xFF191919),
    );

    await tester.tap(find.byKey(const ValueKey('Dark theme')));
    await tester.pumpAndSettle();

    expect(Theme.of(settingsContext).brightness, Brightness.light);
  });
}
