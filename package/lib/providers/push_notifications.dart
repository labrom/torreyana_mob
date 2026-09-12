import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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

final Provider<PushNotificationsController>
pushNotificationsControllerProvider = Provider(PushNotificationsController.new);

class PushNotificationsController {
  PushNotificationsController(this._ref, {FirebaseMessaging? messaging})
    : _messagingOverride = messaging;

  final Ref _ref;
  final FirebaseMessaging? _messagingOverride;
  FirebaseMessaging get _messaging =>
      _messagingOverride ?? FirebaseMessaging.instance;
  Timer? _retryTimer;
  int _retrySeconds = 5;
  bool _disposed = false;
  final _pendingCleanup = <String, String>{};
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
    _disposed = false;
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

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      await config.onNotificationOpened?.call(initialMessage);
    }

    for (final topic in config.topics) {
      await _messaging.subscribeToTopic(topic);
    }

    if (config.autoRegisterToken) {
      _authStateSubscription = _ref.listen(authStateChangesProvider, (_, next) {
        if (!next.hasValue) return;
        final userId = next.value?.uid;
        _currentUserId = userId;
        _retryTimer?.cancel();
        _retryTimer = null;
        _retrySeconds = 5;
        _runAutomatically(() async {
          if (_currentUserId != userId) return;
          await _handleAuthState(next);
        });
      }, fireImmediately: true);
      _tokenRefreshSubscription = _messaging.onTokenRefresh.listen((token) {
        final userId = _currentUserId;
        _runAutomatically(() async {
          if (_currentUserId != userId) return;
          await _registerToken(token);
        });
      });
    }
  }

  Future<NotificationSettings> requestPermission() {
    return _messaging.requestPermission();
  }

  Future<String?> getToken() => _messaging.getToken();

  Future<void> registerCurrentToken() =>
      _enqueueTokenOperation(_registerCurrentToken);

  Future<void> _registerCurrentToken() async {
    final userId = _currentUserId;
    if (userId == null) return;

    final token = await _messaging.getToken();
    if (_disposed || userId != _currentUserId) return;
    if (token != null) {
      await _syncToken(token, userId);
    } else {
      _scheduleRetry();
    }
  }

  Future<void> unregisterCurrentToken({bool deleteToken = false}) =>
      _enqueueTokenOperation(
        () => _unregisterCurrentToken(deleteToken: deleteToken),
      );

  Future<void> _unregisterCurrentToken({bool deleteToken = false}) async {
    final token = _registeredToken ?? await _messaging.getToken();
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
      await _messaging.deleteToken();
    }
  }

  Future<void> subscribeToTopic(String topic) {
    return _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) {
    return _messaging.unsubscribeFromTopic(topic);
  }

  Future<void> dispose() async {
    _disposed = true;
    _retryTimer?.cancel();
    _retryTimer = null;
    final pending = <Future<void>>[
      if (_tokenRefreshSubscription != null)
        _tokenRefreshSubscription!.cancel(),
      if (_foregroundMessageSubscription != null)
        _foregroundMessageSubscription!.cancel(),
      if (_messageOpenedSubscription != null)
        _messageOpenedSubscription!.cancel(),
      _tokenOperations,
    ];
    _authStateSubscription?.close();
    _tokenRefreshSubscription = null;
    _foregroundMessageSubscription = null;
    _messageOpenedSubscription = null;
    _authStateSubscription = null;
    await Future.wait(pending);
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
        if (_currentUserId == null) {
          try {
            await _unregisterCurrentToken();
          } finally {
            _registeredToken = null;
            _registeredUserId = null;
            _pendingCleanup.clear();
          }
          return;
        }

        await _registerCurrentToken();
      },
      orElse: () async {},
    );
  }

  Future<void> _enqueueTokenOperation(Future<void> Function() operation) {
    final result = _tokenOperations.then((_) async {
      if (!_disposed) await operation();
    });
    _tokenOperations = result.onError((_, _) {});
    return result;
  }

  void _runAutomatically(Future<void> Function() operation) {
    unawaited(
      _enqueueTokenOperation(operation).catchError((Object error) {
        debugPrint('Push token synchronization failed: ${error.runtimeType}');
        _scheduleRetry();
      }),
    );
  }

  void _scheduleRetry() {
    if (_disposed || _currentUserId == null || _retryTimer != null) return;
    _retryTimer = Timer(Duration(seconds: _retrySeconds), () {
      _retryTimer = null;
      _runAutomatically(_registerCurrentToken);
    });
    _retrySeconds = (_retrySeconds * 2).clamp(5, 60);
  }

  Future<void> _syncToken(String token, String userId) async {
    final config = _config;
    if (config == null) return;

    final registry = _ref.read(config.tokenRegistryProvider);
    if (_registeredToken != token || _registeredUserId != userId) {
      final previousToken = _registeredToken;
      final previousUserId = _registeredUserId;
      await registry.registerToken(
        PushTokenRegistration(token: token, userId: userId),
      );
      if (_disposed || _currentUserId != userId) return;
      _registeredToken = token;
      _registeredUserId = userId;
      if (previousToken != null &&
          previousToken != token &&
          previousUserId == userId) {
        _pendingCleanup[previousToken] = userId;
      }
    }
    // Never remove the active token, or use the new user's credentials to
    // clean up the previous user's registration. Registries must transfer
    // ownership atomically when registering the same token for a new user.
    _pendingCleanup.removeWhere(
      (oldToken, owner) => oldToken == token || owner != userId,
    );
    for (final oldToken in _pendingCleanup.keys.toList()) {
      if (_disposed || _currentUserId != userId) return;
      await registry.unregisterToken(
        PushTokenRegistration(token: oldToken, userId: userId),
      );
      _pendingCleanup.remove(oldToken);
    }
    _retryTimer?.cancel();
    _retryTimer = null;
    _retrySeconds = 5;
  }
}
