import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/screens/flow.dart';
import 'package:torreyana_mob/screens/login.dart';
import 'package:torreyana_mob/screens/settings.dart';
import 'package:torreyana_mob/screens/theme_settings.dart';
import 'package:torreyana_mob/screens/user_profile.dart';
import 'package:tourbillauth/auth.dart';

part 'navigation.g.dart';

const defaultPath = '/';
const loginPath = '/_login';
const flowPathSegment = '_flow';
const settingsPathSegment = '_settings';
const profilePathSegment = '_profile';

class Screen {
  Screen({
    required this.name,
    required this.builder,
    this.requiresLogin = false,
    this.requiresRole = '',
    this.children = const [],
    this.isShell = false,
  });
  final String name;
  final Widget Function(BuildContext context, Map<String, String> parameters, Widget? child)
  builder;
  final bool requiresLogin;
  final String requiresRole;
  final bool isShell;
  final List<Screen> children;

  RouteBase toRoute(Ref ref, Navigation nav) {
    if (isShell) {
      return ShellRoute(
        builder: (context, state, child) =>
            builder(context, state.pathParameters..addAll(state.uri.queryParameters), child),
        routes: children.map((screen) => screen.toRoute(ref, nav)).toList(),
      );
    }
    return GoRoute(
      path: name,
      builder: (context, state) =>
          builder(context, state.pathParameters..addAll(state.uri.queryParameters), null),
      redirect:
          (requiresLogin && !nav.homeRequiresLogin) ||
              (name == defaultPath && nav.homeRequiresLogin)
          ? (context, state) => _loginRedirect(context, state, ref)
          : null,
      routes: children.map((screen) => screen.toRoute(ref, nav)).toList(),
    );
  }
}

class Navigation {
  Navigation({
    required this.homeScreen,
    required this.screens,
    this.homeScreenForRole,
    this.homeRequiresLogin = false,
    this.showProfileLinkInSettings = false,
  });
  final Screen homeScreen;
  final List<Screen> screens;
  final Map<String, Screen>? homeScreenForRole;
  final bool homeRequiresLogin;
  final bool showProfileLinkInSettings;

  Screen getHomeScreen({String? role}) => homeScreenForRole?[role] ?? homeScreen;
}

extension NavigationHandler on BuildContext {
  void navigate(WidgetRef ref, String route, {bool push = false}) {
    final nav = ref.read(navigationHandlerProvider(route));
    nav.call(this, route, push);
  }
}

@riverpod
// ignore: avoid_positional_boolean_parameters
void Function(BuildContext, String, bool) navigationHandler(Ref ref, String route) {
  // Do stuff here, like log page view

  // Pass through to go_router.
  return (context, route, push) {
    push ? context.push(route) : context.go(route);
  };
}

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
@riverpod
GoRouter router(Ref ref, Navigation nav, FlowConfig? flowConfig) => GoRouter(
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
      nav,
      childRoutes: [],
    ),
    // TODO
    // ...homeRedirectRoutes(ref),
    ...screenRoutes(ref, nav),
    GoRoute(
      path: '/$settingsPathSegment',
      builder: (context, state) => SettingsScreen(
        showProfileLink:
            nav.showProfileLinkInSettings || state.uri.queryParameters['showProfileLink'] == 'true',
      ),
    ),
    GoRoute(
      path: '/$settingsPathSegment/theme',
      builder: (context, state) => const ThemeSettingsScreen(),
    ),
    GoRoute(
      path: '/$profilePathSegment',
      builder: (context, state) => const UserProfileScreen(),
      redirect: (context, state) => _loginRedirect(context, state, ref),
    ),
    if(flowConfig != null)
    GoRoute(
      path: '/$flowPathSegment/:name',
      builder: (context, state) => FlowScreen(
        config: flowConfig,
        flowName: state.pathParameters['name']!,
      ),
    ),
  ],
);

RouteBase defaultHomeRoute(Ref ref, Navigation nav, {required List<RouteBase> childRoutes}) {
  final homeScreen = nav.getHomeScreen(/* TODO Get user role */);
  final route = homeScreen.toRoute(ref, nav);
  return route;
}

List<RouteBase> homeRedirectRoutes(Ref ref, Navigation nav) {
  return [
    GoRoute(
      path: nav.homeScreen.name,
      redirect: (context, state) => defaultPath,
    ),
    ...nav.homeScreenForRole?.values.map(
          (screen) => GoRoute(
            path: screen.name,
            redirect: (context, state) => defaultPath,
          ),
        ) ??
        [],
  ];
}

List<RouteBase> screenRoutes(Ref ref, Navigation nav) {
  return nav.screens
      .map(
        (screen) => screen.toRoute(ref, nav),
      )
      .toList();
}

String? _loginRedirect(BuildContext context, GoRouterState state, Ref ref) =>
    ref.read(firebaseAuthProvider).currentUser == null ? _redirectUri(state) : null;

// ref.read(authStateChangesProvider).when(
//       data: (user) => user == null ? _redirectUri(state) : null,
//       loading: () => _redirectUri(state),
//       error: (err, stack) => _redirectUri(state),
//     )

String _redirectUri(GoRouterState state) =>
    Uri(path: loginPath, queryParameters: {'target': state.fullPath ?? defaultPath}).toString();
