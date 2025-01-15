// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$navigationHandlerHash() => r'cfd602e2a2a1700de06ff4f626bdf0403bab9cb8';

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
    extends Family<void Function(BuildContext, String)> {
  /// See also [navigationHandler].
  const NavigationHandlerFamily();

  /// See also [navigationHandler].
  NavigationHandlerProvider call(
    String route,
  ) {
    return NavigationHandlerProvider(
      route,
    );
  }

  @override
  NavigationHandlerProvider getProviderOverride(
    covariant NavigationHandlerProvider provider,
  ) {
    return call(
      provider.route,
    );
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
    extends AutoDisposeProvider<void Function(BuildContext, String)> {
  /// See also [navigationHandler].
  NavigationHandlerProvider(
    String route,
  ) : this._internal(
          (ref) => navigationHandler(
            ref as NavigationHandlerRef,
            route,
          ),
          from: navigationHandlerProvider,
          name: r'navigationHandlerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
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
    void Function(BuildContext, String) Function(NavigationHandlerRef provider)
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
  AutoDisposeProviderElement<void Function(BuildContext, String)>
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
    on AutoDisposeProviderRef<void Function(BuildContext, String)> {
  /// The parameter `route` of this provider.
  String get route;
}

class _NavigationHandlerProviderElement
    extends AutoDisposeProviderElement<void Function(BuildContext, String)>
    with NavigationHandlerRef {
  _NavigationHandlerProviderElement(super.provider);

  @override
  String get route => (origin as NavigationHandlerProvider).route;
}

String _$routerHash() => r'a805b517f8f93aec2ba02262c86b302634af413e';

/// go_router provider with all the registered routes.
///
/// Includes a top-level route to the login screen, that can be used in a
/// redirect. Don't set a login redirect on the root path ('/') since the login
/// route is under that path root.
///
/// Copied from [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
