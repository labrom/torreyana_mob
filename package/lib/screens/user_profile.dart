import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:tourbillauth/auth.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({this.deleteConfirmation, super.key});

  final Future<bool> Function(BuildContext context, WidgetRef ref)?
  deleteConfirmation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref
          .watch(authStateChangesProvider)
          .when(
            data: (user) => user != null
                ? Column(
                    children: [
                      if (_showEmailVerificationNotice(user))
                        _EmailVerificationNotice(user: user),
                      Expanded(
                        child: ProfileScreen(
                          providers: ref.watch(authProvidersProvider),
                          actions: [
                            SignedOutAction((context) => context.go(loginPath)),
                          ],
                          showDeleteConfirmationDialog: true,
                          deleteConfirmation: deleteConfirmation == null
                              ? null
                              : (context) => deleteConfirmation!(context, ref),
                        ),
                      ),
                    ],
                  )
                : null,
            loading: () => null,
            error: (err, stack) => null,
          ),
    );
  }
}

bool _showEmailVerificationNotice(firebase_auth.User user) =>
    !user.emailVerified &&
    user.email != null &&
    user.providerData.any((provider) => provider.providerId == 'password');

class _EmailVerificationNotice extends StatefulWidget {
  const _EmailVerificationNotice({required this.user});

  final firebase_auth.User user;

  @override
  State<_EmailVerificationNotice> createState() =>
      _EmailVerificationNoticeState();
}

class _EmailVerificationNoticeState extends State<_EmailVerificationNotice> {
  bool _sending = false;

  @override
  Widget build(BuildContext context) => MaterialBanner(
    content: Text('${widget.user.email} has not been verified.'),
    actions: [
      TextButton(
        onPressed: _sending ? null : _sendVerificationEmail,
        child: _sending
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Send verification email'),
      ),
    ],
  );

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _sending = true;
    });

    try {
      await widget.user.sendEmailVerification();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Verification email sent.')));
    } on firebase_auth.FirebaseAuthException catch (err) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message ?? 'Could not send verification email.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _sending = false;
        });
      }
    }
  }
}
