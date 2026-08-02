import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/screens/login.dart';

void main() {
  for (final brightness in Brightness.values) {
    testWidgets('uses the login screen builder in ${brightness.name} mode', (
      tester,
    ) async {
      late SignInScreen configuredScreen;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [authProvidersProvider.overrideWithValue(const [])],
          child: MaterialApp(
            theme: ThemeData(brightness: brightness),
            home: LoginScreen(
              targetRoute: '/after-login',
              builder: (context, screen) {
                configuredScreen = screen;
                return Text(
                  'branding-${Theme.of(context).brightness.name}',
                  textDirection: TextDirection.ltr,
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('branding-${brightness.name}'), findsOneWidget);
      expect(configuredScreen.providers, isEmpty);
      expect(configuredScreen.actions, hasLength(1));
      expect(configuredScreen.subtitleBuilder, isNotNull);
      final emailStyle = configuredScreen.styles!.single as EmailFormStyle;
      expect(emailStyle.signInButtonVariant, ButtonVariant.filled);
      expect(
        configuredScreen.actions.single,
        isA<AuthStateChangeAction<SignedIn>>(),
      );
    });
  }
}
