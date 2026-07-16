// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user preference storage configured for this application.

@ProviderFor(userPreferencesHandler)
final userPreferencesHandlerProvider = UserPreferencesHandlerProvider._();

/// The user preference storage configured for this application.

final class UserPreferencesHandlerProvider
    extends
        $FunctionalProvider<
          UserPreferencesHandler,
          UserPreferencesHandler,
          UserPreferencesHandler
        >
    with $Provider<UserPreferencesHandler> {
  /// The user preference storage configured for this application.
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
  $ProviderElement<UserPreferencesHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserPreferencesHandler create(Ref ref) {
    return userPreferencesHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserPreferencesHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserPreferencesHandler>(value),
    );
  }
}

String _$userPreferencesHandlerHash() =>
    r'261124724a5214fe5541fdf609ceed8932780fac';

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
    r'6bf27afe11a1b0c5acf881249a43c04dac152150';

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
