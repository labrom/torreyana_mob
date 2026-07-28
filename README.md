# torreyana_mob

Torreyana provides reusable Flutter building blocks for Firebase-backed apps.
`runTorreyanaApp` initializes Firebase and creates a Material app with Riverpod,
declarative routing, authentication, settings, and optional integrations.

## Authentication

Authentication uses Firebase UI and supports configurable providers. Apps can
enable email and password sign-in or supply their own `AuthProvider` list, while
the built-in screens and routes handle sign-in, profile access, role-aware home
screens, and protected destinations.

## Navigation and flows

Define regular or shell-based screens with `Navigation`, including semantic
route aliases and login or role requirements. `FlowConfig` and `Flow` provide
multi-step experiences such as onboarding, with conditional navigation,
progress, validation, and several strategies for retaining submitted data.

## Themes and settings

`ThemeConfig` supports a fixed theme, paired light and dark themes, or a
Material 3 theme generated from a user-selectable seed color. User preferences
are reactive and stored in Firestore by default, and apps can provide a custom
`UserPreferencesHandlerFactory` to use another storage backend.

## Push notifications

Pass `PushNotificationsConfig` to enable Firebase Messaging. Torreyana can
request permission, subscribe to topics, dispatch foreground, background, and
notification-opened messages, and keep device-token registration synchronized
with the currently authenticated user through an app-defined
`PushTokenRegistry`.

## Analytics

Firebase Analytics is available through Riverpod, and navigation events are
reported automatically by the app router.

## Firebase App Check

Pass an `AppCheckConfig` to `runTorreyanaApp` to activate App Check after
Firebase initializes and before any other Firebase service is used:

```dart
runTorreyanaApp(
  nav: navigation,
  title: appName,
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  appCheckConfig: AppCheckConfig(
    // Required when the app supports web.
    webProvider: ReCaptchaV3Provider('recaptcha-site-key'),
    androidProvider: const AndroidPlayIntegrityProvider(),
    appleProvider:
        const AppleAppAttestWithDeviceCheckFallbackProvider(),
  ),
);
```

For local development, pass `AndroidDebugProvider`, `AppleDebugProvider`, or
`WebDebugProvider` as appropriate and register the generated debug tokens in
the Firebase console. App Check is disabled when `appCheckConfig` is omitted.
