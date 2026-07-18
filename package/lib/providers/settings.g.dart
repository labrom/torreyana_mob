// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Creates the preference storage for the current authenticated user.

@ProviderFor(userPreferencesHandlerFactory)
final userPreferencesHandlerFactoryProvider =
    UserPreferencesHandlerFactoryProvider._();

/// Creates the preference storage for the current authenticated user.

final class UserPreferencesHandlerFactoryProvider
    extends
        $FunctionalProvider<
          UserPreferencesHandlerFactory,
          UserPreferencesHandlerFactory,
          UserPreferencesHandlerFactory
        >
    with $Provider<UserPreferencesHandlerFactory> {
  /// Creates the preference storage for the current authenticated user.
  UserPreferencesHandlerFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesHandlerFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesHandlerFactoryHash();

  @$internal
  @override
  $ProviderElement<UserPreferencesHandlerFactory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserPreferencesHandlerFactory create(Ref ref) {
    return userPreferencesHandlerFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPreferencesHandlerFactory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPreferencesHandlerFactory>(
        value,
      ),
    );
  }
}

String _$userPreferencesHandlerFactoryHash() =>
    r'b928ae723443469f110863898c511f6fcc581460';

/// The preference storage for the current authenticated user.
///
/// Watching the authentication stream makes the handler, its subscriptions,
/// and any handler-local caches change ownership when the user changes.

@ProviderFor(userPreferencesHandler)
final userPreferencesHandlerProvider = UserPreferencesHandlerProvider._();

/// The preference storage for the current authenticated user.
///
/// Watching the authentication stream makes the handler, its subscriptions,
/// and any handler-local caches change ownership when the user changes.

final class UserPreferencesHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserPreferencesHandler>,
          UserPreferencesHandler,
          FutureOr<UserPreferencesHandler>
        >
    with
        $FutureModifier<UserPreferencesHandler>,
        $FutureProvider<UserPreferencesHandler> {
  /// The preference storage for the current authenticated user.
  ///
  /// Watching the authentication stream makes the handler, its subscriptions,
  /// and any handler-local caches change ownership when the user changes.
  UserPreferencesHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesHandlerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesHandlerHash();

  @$internal
  @override
  $FutureProviderElement<UserPreferencesHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserPreferencesHandler> create(Ref ref) {
    return userPreferencesHandler(ref);
  }
}

String _$userPreferencesHandlerHash() =>
    r'7a342220d71c5e918861baa72611fda393a6f018';

/// Provides reactive access to the current user's preferences.

@ProviderFor(UserPreferencesRepository)
final userPreferencesRepositoryProvider = UserPreferencesRepositoryProvider._();

/// Provides reactive access to the current user's preferences.
final class UserPreferencesRepositoryProvider
    extends
        $StreamNotifierProvider<
          UserPreferencesRepository,
          Map<String, dynamic>
        > {
  /// Provides reactive access to the current user's preferences.
  UserPreferencesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPreferencesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPreferencesRepositoryHash();

  @$internal
  @override
  UserPreferencesRepository create() => UserPreferencesRepository();
}

String _$userPreferencesRepositoryHash() =>
    r'8bb6a52e3a374fcd4b5fc5186b32894fa98e04b1';

/// Provides reactive access to the current user's preferences.

abstract class _$UserPreferencesRepository
    extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
