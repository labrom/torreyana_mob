import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/navigation.dart';

/// Builds the app-specific login screen from torreyana_mob's configured
/// Firebase UI [SignInScreen].
///
/// Callers that replace [screen] should preserve its providers, actions,
/// styles, and footer builder so authentication, theming, and post-login
/// navigation keep working.
typedef LoginScreenBuilder =
    Widget Function(BuildContext context, SignInScreen screen);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({required this.targetRoute, this.builder, super.key});

  final String? targetRoute;
  final LoginScreenBuilder? builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(authProvidersProvider);
    final googleProviders = providers.where(
      (provider) => provider.providerId == 'google.com',
    );
    final googleProvider = googleProviders.isEmpty
        ? null
        : googleProviders.first;
    final screen = SignInScreen(
      providers: providers
          .where((provider) => provider.providerId != 'google.com')
          .toList(),
      styles: const {EmailFormStyle(signInButtonVariant: ButtonVariant.filled)},
      subtitleBuilder: (context, action) => const SizedBox.shrink(),
      footerBuilder: googleProvider == null
          ? null
          : (context, action) =>
                _GoogleSignInFooter(provider: googleProvider, action: action),
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, _) => context.go(targetRoute ?? defaultPath),
        ),
      ],
    );
    return builder?.call(context, screen) ?? screen;
  }
}

class _GoogleSignInFooter extends StatelessWidget {
  const _GoogleSignInFooter({required this.provider, required this.action});

  final AuthProvider provider;
  final AuthAction action;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Divider(height: 1),
      ),
      AuthFlowBuilder<OAuthController>(
        provider: provider,
        action: action,
        builder: (context, state, controller, _) {
          final isLoading = state is SigningIn || state is CredentialReceived;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () => controller.signIn(Theme.of(context).platform),
                icon: isLoading
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(SocialIcons.google),
                label: const Text('Sign in with Google'),
                style: OutlinedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (state case AuthFailed(:final exception))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ErrorText(exception: exception),
                ),
            ],
          );
        },
      ),
    ],
  );
}
