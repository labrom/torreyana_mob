import 'package:flutter/widgets.dart';
import 'package:tourbillon/loc.dart';

LibLocalizations torreyanaLoc(BuildContext context) => loc<LibLocalizations>(context);

class LibLocalizations extends BaseLocalizations {

  LibLocalizations._(Locale locale, Map<String, Map<String, String>> values) : super(locale, values);
  static final delegate = AppLocalizationsDelegate<LibLocalizations>(
    supportedLocales: const ['en', 'fr'],
    values: {
      'settingsLabel': {
        en: 'Settings',
        fr: 'Paramètres',
      },
      'userProfileLabel': {
        en: 'Profile',
        fr: 'Profil',
      },
    },
    builder: (locale, values) => LibLocalizations._(locale, values),
  );

  String get settingsLabel => get('settingsLabel');
  String get userProfileLabel => get('userProfileLabel');
}
