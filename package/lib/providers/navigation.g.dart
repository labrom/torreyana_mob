// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(navigationHandler)
const navigationHandlerProvider = NavigationHandlerFamily._();

final class NavigationHandlerProvider
    extends
        $FunctionalProvider<
          void Function(BuildContext, String, bool),
          void Function(BuildContext, String, bool),
          void Function(BuildContext, String, bool)
        >
    with $Provider<void Function(BuildContext, String, bool)> {
  const NavigationHandlerProvider._({
    required NavigationHandlerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'navigationHandlerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$navigationHandlerHash();

  @override
  String toString() {
    return r'navigationHandlerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<void Function(BuildContext, String, bool)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  void Function(BuildContext, String, bool) create(Ref ref) {
    final argument = this.argument as String;
    return navigationHandler(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function(BuildContext, String, bool) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<void Function(BuildContext, String, bool)>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NavigationHandlerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$navigationHandlerHash() => r'32040337907bd4371d5c713c0e60a2e25f4f8a18';

final class NavigationHandlerFamily extends $Family
    with
        $FunctionalFamilyOverride<
          void Function(BuildContext, String, bool),
          String
        > {
  const NavigationHandlerFamily._()
    : super(
        retry: null,
        name: r'navigationHandlerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NavigationHandlerProvider call(String route) =>
      NavigationHandlerProvider._(argument: route, from: this);

  @override
  String toString() => r'navigationHandlerProvider';
}

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.

@ProviderFor(router)
const routerProvider = RouterFamily._();

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// go_router provider with all the registered routes.
  ///
  /// Includes a top-level route to the login screen, that can be used in a
  /// redirect. Don't set a login redirect on the root path ('/') since the login
  /// route is under that path root.
  const RouterProvider._({
    required RouterFamily super.from,
    required (Navigation, FlowConfig?) super.argument,
  }) : super(
         retry: null,
         name: r'routerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @override
  String toString() {
    return r'routerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    final argument = this.argument as (Navigation, FlowConfig?);
    return router(ref, argument.$1, argument.$2);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RouterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routerHash() => r'33db27f8d6c609f26aa404849653510d49c5f9c8';

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.

final class RouterFamily extends $Family
    with $FunctionalFamilyOverride<GoRouter, (Navigation, FlowConfig?)> {
  const RouterFamily._()
    : super(
        retry: null,
        name: r'routerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// go_router provider with all the registered routes.
  ///
  /// Includes a top-level route to the login screen, that can be used in a
  /// redirect. Don't set a login redirect on the root path ('/') since the login
  /// route is under that path root.

  RouterProvider call(Navigation nav, FlowConfig? flowConfig) =>
      RouterProvider._(argument: (nav, flowConfig), from: this);

  @override
  String toString() => r'routerProvider';
}
