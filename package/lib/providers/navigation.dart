import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/providers/analytics.dart';
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

/// A screen definition.
///
/// A screen can be a shell screen, meaning that it will display one of its
/// [shellChildren] at a time, and it will allow the user to navigate to the
/// other children.
@immutable
class Screen {
  const Screen({
    required this.name,
    this.builder,
    this.shellBuilder,
    this.requiresLogin = false,
    this.requiresRole = '',
    this.shellChildren = const [],
  }) : assert(shellChildren.length > 0 && shellBuilder != null || builder != null);
  // The screen's name in the router.
  final String name;

  // The builder function that creates the screen's widget.
  final Widget Function(
    BuildContext context,
    Map<String, String> parameters,
  )?
  builder;

  // The builder function that creates the screen's widget
  // when the screen is a shell.
  final Widget Function(
    BuildContext context,
    Map<String, String> parameters, {
    // The screen's current child.
    required Widget child,
    // The list of all child destinations.
    required List<Destination> shellChildren,
  })?
  shellBuilder;

  final bool requiresLogin;
  final String requiresRole;
  // The list of child destinations, if this screen is a shell.
  final List<Destination> shellChildren;

  bool get isShell => shellChildren.isNotEmpty;

  RouteBase toRoute(
    Ref ref,
    Navigation nav, {
    List<RouteBase> routes = const [],
  }) {
    if (isShell) {
      return ShellRoute(
        builder: (context, state, child) => shellBuilder!(
          context,
          state.pathParameters..addAll(state.uri.queryParameters),
          child: child,
          shellChildren: shellChildren,
        ),
        routes: shellChildren.map((destination) => destination.screen.toRoute(ref, nav)).toList(),
      );
    }
    return GoRoute(
      path: name,
      builder: (context, state) =>
          builder!(context, state.pathParameters..addAll(state.uri.queryParameters)),
      redirect:
          (requiresLogin && !nav.homeRequiresLogin) ||
              (name == defaultPath && nav.homeRequiresLogin)
          ? (context, state) => _loginRedirect(context, state, ref)
          : null,
      routes: routes,
    );
  }
}

/// A destination within a shell screen.
///
/// A destination describes a navigation affordance ([label] and [icon]) and the definition
/// of the screen it should navigate to.
@immutable
class Destination {
  const Destination(
    this.screen,
    this.label,
    this.icon,
  );
  final String label;
  final Icon icon;
  final Screen screen;
}

@immutable
class Navigation {
  const Navigation({
    required this.homeScreen,
    required this.screens,
    this.homeScreenForRole,
    this.settingsWidgets,
    this.homeRequiresLogin = false,
    this.showProfileLinkInSettings = false,
    this.showThemeSettings = true,
  });
  final Screen homeScreen;
  final List<Screen> screens;
  final Map<String, Screen>? homeScreenForRole;
  final bool homeRequiresLogin;
  final bool showProfileLinkInSettings;
  final bool showThemeSettings;
  final List<Widget>? settingsWidgets;

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
  observers: [FirebaseAnalyticsObserver(analytics: ref.watch(analyticsProvider))],
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
      routes: [
        // If the home screen is a regular screen (not a shell), settings screens
        // are set up as child screens
        if (!nav.homeScreen.isShell) ...settingsRoutes(ref, nav),

        // Flows
        if (flowConfig != null)
          GoRoute(
            path: '$flowPathSegment/:name',
            builder: (context, state) => FlowScreen(
              config: flowConfig,
              flowName: state.pathParameters['name']!,
            ),
          ),

        // Custom screens that are children of the default screen
        // (path doesn't start with /)
        ...childScreenRoutes(ref, nav),
      ],
    ),

    // TODO
    // ...homeRedirectRoutes(ref),

    // If the home screen is a shell screen, settings screens are set up
    // as top-level screens and will need to be pushed on top of the home screen
    // in order to preserve back button behavior
    if (nav.homeScreen.isShell) ...settingsRoutes(ref, nav),

    // Top-level custom screens (path starts with /)
    ...topLevelScreenRoutes(ref, nav),
  ],
);

RouteBase defaultHomeRoute(Ref ref, Navigation nav, {required List<RouteBase> routes}) {
  final homeScreen = nav.getHomeScreen(/* TODO Get user role */);
  assert(homeScreen.name == defaultPath);
  final route = homeScreen.toRoute(ref, nav, routes: routes);
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

List<RouteBase> settingsRoutes(Ref ref, Navigation nav) {
  return [
    // Settings
    GoRoute(
      path: '/$settingsPathSegment',
      builder: (context, state) => SettingsScreen(
        showProfileLink:
            nav.showProfileLinkInSettings || state.uri.queryParameters['showProfileLink'] == 'true',
        showThemeSettings: nav.showThemeSettings,
        children: nav.settingsWidgets,
      ),
      routes: [
        if (nav.showThemeSettings)
          GoRoute(
            path: 'theme',
            builder: (context, state) => const ThemeSettingsScreen(),
          ),
      ],
    ),

    // Profile
    GoRoute(
      path: '/$profilePathSegment',
      builder: (context, state) => const UserProfileScreen(),
      redirect: (context, state) => _loginRedirect(context, state, ref),
    ),
  ];
}

List<RouteBase> topLevelScreenRoutes(Ref ref, Navigation nav) {
  return nav.screens
      .where((screen) => screen.name.startsWith('/'))
      .map(
        (screen) => screen.toRoute(ref, nav),
      )
      .toList();
}

List<RouteBase> childScreenRoutes(Ref ref, Navigation nav) {
  return nav.screens
      .where((screen) => !screen.name.startsWith('/'))
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
