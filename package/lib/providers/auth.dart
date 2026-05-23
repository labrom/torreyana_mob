import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourbillauth/config.dart' as tourbillauth;

final authProvidersProvider = Provider<List<AuthProvider>>(
  (_) => defaultAuthProviders(),
);

List<AuthProvider> defaultAuthProviders({
  bool enableEmailPasswordAuth = false,
}) => [
  if (enableEmailPasswordAuth) EmailAuthProvider(),
  ...tourbillauth.authProviders,
];
