import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

@riverpod
FirebaseAnalytics analytics(Ref ref) => FirebaseAnalytics.instance;

/// Records Flutter page transitions with both Analytics screen dimensions.
///
/// `FirebaseAnalyticsObserver` only supplies `screen_name`. On Android, that
/// leaves `screen_class` set to the hosting activity (usually `MainActivity`),
/// which makes the "Page title and screen class" report unable to distinguish
/// Flutter pages.
class AnalyticsScreenObserver extends NavigatorObserver {
  AnalyticsScreenObserver({required this.analytics});

  final FirebaseAnalytics analytics;

  void _record(Route<dynamic>? route) {
    if (route is! PageRoute<dynamic>) return;

    final screen = route.settings.name;
    if (screen == null || screen.isEmpty) return;

    analytics.logScreenView(screenName: screen, screenClass: screen);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _record(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _record(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute<dynamic>) _record(previousRoute);
  }
}
