import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:music_servis/core/routes.dart';
import 'package:music_servis/main.dart';

Future<void> openScreen(WidgetTester tester, String route) async {
  await tester.pumpWidget(
    MusicServisApp(key: ValueKey(route), initialRoute: route),
  );
  await tester.pumpAndSettle();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('registration and preferences lead to home', (tester) async {
    await tester.pumpWidget(const MusicServisApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text("I'M A NEW USER"));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'jane@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('REGISTER'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('START'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('VIEW RECOMMENDATIONS'));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('New release'), findsOneWidget);
  });

  testWidgets('event selection and payment produce a ticket', (tester) async {
    await openScreen(tester, AppRoutes.eventDetail);
    await tester.tap(find.text('BUY TICKETS'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(180, 400));
    await tester.pumpAndSettle();

    expect(find.text('Buy 2 tickets for \$440'), findsOneWidget);
    await tester.tap(find.text('Buy 2 tickets for \$440'));
    await tester.pumpAndSettle();
    expect(find.text('Payment'), findsOneWidget);

    await tester.tap(find.text('To pay for the tickets'));
    await tester.pumpAndSettle();
    expect(find.text('Your ticket'), findsOneWidget);
    expect(find.text('2 tickets in dance orchestra'), findsOneWidget);
  });

  testWidgets('player controls, equalizer, lyrics and Aura chat work', (
    tester,
  ) async {
    await openScreen(tester, AppRoutes.player);
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();
    expect(find.text('Equalizer'), findsOneWidget);
    await tester.tap(find.byType(Switch));
    await tester.pump();

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.lyrics_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Let Me Live My Life'), findsOneWidget);

    await openScreen(tester, AppRoutes.aura);
    await tester.tap(find.text('Ask me anything'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Hello');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();
    expect(
      find.text('Hello, Jane. What would you like to hear?'),
      findsOneWidget,
    );
  });
}
