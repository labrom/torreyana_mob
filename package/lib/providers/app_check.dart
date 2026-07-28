import 'package:firebase_app_check/firebase_app_check.dart';

/// Configures Firebase App Check when starting a Torreyana app.
///
/// The default providers use Play Integrity on Android, Device Check on Apple
/// platforms, and the debug provider on Windows. Web apps must supply a
/// [webProvider].
class AppCheckConfig {
  const AppCheckConfig({
    this.webProvider,
    this.androidProvider = const AndroidPlayIntegrityProvider(),
    this.appleProvider = const AppleDeviceCheckProvider(),
    this.windowsProvider = const WindowsDebugProvider(),
  });

  final WebProvider? webProvider;
  final AndroidAppCheckProvider androidProvider;
  final AppleAppCheckProvider appleProvider;
  final WindowsAppCheckProvider windowsProvider;

  Future<void> activate() => FirebaseAppCheck.instance.activate(
    providerWeb: webProvider,
    providerAndroid: androidProvider,
    providerApple: appleProvider,
    providerWindows: windowsProvider,
  );
}
