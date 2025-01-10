import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/my/screens/assignments.dart';
import 'package:torreyana_mob/my/screens/parent_home.dart';
import 'package:torreyana_mob/my/screens/schedule.dart';
import 'package:torreyana_mob/my/screens/student_home.dart';
import 'package:tourbillauth/auth.dart';

import '../screens/flow.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/settings.dart';
import '../screens/theme_settings.dart';
import '../screens/user_profile.dart';
import 'analytics.dart';

part '../my_navigation.dart';
part 'navigation.g.dart';

const defaultPath = '/';
const loginPath = '/_login';
const flowPathSegment = '_flow';
const settingsPathSegment = '_settings';
const profilePathSegment = '_profile';

class Screen {
  final String name;
  final Widget Function(BuildContext context, Map<String, String> parameters)
      builder;
  final bool requiresLogin;
  final String requiresRole;

  Screen({
    required this.name,
    required this.builder,
    this.requiresLogin = false,
    this.requiresRole = '',
  });
}

class Navigation {
  final Screen homeScreen;
  final List<Screen> screens;
  final Map<String, Screen> homeScreenForRole;
  final bool homeRequiresLogin;

  Navigation({
    required this.homeScreen,
    required this.screens,
    required this.homeScreenForRole,
    this.homeRequiresLogin = false,
  }) : assert(homeScreenForRole.length > 1);

  Screen getHomeScreen({String? role}) => homeScreenForRole[role] ?? homeScreen;
}

extension NavigationHandler on BuildContext {
  void navigate(WidgetRef ref, String route) {
    ref.read(navigationHandlerProvider(route)).call(this, route);
  }
}

@riverpod
void Function(BuildContext, String) navigationHandler(
    NavigationHandlerRef ref, String route) {
  ref.read(analyticsProvider).logScreenView(screenName: route);
  // Pass through to go_router.
  return (context, route) {
    context.go(route);
  };
}

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
@riverpod
GoRouter router(RouterRef ref) => GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: defaultPath,
      routes: [
        GoRoute(
          path: loginPath,
          builder: (context, state) => LoginScreen(
            targetRoute: state.uri.queryParameters['target'],
          ),
        ),
        defaultHomeRoute(
          ref,
          childRoutes: [
            ...homeRedirectRoutes(ref),
            ...screenRoutes(ref),
            GoRoute(
              path: settingsPathSegment,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'theme',
                  builder: (context, state) => const ThemeSettingsScreen(),
                ),
              ],
            ),
            GoRoute(
              path: profilePathSegment,
              builder: (context, state) => const UserProfileScreen(),
              redirect: (context, state) => _loginRedirect(context, state, ref),
            ),
            GoRoute(
              path: '$flowPathSegment/:name',
              builder: (context, state) => FlowScreen(
                flowName: state.pathParameters['name']!,
              ),
            ),
          ],
        ),
      ],
    );

GoRoute defaultHomeRoute(RouterRef ref, {required List<GoRoute> childRoutes}) {
  return GoRoute(
    path: defaultPath,
    builder: (context, state) => navigation
        .getHomeScreen(/* TODO Get user role */)
        .builder(
            context, state.pathParameters..addAll(state.uri.queryParameters)),
    redirect: navigation.homeRequiresLogin
        ? (context, state) => _loginRedirect(context, state, ref)
        : null,
    routes: childRoutes,
  );
}

List<GoRoute> homeRedirectRoutes(RouterRef ref) {
  return [
    GoRoute(
      path: navigation.homeScreen.name,
      redirect: (context, state) => defaultPath,
    ),
    ...navigation.homeScreenForRole.values
        .map((screen) => GoRoute(
              path: screen.name,
              redirect: (context, state) => defaultPath,
            ))
        .toList()
  ];
}

List<GoRoute> screenRoutes(RouterRef ref) {
  return navigation.screens
      .map((screen) => GoRoute(
            path: screen.name,
            builder: (context, state) => screen.builder(context,
                state.pathParameters..addAll(state.uri.queryParameters)),
            redirect: screen.requiresLogin && !navigation.homeRequiresLogin
                ? (context, state) => _loginRedirect(context, state, ref)
                : null,
          ))
      .toList();
}

String? _loginRedirect(
        BuildContext context, GoRouterState state, RouterRef ref) =>
    ref.read(firebaseAuthProvider).currentUser == null
        ? _redirectUri(state)
        : null;

// ref.read(authStateChangesProvider).when(
//       data: (user) => user == null ? _redirectUri(state) : null,
//       loading: () => _redirectUri(state),
//       error: (err, stack) => _redirectUri(state),
//     )

String _redirectUri(GoRouterState state) => Uri(
    path: loginPath,
    queryParameters: {'target': state.fullPath ?? defaultPath}).toString();
