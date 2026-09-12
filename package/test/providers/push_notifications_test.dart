import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:torreyana_mob/providers/push_notifications.dart';
import 'package:tourbillauth/auth.dart';

void main() {
  testWidgets('retries back off after repeated failures', (tester) async {
    final harness = _Harness()..registry.failRegistration = true;
    await harness.start(tester);
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, hasLength(2));
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, hasLength(2));
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, hasLength(3));
    await harness.dispose();
  });

  testWidgets('does not register a fetched token after its user signs out', (
    tester,
  ) async {
    final tokenResult = Completer<String?>();
    final harness = _Harness()..messaging.tokenResult = tokenResult.future;
    await harness.start(tester);
    harness.auth.add(null);
    await tester.pump();
    tokenResult.complete('late-token');
    await tester.pump();
    expect(harness.registry.registered, isEmpty);
    await harness.dispose();
  });
  testWidgets('failed registration retries without another auth event', (
    tester,
  ) async {
    final harness = _Harness()..registry.failRegistration = true;
    await harness.start(tester);
    expect(harness.registry.registered, ['user:initial']);
    harness.registry.failRegistration = false;
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, ['user:initial', 'user:initial']);
    await harness.dispose();
  });

  testWidgets('missing token is retried', (tester) async {
    final harness = _Harness()..messaging.token = null;
    await harness.start(tester);
    expect(harness.registry.registered, isEmpty);
    harness.messaging.token = 'available';
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, ['user:available']);
    await harness.dispose();
  });

  testWidgets(
    'registers replacement before cleanup and retries failed cleanup',
    (tester) async {
      final harness = _Harness();
      await harness.start(tester);
      harness.registry.failCleanup = true;
      harness.messaging.refresh('replacement');
      await tester.pump();
      expect(harness.registry.events, [
        'register user:initial',
        'register user:replacement',
        'unregister user:initial',
      ]);
      harness.registry.failCleanup = false;
      await tester.pump(const Duration(seconds: 5));
      expect(harness.registry.registered, ['user:initial', 'user:replacement']);
      expect(harness.registry.events.last, 'unregister user:initial');
      await harness.dispose();
    },
  );

  testWidgets('retry uses latest token instead of an obsolete failed token', (
    tester,
  ) async {
    final harness = _Harness()..registry.failRegistration = true;
    await harness.start(tester);
    harness.messaging.refresh('latest');
    await tester.pump();
    harness.registry.failRegistration = false;
    await tester.pump(const Duration(seconds: 5));
    expect(harness.registry.registered, [
      'user:initial',
      'user:latest',
      'user:latest',
    ]);
    await harness.dispose();
  });

  testWidgets('sign out cancels registration retries', (tester) async {
    final harness = _Harness()..registry.failRegistration = true;
    await harness.start(tester);
    harness.auth.add(null);
    await tester.pump();
    await tester.pump(const Duration(minutes: 2));
    expect(harness.registry.registered, ['user:initial']);
    await harness.dispose();
  });

  testWidgets('user switch transfers token without deleting new registration', (
    tester,
  ) async {
    final harness = _Harness();
    await harness.start(tester);
    harness.auth.add(_User('next'));
    await tester.pump();
    expect(harness.registry.events, [
      'register user:initial',
      'register next:initial',
    ]);
    await harness.dispose();
  });

  testWidgets('dispose cancels pending retry', (tester) async {
    final harness = _Harness()..registry.failRegistration = true;
    await harness.start(tester);
    await harness.dispose();
    await tester.pump(const Duration(minutes: 2));
    expect(harness.registry.registered, ['user:initial']);
  });
}

class _Harness {
  final auth = StreamController<User?>();
  final messaging = _Messaging();
  final registry = _Registry();
  late ProviderContainer container;
  late PushNotificationsController controller;
  late WidgetTester _tester;

  Future<void> start(WidgetTester tester) async {
    _tester = tester;
    final registryProvider = Provider<PushTokenRegistry>((_) => registry);
    container = ProviderContainer(
      overrides: [
        authStateChangesProvider.overrideWith((_) => auth.stream),
        pushNotificationsConfigProvider.overrideWithValue(
          PushNotificationsConfig(tokenRegistryProvider: registryProvider),
        ),
        pushNotificationsControllerProvider.overrideWith(
          (ref) => PushNotificationsController(ref, messaging: messaging),
        ),
      ],
    );
    controller = container.read(pushNotificationsControllerProvider);
    await controller.initialize();
    auth.add(_User('user'));
    await tester.pump();
  }

  Future<void> dispose() async {
    await _tester.pump();
    final disposing = controller.dispose();
    await _tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await _tester.pump();
    await disposing;
    container.dispose();
    unawaited(auth.close());
    unawaited(messaging.refreshes.close());
  }
}

class _User implements User {
  _User(this.uid);
  @override
  final String uid;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Messaging implements FirebaseMessaging {
  String? token = 'initial';
  Future<String?>? tokenResult;
  final refreshes = StreamController<String>();
  void refresh(String value) {
    token = value;
    refreshes.add(value);
  }

  @override
  Stream<String> get onTokenRefresh => refreshes.stream;
  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async => tokenResult != null ? await tokenResult : token;
  @override
  Future<RemoteMessage?> getInitialMessage() async => null;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Registry implements PushTokenRegistry {
  bool failRegistration = false;
  bool failCleanup = false;
  final registered = <String>[];
  final events = <String>[];
  @override
  Future<void> registerToken(PushTokenRegistration registration) async {
    final value = '${registration.userId}:${registration.token}';
    registered.add(value);
    events.add('register $value');
    if (failRegistration) throw StateError('offline');
  }

  @override
  Future<void> unregisterToken(PushTokenRegistration registration) async {
    events.add('unregister ${registration.userId}:${registration.token}');
    if (failCleanup) throw StateError('cleanup failed');
  }
}
