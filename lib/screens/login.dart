import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:tourbillauth/config.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({required this.targetRoute, super.key});
  final String? targetRoute;

  @override
  Widget build(BuildContext context) => SignInScreen(
        // headerBuilder: (context, constraints, shrinkOffset) => Container(
        //   color: Colors.red,
        //   child: Text('Header'),
        // ),
        // footerBuilder: (context, action) => Container(
        //   color: Colors.red,
        //   child: Text('Footer'),
        // ),
        providers: authProviders,
        actions: [
          AuthStateChangeAction<SignedIn>(
              (context, _) => context.go(targetRoute ?? defaultPath)),
        ],
      );
}
