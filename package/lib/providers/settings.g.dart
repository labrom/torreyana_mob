// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FirestoreUserSettingsRepository)
const firestoreUserSettingsRepositoryProvider =
    FirestoreUserSettingsRepositoryProvider._();

final class FirestoreUserSettingsRepositoryProvider
    extends
        $StreamNotifierProvider<
          FirestoreUserSettingsRepository,
          Map<String, dynamic>
        > {
  const FirestoreUserSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreUserSettingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreUserSettingsRepositoryHash();

  @$internal
  @override
  FirestoreUserSettingsRepository create() => FirestoreUserSettingsRepository();
}

String _$firestoreUserSettingsRepositoryHash() =>
    r'48d558996a06c39b4f5ad8b2b86ff3be276a3938';

abstract class _$FirestoreUserSettingsRepository
    extends $StreamNotifier<Map<String, dynamic>> {
  Stream<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
    element.handleValue(ref, created);
  }
}
