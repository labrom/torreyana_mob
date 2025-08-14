import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/app.dart';
import 'package:tourbillauth/config.dart';

Future<void> runTorreyanaApp({
  required Navigation nav,
  required String title,
  FlowConfig? flowConfig,
  LocalizationsDelegate<Map<String, Map<String, String>>>? localizationsDelegate,
  FirebaseOptions? firebaseOptions,
  ThemeConfig? themeConfig,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: firebaseOptions,
  );
  FirebaseUIAuth.configureProviders(authProviders);

  // ignore: missing_provider_scope
  runApp(
    // App.material includes a ProviderScope at its root
    App.material(
      nav: nav,
      flowConfig: flowConfig,
      localizationsDelegate: localizationsDelegate,
      title: title,
    ),
  );
}
