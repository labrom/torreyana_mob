import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/localization.dart' as torreyana;
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:tourbillauth/config.dart';
import 'package:tourbillon/libloc.dart' as tourbillon;

class App extends StatelessWidget {
  const App.material({required this.nav, this.flowConfig, this.title, this.localizationsDelegate, super.key});

  final Navigation nav;
  final FlowConfig? flowConfig;
  final String? title;
  final LocalizationsDelegate<dynamic>? localizationsDelegate;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        usersFirestoreDatabaseNameProvider.overrideWith((_) => 'user'),
        // usersCollectionNameProvider doesn't need to be overridden, using default: 'users'
      ],
      child: Consumer(
        builder: (context, ref, child) => MaterialApp.router(
          routerConfig: ref.watch(routerProvider(nav, flowConfig)),
          title: title,
          theme: ref.watch(appThemeDataProvider),
          localizationsDelegates: [
            if (localizationsDelegate != null) localizationsDelegate!,
            torreyana.LibLocalizations.delegate,
            tourbillon.LibLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
