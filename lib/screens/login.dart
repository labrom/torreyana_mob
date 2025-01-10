import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tourbillauth/config.dart';

import '../providers/navigation.dart';

class LoginScreen extends StatelessWidget {
  final String? targetRoute;

  const LoginScreen({super.key, required this.targetRoute});

  @override
  Widget build(BuildContext context) => SignInScreen(
        headerBuilder: (context, constraints, shrinkOffset) => Container(
          color: Colors.red,
          child: Text('Header'),
        ),
        footerBuilder: (context, action) => Container(
          color: Colors.red,
          child: Text('Footer'),
        ),
        providers: authProviders,
        actions: [
          AuthStateChangeAction<SignedIn>(
              (context, _) => context.go(targetRoute ?? defaultPath)),
        ],
      );
}
