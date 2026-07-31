import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/navigation.dart';

/// Builds the app-specific login screen from torreyana_mob's configured
/// Firebase UI [SignInScreen].
///
/// Callers that replace [screen] should preserve its [SignInScreen.providers]
/// and [SignInScreen.actions] so authentication and post-login navigation keep
/// working.
typedef LoginScreenBuilder =
    Widget Function(BuildContext context, SignInScreen screen);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({required this.targetRoute, this.builder, super.key});

  final String? targetRoute;
  final LoginScreenBuilder? builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = SignInScreen(
      providers: ref.watch(authProvidersProvider),
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, _) => context.go(targetRoute ?? defaultPath),
        ),
      ],
    );
    return builder?.call(context, screen) ?? screen;
  }
}
