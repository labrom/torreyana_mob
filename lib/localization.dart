import 'package:flutter/widgets.dart';
import 'package:tourbillon/loc.dart';

AppLocalizations apploc(BuildContext context) => loc<AppLocalizations>(context);

class AppLocalizations extends BaseLocalizations {
  static final delegate = AppLocalizationsDelegate<AppLocalizations>(
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
    builder: (locale, values) => AppLocalizations._(locale, values),
  );

  AppLocalizations._(locale, values) : super(locale, values);

  String get settingsLabel => get('settingsLabel');
  String get userProfileLabel => get('userProfileLabel');
}
