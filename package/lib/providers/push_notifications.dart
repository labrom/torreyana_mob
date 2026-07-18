import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:tourbillauth/auth.dart';

typedef PushNotificationMessageHandler =
    FutureOr<void> Function(RemoteMessage message);

class PushNotificationsConfig {
  const PushNotificationsConfig({
    required this.tokenRegistryProvider,
    this.requestPermissionOnStart = false,
    this.autoRegisterToken = true,
    this.topics = const {},
    this.onForegroundMessage,
    this.onNotificationOpened,
    this.backgroundMessageHandler,
  });

  final ProviderListenable<PushTokenRegistry> tokenRegistryProvider;
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
  ProviderSubscription<AsyncValue<User?>>? _authStateSubscription;
  Future<void> _tokenOperations = Future.value();
  String? _currentUserId;
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
      _authStateSubscription = _ref.listen(authStateChangesProvider, (_, next) {
        unawaited(_enqueueTokenOperation(() => _handleAuthState(next)));
      }, fireImmediately: true);
      _tokenRefreshSubscription = FirebaseMessaging.instance.onTokenRefresh
          .listen((token) {
            unawaited(_enqueueTokenOperation(() => _registerToken(token)));
          });
    }
  }

  Future<NotificationSettings> requestPermission() {
    return FirebaseMessaging.instance.requestPermission();
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  Future<void> registerCurrentToken() =>
      _enqueueTokenOperation(_registerCurrentToken);

  Future<void> _registerCurrentToken() async {
    final userId = _currentUserId;
    if (userId == null) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _syncToken(token, userId);
    }
  }

  Future<void> unregisterCurrentToken({bool deleteToken = false}) =>
      _enqueueTokenOperation(
        () => _unregisterCurrentToken(deleteToken: deleteToken),
      );

  Future<void> _unregisterCurrentToken({bool deleteToken = false}) async {
    final token =
        _registeredToken ?? await FirebaseMessaging.instance.getToken();
    if (token == null) return;

    final config = _config;
    if (config != null) {
      await _ref
          .read(config.tokenRegistryProvider)
          .unregisterToken(
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
    _authStateSubscription?.close();
    _tokenRefreshSubscription = null;
    _foregroundMessageSubscription = null;
    _messageOpenedSubscription = null;
    _authStateSubscription = null;
    await _tokenOperations;
    _initialized = false;
  }

  Future<void> _registerToken(String token) async {
    final userId = _currentUserId;
    if (userId == null) return;

    await _syncToken(token, userId);
  }

  Future<void> _handleAuthState(AsyncValue<User?> authState) async {
    await authState.maybeWhen(
      data: (user) async {
        _currentUserId = user?.uid;

        if (_currentUserId == null) {
          await _unregisterCurrentToken();
          return;
        }

        await _registerCurrentToken();
      },
      orElse: () async {},
    );
  }

  Future<void> _enqueueTokenOperation(Future<void> Function() operation) {
    final result = _tokenOperations.then((_) => operation());
    _tokenOperations = result.onError((_, _) {});
    return result;
  }

  Future<void> _syncToken(String token, String userId) async {
    final config = _config;
    if (config == null) return;

    if (_registeredToken == token && _registeredUserId == userId) return;

    final registry = _ref.read(config.tokenRegistryProvider);

    if (_registeredToken != null) {
      await registry.unregisterToken(
        PushTokenRegistration(
          token: _registeredToken!,
          userId: _registeredUserId,
        ),
      );
    }

    await registry.registerToken(
      PushTokenRegistration(token: token, userId: userId),
    );
    _registeredToken = token;
    _registeredUserId = userId;
  }
}
