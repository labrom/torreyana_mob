import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PushNotificationMessageHandler =
    FutureOr<void> Function(RemoteMessage message);

class PushNotificationsConfig {
  const PushNotificationsConfig({
    required this.tokenRegistry,
    this.requestPermissionOnStart = false,
    this.autoRegisterToken = true,
    this.topics = const {},
    this.onForegroundMessage,
    this.onNotificationOpened,
    this.backgroundMessageHandler,
  });

  final PushTokenRegistry tokenRegistry;
  final bool requestPermissionOnStart;
  final bool autoRegisterToken;
  final Set<String> topics;
  final PushNotificationMessageHandler? onForegroundMessage;
  final PushNotificationMessageHandler? onNotificationOpened;
  final BackgroundMessageHandler? backgroundMessageHandler;
}

class PushTokenRegistration {
  const PushTokenRegistration({required this.token, this.userId});

  final String token;
  final String? userId;
}

abstract interface class PushTokenRegistry {
  Future<void> registerToken(PushTokenRegistration registration);

  Future<void> unregisterToken(PushTokenRegistration registration);
}

final pushNotificationsConfigProvider = Provider<PushNotificationsConfig?>(
  (_) => null,
);

final Provider<PushNotificationsController> pushNotificationsControllerProvider = Provider(
  PushNotificationsController.new,
);

class PushNotificationsController {
  PushNotificationsController(this._ref);

  final Ref _ref;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _foregroundMessageSubscription;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;
  StreamSubscription<User?>? _authStateSubscription;
  String? _registeredToken;
  String? _registeredUserId;
  bool _initialized = false;

  PushNotificationsConfig? get _config =>
      _ref.read(pushNotificationsConfigProvider);

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    final config = _config;
    if (config == null) return;

    if (config.requestPermissionOnStart) {
      await requestPermission();
    }

    _foregroundMessageSubscription = FirebaseMessaging.onMessage.listen((
      message,
    ) async {
      await config.onForegroundMessage?.call(message);
    });
    _messageOpenedSubscription = FirebaseMessaging.onMessageOpenedApp.listen((
      message,
    ) async {
      await config.onNotificationOpened?.call(message);
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await config.onNotificationOpened?.call(initialMessage);
    }

    for (final topic in config.topics) {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    }

    if (config.autoRegisterToken) {
      await registerCurrentToken();
      _tokenRefreshSubscription = FirebaseMessaging.instance.onTokenRefresh
          .listen((token) async {
            await _registerToken(token);
          });
      _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((
        user,
      ) async {
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          await _syncToken(token, user?.uid);
        }
      });
    }
  }

  Future<NotificationSettings> requestPermission() {
    return FirebaseMessaging.instance.requestPermission();
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  Future<void> registerCurrentToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _registerToken(token);
    }
  }

  Future<void> unregisterCurrentToken({bool deleteToken = false}) async {
    final token =
        _registeredToken ?? await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    final config = _config;
    if (config != null) {
      await config.tokenRegistry.unregisterToken(
        PushTokenRegistration(token: token, userId: _registeredUserId),
      );
    }
    _registeredToken = null;
    _registeredUserId = null;

    if (deleteToken) {
      await FirebaseMessaging.instance.deleteToken();
    }
  }

  Future<void> subscribeToTopic(String topic) {
    return FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) {
    return FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  Future<void> dispose() async {
    await _tokenRefreshSubscription?.cancel();
    await _foregroundMessageSubscription?.cancel();
    await _messageOpenedSubscription?.cancel();
    await _authStateSubscription?.cancel();
    _tokenRefreshSubscription = null;
    _foregroundMessageSubscription = null;
    _messageOpenedSubscription = null;
    _authStateSubscription = null;
    _initialized = false;
  }

  Future<void> _registerToken(String token) async {
    await _syncToken(token, FirebaseAuth.instance.currentUser?.uid);
  }

  Future<void> _syncToken(String token, String? userId) async {
    final config = _config;
    if (config == null) return;

    if (_registeredToken == token && _registeredUserId == userId) return;

    if (_registeredToken != null) {
      await config.tokenRegistry.unregisterToken(
        PushTokenRegistration(
          token: _registeredToken!,
          userId: _registeredUserId,
        ),
      );
    }

    await config.tokenRegistry.registerToken(
      PushTokenRegistration(token: token, userId: userId),
    );
    _registeredToken = token;
    _registeredUserId = userId;
  }
}
