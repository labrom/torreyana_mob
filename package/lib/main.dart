import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/push_notifications.dart';
import 'package:torreyana_mob/providers/settings.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/app.dart';

export 'package:torreyana_mob/providers/push_notifications.dart'
    show
        PushNotificationMessageHandler,
        PushNotificationsConfig,
        PushNotificationsController,
        PushTokenRegistration,
        PushTokenRegistry,
        pushNotificationsControllerProvider;
export 'package:torreyana_mob/providers/settings.dart'
    show
        FirestoreUserPreferencesHandler,
        UserPreferencesHandler,
        UserPreferencesHandlerFactory,
        UserPreferencesRepository,
        userPreferencesHandlerFactoryProvider,
        userPreferencesHandlerProvider,
        userPreferencesRepositoryProvider;

Future<void> runTorreyanaApp({
  required Navigation nav,
  required String title,
  FlowConfig? flowConfig,
  LocalizationsDelegate<dynamic>? localizationsDelegate,
  FirebaseOptions? firebaseOptions,
  String? usersFirestoreDatabaseName,
  String? usersCollectionName,
  ThemeConfig? themeConfig,
  bool enableEmailPasswordAuth = false,
  List<AuthProvider>? authProviders,
  PushNotificationsConfig? pushNotificationsConfig,
  UserPreferencesHandlerFactory? userPreferencesHandlerFactory,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: firebaseOptions);
  final backgroundMessageHandler =
      pushNotificationsConfig?.backgroundMessageHandler;
  if (backgroundMessageHandler != null) {
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }
  final configuredAuthProviders =
      authProviders ??
      defaultAuthProviders(enableEmailPasswordAuth: enableEmailPasswordAuth);
  FirebaseUIAuth.configureProviders(configuredAuthProviders);

  // ignore: missing_provider_scope
  runApp(
    // App.material includes a ProviderScope at its root
    App.material(
      nav: nav,
      flowConfig: flowConfig,
      localizationsDelegate: localizationsDelegate,
      title: title,
      usersFirestoreDatabaseName: usersFirestoreDatabaseName,
      usersCollectionName: usersCollectionName,
      authProviders: configuredAuthProviders,
      pushNotificationsConfig: pushNotificationsConfig,
      userPreferencesHandlerFactory: userPreferencesHandlerFactory,
    ),
  );
}
