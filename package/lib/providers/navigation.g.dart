// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$navigationHandlerHash() => r'32040337907bd4371d5c713c0e60a2e25f4f8a18';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [navigationHandler].
@ProviderFor(navigationHandler)
const navigationHandlerProvider = NavigationHandlerFamily();

/// See also [navigationHandler].
class NavigationHandlerFamily
    extends Family<void Function(BuildContext, String, bool)> {
  /// See also [navigationHandler].
  const NavigationHandlerFamily();

  /// See also [navigationHandler].
  NavigationHandlerProvider call(String route) {
    return NavigationHandlerProvider(route);
  }

  @override
  NavigationHandlerProvider getProviderOverride(
    covariant NavigationHandlerProvider provider,
  ) {
    return call(provider.route);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'navigationHandlerProvider';
}

/// See also [navigationHandler].
class NavigationHandlerProvider
    extends AutoDisposeProvider<void Function(BuildContext, String, bool)> {
  /// See also [navigationHandler].
  NavigationHandlerProvider(String route)
    : this._internal(
        (ref) => navigationHandler(ref as NavigationHandlerRef, route),
        from: navigationHandlerProvider,
        name: r'navigationHandlerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$navigationHandlerHash,
        dependencies: NavigationHandlerFamily._dependencies,
        allTransitiveDependencies:
            NavigationHandlerFamily._allTransitiveDependencies,
        route: route,
      );

  NavigationHandlerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.route,
  }) : super.internal();

  final String route;

  @override
  Override overrideWith(
    void Function(BuildContext, String, bool) Function(
      NavigationHandlerRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NavigationHandlerProvider._internal(
        (ref) => create(ref as NavigationHandlerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        route: route,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void Function(BuildContext, String, bool)>
  createElement() {
    return _NavigationHandlerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NavigationHandlerProvider && other.route == route;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, route.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NavigationHandlerRef
    on AutoDisposeProviderRef<void Function(BuildContext, String, bool)> {
  /// The parameter `route` of this provider.
  String get route;
}

class _NavigationHandlerProviderElement
    extends
        AutoDisposeProviderElement<void Function(BuildContext, String, bool)>
    with NavigationHandlerRef {
  _NavigationHandlerProviderElement(super.provider);

  @override
  String get route => (origin as NavigationHandlerProvider).route;
}

String _$routerHash() => r'1caad7d65afe7a569b7cce9ae2bff93ad6aefb66';

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
///
/// Copied from [router].
@ProviderFor(router)
const routerProvider = RouterFamily();

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
///
/// Copied from [router].
class RouterFamily extends Family<GoRouter> {
  /// go_router provider with all the registered routes.
  ///
  /// Includes a top-level route to the login screen, that can be used in a
  /// redirect. Don't set a login redirect on the root path ('/') since the login
  /// route is under that path root.
  ///
  /// Copied from [router].
  const RouterFamily();

  /// go_router provider with all the registered routes.
  ///
  /// Includes a top-level route to the login screen, that can be used in a
  /// redirect. Don't set a login redirect on the root path ('/') since the login
  /// route is under that path root.
  ///
  /// Copied from [router].
  RouterProvider call(Navigation nav, FlowConfig? flowConfig) {
    return RouterProvider(nav, flowConfig);
  }

  @override
  RouterProvider getProviderOverride(covariant RouterProvider provider) {
    return call(provider.nav, provider.flowConfig);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'routerProvider';
}

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
///
/// Copied from [router].
class RouterProvider extends AutoDisposeProvider<GoRouter> {
  /// go_router provider with all the registered routes.
  ///
  /// Includes a top-level route to the login screen, that can be used in a
  /// redirect. Don't set a login redirect on the root path ('/') since the login
  /// route is under that path root.
  ///
  /// Copied from [router].
  RouterProvider(Navigation nav, FlowConfig? flowConfig)
    : this._internal(
        (ref) => router(ref as RouterRef, nav, flowConfig),
        from: routerProvider,
        name: r'routerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$routerHash,
        dependencies: RouterFamily._dependencies,
        allTransitiveDependencies: RouterFamily._allTransitiveDependencies,
        nav: nav,
        flowConfig: flowConfig,
      );

  RouterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nav,
    required this.flowConfig,
  }) : super.internal();

  final Navigation nav;
  final FlowConfig? flowConfig;

  @override
  Override overrideWith(GoRouter Function(RouterRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: RouterProvider._internal(
        (ref) => create(ref as RouterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nav: nav,
        flowConfig: flowConfig,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GoRouter> createElement() {
    return _RouterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RouterProvider &&
        other.nav == nav &&
        other.flowConfig == flowConfig;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nav.hashCode);
    hash = _SystemHash.combine(hash, flowConfig.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RouterRef on AutoDisposeProviderRef<GoRouter> {
  /// The parameter `nav` of this provider.
  Navigation get nav;

  /// The parameter `flowConfig` of this provider.
  FlowConfig? get flowConfig;
}

class _RouterProviderElement extends AutoDisposeProviderElement<GoRouter>
    with RouterRef {
  _RouterProviderElement(super.provider);

  @override
  Navigation get nav => (origin as RouterProvider).nav;
  @override
  FlowConfig? get flowConfig => (origin as RouterProvider).flowConfig;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
