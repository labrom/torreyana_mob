import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torreyana_mob/firebase_options.dart';
import 'package:torreyana_mob/localization.dart';
import 'package:torreyana_mob/my_conf.dart';
import 'package:torreyana_mob/my_flows.dart';
import 'package:torreyana_mob/my_navigation.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/app.dart';
import 'package:tourbillauth/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders(authProviders);

  ThemeConfig.initialize(
    darkTheme: true,
    seedColor: const Color.fromARGB(255, 0, 210, 186),
    textThemeFunction: GoogleFonts.oxaniumTextTheme,
  );

  // ignore: missing_provider_scope
  runApp(
    // App.material includes a ProviderScope at its root
    App.material(
      nav: navigation,
      flowConfig: flowConfig,
      localizationsDelegate: AppLocalizations.delegate,
      title: appName,
    ),
  );
}
