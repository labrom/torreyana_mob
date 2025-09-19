// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stepBuilderHash() => r'07be8f867067f10c7d5a0744115ddd4a015cc1f8';

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

/// See also [stepBuilder].
@ProviderFor(stepBuilder)
const stepBuilderProvider = StepBuilderFamily();

/// See also [stepBuilder].
class StepBuilderFamily
    extends Family<Widget Function(BuildContext, WidgetRef)> {
  /// See also [stepBuilder].
  const StepBuilderFamily();

  /// See also [stepBuilder].
  StepBuilderProvider call({required FlowConfig config, required String flow}) {
    return StepBuilderProvider(config: config, flow: flow);
  }

  @override
  StepBuilderProvider getProviderOverride(
    covariant StepBuilderProvider provider,
  ) {
    return call(config: provider.config, flow: provider.flow);
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
class StepBuilderProvider
    extends AutoDisposeProvider<Widget Function(BuildContext, WidgetRef)> {
  /// See also [stepBuilder].
  StepBuilderProvider({required FlowConfig config, required String flow})
    : this._internal(
        (ref) => stepBuilder(ref as StepBuilderRef, config: config, flow: flow),
        from: stepBuilderProvider,
        name: r'stepBuilderProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$stepBuilderHash,
        dependencies: StepBuilderFamily._dependencies,
        allTransitiveDependencies: StepBuilderFamily._allTransitiveDependencies,
        config: config,
        flow: flow,
      );

  StepBuilderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.config,
    required this.flow,
  }) : super.internal();

  final FlowConfig config;
  final String flow;

  @override
  Override overrideWith(
    Widget Function(BuildContext, WidgetRef) Function(StepBuilderRef provider)
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
        config: config,
        flow: flow,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Widget Function(BuildContext, WidgetRef)>
  createElement() {
    return _StepBuilderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StepBuilderProvider &&
        other.config == config &&
        other.flow == flow;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, config.hashCode);
    hash = _SystemHash.combine(hash, flow.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StepBuilderRef
    on AutoDisposeProviderRef<Widget Function(BuildContext, WidgetRef)> {
  /// The parameter `config` of this provider.
  FlowConfig get config;

  /// The parameter `flow` of this provider.
  String get flow;
}

class _StepBuilderProviderElement
    extends AutoDisposeProviderElement<Widget Function(BuildContext, WidgetRef)>
    with StepBuilderRef {
  _StepBuilderProviderElement(super.provider);

  @override
  FlowConfig get config => (origin as StepBuilderProvider).config;
  @override
  String get flow => (origin as StepBuilderProvider).flow;
}

String _$currentUserFlowStateHash() =>
    r'cad9a032346e128542a3db2830008c96daf635da';

abstract class _$CurrentUserFlowState
    extends BuildlessAutoDisposeNotifier<UserFlowState> {
  late final FlowConfig config;
  late final String flowName;

  UserFlowState build({required FlowConfig config, required String flowName});
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
    required FlowConfig config,
    required String flowName,
  }) {
    return CurrentUserFlowStateProvider(config: config, flowName: flowName);
  }

  @override
  CurrentUserFlowStateProvider getProviderOverride(
    covariant CurrentUserFlowStateProvider provider,
  ) {
    return call(config: provider.config, flowName: provider.flowName);
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
class CurrentUserFlowStateProvider
    extends
        AutoDisposeNotifierProviderImpl<CurrentUserFlowState, UserFlowState> {
  /// See also [CurrentUserFlowState].
  CurrentUserFlowStateProvider({
    required FlowConfig config,
    required String flowName,
  }) : this._internal(
         () => CurrentUserFlowState()
           ..config = config
           ..flowName = flowName,
         from: currentUserFlowStateProvider,
         name: r'currentUserFlowStateProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$currentUserFlowStateHash,
         dependencies: CurrentUserFlowStateFamily._dependencies,
         allTransitiveDependencies:
             CurrentUserFlowStateFamily._allTransitiveDependencies,
         config: config,
         flowName: flowName,
       );

  CurrentUserFlowStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.config,
    required this.flowName,
  }) : super.internal();

  final FlowConfig config;
  final String flowName;

  @override
  UserFlowState runNotifierBuild(covariant CurrentUserFlowState notifier) {
    return notifier.build(config: config, flowName: flowName);
  }

  @override
  Override overrideWith(CurrentUserFlowState Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentUserFlowStateProvider._internal(
        () => create()
          ..config = config
          ..flowName = flowName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        config: config,
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
    return other is CurrentUserFlowStateProvider &&
        other.config == config &&
        other.flowName == flowName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, config.hashCode);
    hash = _SystemHash.combine(hash, flowName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentUserFlowStateRef on AutoDisposeNotifierProviderRef<UserFlowState> {
  /// The parameter `config` of this provider.
  FlowConfig get config;

  /// The parameter `flowName` of this provider.
  String get flowName;
}

class _CurrentUserFlowStateProviderElement
    extends
        AutoDisposeNotifierProviderElement<CurrentUserFlowState, UserFlowState>
    with CurrentUserFlowStateRef {
  _CurrentUserFlowStateProviderElement(super.provider);

  @override
  FlowConfig get config => (origin as CurrentUserFlowStateProvider).config;
  @override
  String get flowName => (origin as CurrentUserFlowStateProvider).flowName;
}

String _$memorySessionDataRepositoryHash() =>
    r'b2588e3a431260f30d295f7940aaa3f6d442705b';

/// See also [MemorySessionDataRepository].
@ProviderFor(MemorySessionDataRepository)
final memorySessionDataRepositoryProvider =
    AutoDisposeNotifierProvider<
      MemorySessionDataRepository,
      Map<String, dynamic>
    >.internal(
      MemorySessionDataRepository.new,
      name: r'memorySessionDataRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$memorySessionDataRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemorySessionDataRepository =
    AutoDisposeNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
