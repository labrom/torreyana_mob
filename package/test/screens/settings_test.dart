import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:torreyana_mob/screens/settings.dart';
import 'package:tourbillauth/auth.dart';

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Example',
      packageName: 'com.example.app',
      version: '1.2.3',
      buildNumber: '42',
      buildSignature: '',
    );
  });

  testWidgets('profile appears first with a single-line user name', (
    tester,
  ) async {
    const name = 'A very long user name that needs to shrink to fit';
    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProvider.overrideWith((ref) => _User(name))],
        child: const MaterialApp(
          home: SettingsScreen(
            showProfileLink: true,
            showThemeSettings: false,
            children: [Text('Custom setting')],
          ),
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.text(name)).dy,
      lessThan(tester.getTopLeft(find.text('Custom setting')).dy),
    );
    expect(find.text('Manage your profile'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    final title = tester.widget<Text>(find.text(name));
    expect(title.maxLines, 1);
    expect(title.softWrap, isFalse);
    expect(
      title.style,
      Theme.of(tester.element(find.text(name))).textTheme.headlineSmall,
    );
    final fittedBox = tester.widget<FittedBox>(
      find.ancestor(of: find.text(name), matching: find.byType(FittedBox)),
    );
    expect(fittedBox.fit, BoxFit.scaleDown);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows configured links in the About section', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(
          showAppInfo: true,
          showThemeSettings: false,
          termsOfServiceUrl: 'https://example.com/terms',
          privacyPolicyUrl: 'https://example.com/privacy',
          copyrightMention: 'Copyright 2026 Example, Inc.',
        ),
      ),
    );
    await tester.pump();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.byIcon(Icons.open_in_new), findsNWidgets(2));
    expect(find.text('App info'), findsNothing);
    expect(find.text('Version 1.2.3 (42)'), findsOneWidget);
    expect(find.text('Copyright 2026 Example, Inc.'), findsOneWidget);
    expect(
      tester.getBottomLeft(find.text('Copyright 2026 Example, Inc.')).dy,
      greaterThan(550),
    );
  });

  testWidgets('shows copyright without version when configured', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(
          showThemeSettings: false,
          copyrightMention: 'All rights reserved.',
        ),
      ),
    );

    expect(find.text('All rights reserved.'), findsOneWidget);
    expect(find.text('Version 1.2.3 (42)'), findsNothing);
  });

  testWidgets('hides the About section when no items are configured', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: SettingsScreen(showThemeSettings: false)),
    );

    expect(find.text('About'), findsNothing);
    expect(find.text('Terms of Service'), findsNothing);
    expect(find.text('Privacy Policy'), findsNothing);
  });
}

class _User implements User {
  _User(this.displayName);

  @override
  final String displayName;

  @override
  String? get photoURL => null;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
