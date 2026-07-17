import 'dart:async';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/localization.dart' as torreyana;
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/push_notifications.dart';
import 'package:torreyana_mob/providers/settings.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:tourbillauth/config.dart';
import 'package:tourbillon/libloc.dart' as tourbillon;

class App extends StatelessWidget {
  const App.material({
    required this.nav,
    this.flowConfig,
    this.title,
    this.localizationsDelegate,
    this.usersFirestoreDatabaseName,
    this.usersCollectionName,
    this.authProviders,
    this.pushNotificationsConfig,
    this.userPreferencesHandler,
    super.key,
  });

  final Navigation nav;
  final FlowConfig? flowConfig;
  final String? title;
  final LocalizationsDelegate<dynamic>? localizationsDelegate;
  final String? usersFirestoreDatabaseName;
  final String? usersCollectionName;
  final List<AuthProvider>? authProviders;
  final PushNotificationsConfig? pushNotificationsConfig;
  final UserPreferencesHandler? userPreferencesHandler;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (authProviders != null)
          authProvidersProvider.overrideWithValue(authProviders!),
        if (usersFirestoreDatabaseName != null)
          usersFirestoreDatabaseNameProvider.overrideWith(
            (_) => usersFirestoreDatabaseName,
          ),
        if (usersCollectionName != null)
          usersCollectionNameProvider.overrideWith((_) => usersCollectionName!),
        if (pushNotificationsConfig != null)
          pushNotificationsConfigProvider.overrideWithValue(
            pushNotificationsConfig,
          ),
        if (userPreferencesHandler != null)
          userPreferencesHandlerProvider.overrideWithValue(
            userPreferencesHandler!,
          ),
      ],
      child: _AppRouter(
        nav: nav,
        flowConfig: flowConfig,
        title: title,
        localizationsDelegate: localizationsDelegate,
      ),
    );
  }
}

class _AppRouter extends ConsumerStatefulWidget {
  const _AppRouter({
    required this.nav,
    required this.flowConfig,
    required this.title,
    required this.localizationsDelegate,
  });

  final Navigation nav;
  final FlowConfig? flowConfig;
  final String? title;
  final LocalizationsDelegate<dynamic>? localizationsDelegate;

  @override
  ConsumerState<_AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends ConsumerState<_AppRouter> {
  @override
  void initState() {
    super.initState();
    unawaited(ref.read(pushNotificationsControllerProvider).initialize());
  }

  @override
  void dispose() {
    unawaited(ref.read(pushNotificationsControllerProvider).dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeConfig = ThemeConfig.defaultTheme;
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider(widget.nav, widget.flowConfig)),
      title: widget.title,
      theme: themeConfig.themeData ?? ref.watch(appLightThemeDataProvider),
      darkTheme: themeConfig.hasFixedTheme
          ? null
          : ref.watch(appDarkThemeDataProvider),
      themeMode: themeConfig.hasFixedTheme
          ? ThemeMode.light
          : ref.watch(appThemeModeProvider),
      localizationsDelegates: [
        if (widget.localizationsDelegate != null) widget.localizationsDelegate!,
        torreyana.LibLocalizations.delegate,
        tourbillon.LibLocalizations.delegate,
      ],
    );
  }
}
