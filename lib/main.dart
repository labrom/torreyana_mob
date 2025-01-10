import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourbillauth/config.dart';
import 'package:tourbillon/libloc.dart' as tourbillon;

import 'firebase_options.dart';
import 'localization.dart';
import 'my_conf.dart';
import 'providers/navigation.dart';
import 'providers/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders(authProviders);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: appName,
      theme: ref.watch(appThemeDataProvider),
      localizationsDelegates: [
        AppLocalizations.delegate,
        tourbillon.LibLocalizations.delegate,
      ],
    );
  }
}
