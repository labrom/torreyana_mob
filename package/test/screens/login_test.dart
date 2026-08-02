import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
      final overlay = tester.widget<AnnotatedRegion<SystemUiOverlayStyle>>(
        find.ancestor(
          of: find.text('branding-${brightness.name}'),
          matching: find.byType(AnnotatedRegion<SystemUiOverlayStyle>),
        ),
      );
      expect(
        overlay.value.statusBarIconBrightness,
        brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      );
      expect(
        overlay.value.statusBarBrightness,
        brightness == Brightness.dark ? Brightness.dark : Brightness.light,
      );
      expect(overlay.sized, isFalse);
      final sampledOverlay = RendererBinding
          .instance
          .renderViews
          .single
          .debugLayer!
          .find<SystemUiOverlayStyle>(const Offset(400, 0));
      expect(
        sampledOverlay?.statusBarIconBrightness,
        brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      );
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

  testWidgets('applies login screen options without rebuilding the screen', (
    tester,
  ) async {
    late SignInScreen configuredScreen;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authProvidersProvider.overrideWithValue(const [])],
        child: MaterialApp(
          home: LoginScreen(
            targetRoute: null,
            options: LoginScreenOptions(
              headerMaxExtent: 184,
              subtitleBuilder: (context, action) => const Text('Subtitle'),
              wrapper: (context, screen) {
                configuredScreen = screen as SignInScreen;
                return const Text('Wrapped', textDirection: TextDirection.ltr);
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text('Wrapped'), findsOneWidget);
    expect(configuredScreen.headerMaxExtent, 184);
    expect(configuredScreen.subtitleBuilder, isNotNull);
    expect(configuredScreen.footerBuilder, isNull);
    expect(configuredScreen.styles, isNotEmpty);
    expect(configuredScreen.actions, hasLength(1));
  });
}
