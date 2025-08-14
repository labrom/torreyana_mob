import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torreyana_mob/main.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob_sample_app/firebase_options.dart';
import 'package:torreyana_mob_sample_app/my_conf.dart';
import 'package:torreyana_mob_sample_app/my_flows.dart';
import 'package:torreyana_mob_sample_app/my_navigation.dart';

Future<void> main() async {
  return runTorreyanaApp(
    nav: navigation,
    title: appName,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    flowConfig: flowConfig,
    themeConfig: ThemeConfig.initialize(
      darkTheme: true,
      seedColor: const Color.fromARGB(255, 0, 210, 186),
      textThemeFunction: GoogleFonts.oxaniumTextTheme,
    ),
  );
}
