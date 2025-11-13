// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flows.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentUserFlowState)
const currentUserFlowStateProvider = CurrentUserFlowStateFamily._();

final class CurrentUserFlowStateProvider
    extends $NotifierProvider<CurrentUserFlowState, UserFlowState> {
  const CurrentUserFlowStateProvider._({
    required CurrentUserFlowStateFamily super.from,
    required ({FlowConfig config, String flowName}) super.argument,
  }) : super(
         retry: null,
         name: r'currentUserFlowStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentUserFlowStateHash();

  @override
  String toString() {
    return r'currentUserFlowStateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CurrentUserFlowState create() => CurrentUserFlowState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserFlowState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentUserFlowStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentUserFlowStateHash() =>
    r'cad9a032346e128542a3db2830008c96daf635da';

final class CurrentUserFlowStateFamily extends $Family
    with
        $ClassFamilyOverride<
          CurrentUserFlowState,
          UserFlowState,
          UserFlowState,
          UserFlowState,
          ({FlowConfig config, String flowName})
        > {
  const CurrentUserFlowStateFamily._()
    : super(
        retry: null,
        name: r'currentUserFlowStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentUserFlowStateProvider call({
    required FlowConfig config,
    required String flowName,
  }) => CurrentUserFlowStateProvider._(
    argument: (config: config, flowName: flowName),
    from: this,
  );

  @override
  String toString() => r'currentUserFlowStateProvider';
}

abstract class _$CurrentUserFlowState extends $Notifier<UserFlowState> {
  late final _$args = ref.$arg as ({FlowConfig config, String flowName});
  FlowConfig get config => _$args.config;
  String get flowName => _$args.flowName;

  UserFlowState build({required FlowConfig config, required String flowName});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(config: _$args.config, flowName: _$args.flowName);
    final ref = this.ref as $Ref<UserFlowState, UserFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserFlowState, UserFlowState>,
              UserFlowState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MemorySessionDataRepository)
const memorySessionDataRepositoryProvider =
    MemorySessionDataRepositoryProvider._();

final class MemorySessionDataRepositoryProvider
    extends
        $NotifierProvider<MemorySessionDataRepository, Map<String, dynamic>> {
  const MemorySessionDataRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memorySessionDataRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memorySessionDataRepositoryHash();

  @$internal
  @override
  MemorySessionDataRepository create() => MemorySessionDataRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>>(value),
    );
  }
}

String _$memorySessionDataRepositoryHash() =>
    r'b2588e3a431260f30d295f7940aaa3f6d442705b';

abstract class _$MemorySessionDataRepository
    extends $Notifier<Map<String, dynamic>> {
  Map<String, dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, dynamic>, Map<String, dynamic>>,
              Map<String, dynamic>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(stepBuilder)
const stepBuilderProvider = StepBuilderFamily._();

final class StepBuilderProvider
    extends
        $FunctionalProvider<
          Widget Function(BuildContext, WidgetRef),
          Widget Function(BuildContext, WidgetRef),
          Widget Function(BuildContext, WidgetRef)
        >
    with $Provider<Widget Function(BuildContext, WidgetRef)> {
  const StepBuilderProvider._({
    required StepBuilderFamily super.from,
    required ({FlowConfig config, String flow}) super.argument,
  }) : super(
         retry: null,
         name: r'stepBuilderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stepBuilderHash();

  @override
  String toString() {
    return r'stepBuilderProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<Widget Function(BuildContext, WidgetRef)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Widget Function(BuildContext, WidgetRef) create(Ref ref) {
    final argument = this.argument as ({FlowConfig config, String flow});
    return stepBuilder(ref, config: argument.config, flow: argument.flow);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Widget Function(BuildContext, WidgetRef) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Widget Function(BuildContext, WidgetRef)>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StepBuilderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stepBuilderHash() => r'07be8f867067f10c7d5a0744115ddd4a015cc1f8';

final class StepBuilderFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Widget Function(BuildContext, WidgetRef),
          ({FlowConfig config, String flow})
        > {
  const StepBuilderFamily._()
    : super(
        retry: null,
        name: r'stepBuilderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StepBuilderProvider call({
    required FlowConfig config,
    required String flow,
  }) =>
      StepBuilderProvider._(argument: (config: config, flow: flow), from: this);

  @override
  String toString() => r'stepBuilderProvider';
}
