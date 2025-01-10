import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tourbillauth/auth.dart';
import 'package:tourbillauth/config.dart';

import '../providers/navigation.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(authStateChangesProvider).when(
            data: (user) => user != null
                ? ProfileScreen(
                    providers: authProviders,
                    actions: [
                      SignedOutAction((context) => context.go(loginPath)),
                    ],
                  )
                : null,
            loading: () => null,
            error: (err, stack) => null,
          ),
    );
  }
}
