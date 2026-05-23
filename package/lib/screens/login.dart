import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/auth.dart';
import 'package:torreyana_mob/providers/navigation.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({required this.targetRoute, super.key});
  final String? targetRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SignInScreen(
    // headerBuilder: (context, constraints, shrinkOffset) => Container(
    //   color: Colors.red,
    //   child: Text('Header'),
    // ),
    // footerBuilder: (context, action) => Container(
    //   color: Colors.red,
    //   child: Text('Footer'),
    // ),
    providers: ref.watch(authProvidersProvider),
    actions: [
      AuthStateChangeAction<SignedIn>(
        (context, _) => context.go(targetRoute ?? defaultPath),
      ),
    ],
  );
}
