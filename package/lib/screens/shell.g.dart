// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedNavTab)
const selectedNavTabProvider = SelectedNavTabProvider._();

final class SelectedNavTabProvider
    extends $NotifierProvider<SelectedNavTab, int> {
  const SelectedNavTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedNavTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedNavTabHash();

  @$internal
  @override
  SelectedNavTab create() => SelectedNavTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedNavTabHash() => r'83cc1a5f0f5f81ae27456c37813d47c732721f7e';

abstract class _$SelectedNavTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
