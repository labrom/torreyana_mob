// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flowHash() => r'02ca93c02768928c27f5906b476ca0d760352fb6';

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

/// See also [flow].
@ProviderFor(flow)
const flowProvider = FlowFamily();

/// See also [flow].
class FlowFamily extends Family<Flow> {
  /// See also [flow].
  const FlowFamily();

  /// See also [flow].
  FlowProvider call({
    required String flowName,
  }) {
    return FlowProvider(
      flowName: flowName,
    );
  }

  @override
  FlowProvider getProviderOverride(
    covariant FlowProvider provider,
  ) {
    return call(
      flowName: provider.flowName,
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
  String? get name => r'flowProvider';
}

/// See also [flow].
class FlowProvider extends AutoDisposeProvider<Flow> {
  /// See also [flow].
  FlowProvider({
    required String flowName,
  }) : this._internal(
          (ref) => flow(
            ref as FlowRef,
            flowName: flowName,
          ),
          from: flowProvider,
          name: r'flowProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$flowHash,
          dependencies: FlowFamily._dependencies,
          allTransitiveDependencies: FlowFamily._allTransitiveDependencies,
          flowName: flowName,
        );

  FlowProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flowName,
  }) : super.internal();

  final String flowName;

  @override
  Override overrideWith(
    Flow Function(FlowRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlowProvider._internal(
        (ref) => create(ref as FlowRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flowName: flowName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Flow> createElement() {
    return _FlowProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlowProvider && other.flowName == flowName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flowName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FlowRef on AutoDisposeProviderRef<Flow> {
  /// The parameter `flowName` of this provider.
  String get flowName;
}

class _FlowProviderElement extends AutoDisposeProviderElement<Flow>
    with FlowRef {
  _FlowProviderElement(super.provider);

  @override
  String get flowName => (origin as FlowProvider).flowName;
}

String _$stepBuilderHash() => r'9ba702383f7b74fc74e3d9e4010832bf0348319b';

/// See also [stepBuilder].
@ProviderFor(stepBuilder)
const stepBuilderProvider = StepBuilderFamily();

/// See also [stepBuilder].
class StepBuilderFamily
    extends Family<Widget Function(BuildContext, WidgetRef, Widget?)> {
  /// See also [stepBuilder].
  const StepBuilderFamily();

  /// See also [stepBuilder].
  StepBuilderProvider call({
    required String flow,
  }) {
    return StepBuilderProvider(
      flow: flow,
    );
  }

  @override
  StepBuilderProvider getProviderOverride(
    covariant StepBuilderProvider provider,
  ) {
    return call(
      flow: provider.flow,
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
  String? get name => r'stepBuilderProvider';
}

/// See also [stepBuilder].
class StepBuilderProvider extends AutoDisposeProvider<
    Widget Function(BuildContext, WidgetRef, Widget?)> {
  /// See also [stepBuilder].
  StepBuilderProvider({
    required String flow,
  }) : this._internal(
          (ref) => stepBuilder(
            ref as StepBuilderRef,
            flow: flow,
          ),
          from: stepBuilderProvider,
          name: r'stepBuilderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stepBuilderHash,
          dependencies: StepBuilderFamily._dependencies,
          allTransitiveDependencies:
              StepBuilderFamily._allTransitiveDependencies,
          flow: flow,
        );

  StepBuilderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flow,
  }) : super.internal();

  final String flow;

  @override
  Override overrideWith(
    Widget Function(BuildContext, WidgetRef, Widget?) Function(
            StepBuilderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StepBuilderProvider._internal(
        (ref) => create(ref as StepBuilderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flow: flow,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Widget Function(BuildContext, WidgetRef, Widget?)>
      createElement() {
    return _StepBuilderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StepBuilderProvider && other.flow == flow;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flow.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StepBuilderRef on AutoDisposeProviderRef<
    Widget Function(BuildContext, WidgetRef, Widget?)> {
  /// The parameter `flow` of this provider.
  String get flow;
}

class _StepBuilderProviderElement extends AutoDisposeProviderElement<
    Widget Function(BuildContext, WidgetRef, Widget?)> with StepBuilderRef {
  _StepBuilderProviderElement(super.provider);

  @override
  String get flow => (origin as StepBuilderProvider).flow;
}

String _$currentUserFlowStateHash() =>
    r'c7e7e5e6566649eb7a8dd87083a4fa02460abdc6';

abstract class _$CurrentUserFlowState
    extends BuildlessAutoDisposeNotifier<UserFlowState> {
  late final String flowName;

  UserFlowState build({
    required String flowName,
  });
}

/// See also [CurrentUserFlowState].
@ProviderFor(CurrentUserFlowState)
const currentUserFlowStateProvider = CurrentUserFlowStateFamily();

/// See also [CurrentUserFlowState].
class CurrentUserFlowStateFamily extends Family<UserFlowState> {
  /// See also [CurrentUserFlowState].
  const CurrentUserFlowStateFamily();

  /// See also [CurrentUserFlowState].
  CurrentUserFlowStateProvider call({
    required String flowName,
  }) {
    return CurrentUserFlowStateProvider(
      flowName: flowName,
    );
  }

  @override
  CurrentUserFlowStateProvider getProviderOverride(
    covariant CurrentUserFlowStateProvider provider,
  ) {
    return call(
      flowName: provider.flowName,
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
  String? get name => r'currentUserFlowStateProvider';
}

/// See also [CurrentUserFlowState].
class CurrentUserFlowStateProvider extends AutoDisposeNotifierProviderImpl<
    CurrentUserFlowState, UserFlowState> {
  /// See also [CurrentUserFlowState].
  CurrentUserFlowStateProvider({
    required String flowName,
  }) : this._internal(
          () => CurrentUserFlowState()..flowName = flowName,
          from: currentUserFlowStateProvider,
          name: r'currentUserFlowStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentUserFlowStateHash,
          dependencies: CurrentUserFlowStateFamily._dependencies,
          allTransitiveDependencies:
              CurrentUserFlowStateFamily._allTransitiveDependencies,
          flowName: flowName,
        );

  CurrentUserFlowStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flowName,
  }) : super.internal();

  final String flowName;

  @override
  UserFlowState runNotifierBuild(
    covariant CurrentUserFlowState notifier,
  ) {
    return notifier.build(
      flowName: flowName,
    );
  }

  @override
  Override overrideWith(CurrentUserFlowState Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentUserFlowStateProvider._internal(
        () => create()..flowName = flowName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flowName: flowName,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CurrentUserFlowState, UserFlowState>
      createElement() {
    return _CurrentUserFlowStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentUserFlowStateProvider && other.flowName == flowName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flowName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentUserFlowStateRef on AutoDisposeNotifierProviderRef<UserFlowState> {
  /// The parameter `flowName` of this provider.
  String get flowName;
}

class _CurrentUserFlowStateProviderElement
    extends AutoDisposeNotifierProviderElement<CurrentUserFlowState,
        UserFlowState> with CurrentUserFlowStateRef {
  _CurrentUserFlowStateProviderElement(super.provider);

  @override
  String get flowName => (origin as CurrentUserFlowStateProvider).flowName;
}

String _$memorySessionDataRepositoryHash() =>
    r'fb0e451d33cc9a581a92036d9e67c583bebb5450';

/// See also [MemorySessionDataRepository].
@ProviderFor(MemorySessionDataRepository)
final memorySessionDataRepositoryProvider = AutoDisposeNotifierProvider<
    MemorySessionDataRepository, Map<String, dynamic>>.internal(
  MemorySessionDataRepository.new,
  name: r'memorySessionDataRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memorySessionDataRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MemorySessionDataRepository
    = AutoDisposeNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
