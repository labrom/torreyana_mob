import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torreyana_mob/widgets/settings.dart';

void main() {
  testWidgets('standalone settings render in individual pills', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SimpleWidgetSetting(
            title: 'Profile',
            actionChild: Icon(Icons.chevron_right),
          ),
        ),
      ),
    );

    final card = tester.widget<Card>(
      find.byKey(const ValueKey('standalone-setting-card')),
    );
    expect(card.shape, isA<StadiumBorder>());
  });

  testWidgets('section settings share a rounded divided card', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SettingsSection(
            title: 'Notifications',
            children: [
              SimpleWidgetSetting(
                title: 'Memories',
                actionChild: Icon(Icons.chevron_right),
              ),
              SimpleWidgetSetting(
                title: 'Sharing',
                actionChild: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('settings-section-card')), findsOneWidget);
    expect(find.byKey(const ValueKey('standalone-setting-card')), findsNothing);
    expect(find.byType(Divider), findsOneWidget);

    final card = tester.widget<Card>(
      find.byKey(const ValueKey('settings-section-card')),
    );
    final shape = card.shape! as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(24));
  });
}
