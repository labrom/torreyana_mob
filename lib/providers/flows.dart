import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/providers/settings.dart';
import 'package:tourbillon/log.dart';

import '../widgets/settings.dart';

part 'flows.g.dart';
part '../my_flows.dart';

/// A flow description.
///
/// This class should be extended in order to define concrete flows.
/// A flow class is responsible for defining the sequence of steps needed to
/// complete the flow.
/// However, it is not responsible for building the steps UI. This should be
/// done in the [buildFlowStep] function. This allows different flows to share
/// steps. For example, an onboarding flow could have different versions
/// tailored to different user groups, with roughly the same steps but a few
/// variations. If these variations are implemented in separate [Flow] sub-classes,
/// they could still share most of their steps.
abstract class Flow {
  /// The flow name.
  ///
  /// This name isn't displayed in the UI.
  final String name;

  /// The flow's first step.
  ///
  /// A given flow always starts with the same step.
  final String firstStep;

  /// The data storage strategy to use with this flow.
  final FlowDataStorage dataStorage;

  /// Indicates if the flow only allows forward navigation.
  ///
  /// A flow that only allows forward navigation won't have a "Back" navigation
  /// button to go back to a previous step.
  /// This property is set to false by default.
  final bool forwardNavigationOnly;

  /// The flow's total number of steps.
  ///
  /// This should be specified for flows with a fixed number of steps.
  /// If a number larger than 0 is specified, a progress indicator is be shown
  /// in the flow's UI.
  /// This property is set to 0 by default, in which case [isLast] is used to
  /// determine when the end of the flow has been reached, and no progress
  /// indicator is shown.
  final int totalSteps;

  /// Creates a flow.
  ///
  /// Child classes need to invoke this constructor.
  const Flow(
    this.name, {
    required this.dataStorage,
    required this.firstStep,
    this.forwardNavigationOnly = false,
    this.totalSteps = 0,
  });

  /// Determines the next step, given the current step and the flow data.
  ///
  /// This method will only be invoked with [currentStep] values that will have
  /// been returned in previous invocations of the same method, or with the flow's
  /// first step that is passed in the constructor ([firstStep]).
  /// It is never invoked with [currentStep] being the last step, because
  /// the [isLast] method is invoked before.
  String nextStep(String currentStep, Map<String, dynamic> sessionData);

  /// Determines if the user is allowed to go to the next step when at a given
  /// step.
  ///
  /// This method returns true by default but can be overridden.
  /// The result of this method is used to enable or disable the button that
  /// goes to the next step (or finishes the flow if [currentStep] is the last
  /// step). It should be used to prevent the user from going to the next step
  /// until they have completed the current step.
  /// [sessionData] can probably be used in most cases to make that determination
  /// as it records the user input in the current step without waiting to go to
  /// the next step. For example, if the current step contains a text field for
  /// the user name, the user name would be recorded in [sessionData] as soon
  /// as the user types it in.
  bool canGoNext(String currentStep, Map<String, dynamic> sessionData) => true;

  /// Determines if the user is allowed to go back to the previous step when at
  /// a given step.
  ///
  /// This method returns true by default but this behavior can be overridden.
  /// This method is never invoked with [currentStep] being the first step.
  /// Also note that this is different from the [forwardNavigationOnly] property.
  /// This method will only be invoked in the case where [forwardNavigationOnly]
  /// is false, to determine if the "Back" navigation button should be enabled
  /// or not. Unlike [forwardNavigationOnly], it is contextual and will be
  /// invoked whenever a new step is displayed.
  bool canGoBack(String currentStep, Map<String, dynamic> sessionData) => true;

  /// Determines if a step is the last one in the flow.
  ///
  /// This method is used in order to avoid asking for the next step when not
  /// needed, and also adjusting the flow UI to indicate that the last step has
  /// been reached.
  bool isLast(String currentStep);
}

/// Flow data storage strategies.
enum FlowDataStorage {
  /// No flow data is stored.
  none,

  /// Flow data is only stored in memory.
  memoryOnly,

  /// Flow data is stored as user settings. Existing settings will be overridden
  /// by the values set in the flow.
  mergedUserSettings,

  /// Flow data is stored in a group (Firestore document) inside user settings.
  flowNameUserSettingsGroup
}

class UserFlowState {
  final bool started;
  final bool last;
  final String flow;
  final List<String> steps;

  UserFlowState({required this.flow, required this.steps, this.last = false})
      : assert(flow.isNotEmpty && steps.isNotEmpty),
        started = true;

  UserFlowState.initial()
      : flow = '',
        steps = [],
        last = false,
        started = false;

  bool get firstStep => steps.length == 1;

  int get currentIndex => steps.length - 1;

  String get currentStep => steps.last;
}

@riverpod
Flow flow(FlowRef ref, {required String flowName}) => flows[flowName]!;

@riverpod
class CurrentUserFlowState extends _$CurrentUserFlowState {
  @override
  UserFlowState build({required String flowName}) => UserFlowState(
      flow: flowName,
      steps: [ref.read(flowProvider(flowName: flowName)).firstStep]);

  void nextStep() {
    if (state.started && !state.last) {
      final flow = ref.read(flowProvider(flowName: state.flow));
      final nextStep = flow.nextStep(
          state.steps.last, ref.read(memorySessionDataRepositoryProvider));
      log.d('Moving flow \'$state.flow\' to next step: \'$nextStep\'');
      state = UserFlowState(
          flow: state.flow,
          steps: [...state.steps, nextStep],
          last: flow.isLast(nextStep));
    } else {
      log.e(state.last
          ? 'Flow \'${state.flow}\' has already reached its last step.'
          : 'No flow is currently started.');
    }
  }

  void previousStep() {
    if (!state.firstStep) {
      var steps = state.steps.sublist(0, state.steps.length - 1);
      log.d('Moving flow \'$state.flow\' to previous step: \'${steps.last}\'');
      state = UserFlowState(flow: state.flow, steps: steps);
    } else {
      log.e('Flow \'${state.flow}\' has already returned to its first step.');
    }
  }
}

@riverpod
class MemorySessionDataRepository extends _$MemorySessionDataRepository {
  @override
  Map<String, dynamic> build() => {};

  void write(String field, dynamic value) {
    final newState = Map.of(state);
    newState[field] = value;
    state = newState;
  }

  Future<void> writeToUserSettings({required String flowName}) async {
    final dataStorage = ref.read(flowProvider(flowName: flowName)).dataStorage;
    final firestore =
        ref.read(firestoreUserSettingsRepositoryProvider.notifier);
    switch (dataStorage) {
      case FlowDataStorage.mergedUserSettings:
        for (final entry in state.entries) {
          await firestore.write(entry.key, entry.value);
        }
      // TODO
      case FlowDataStorage.flowNameUserSettingsGroup:
      default:
    }
  }
}

@riverpod
Widget Function(BuildContext, WidgetRef, Widget?) stepBuilder(
  StepBuilderRef ref, {
  required String flow,
}) {
  final currentUserFlowState =
      ref.watch(currentUserFlowStateProvider(flowName: flow));
  return (context, ref, _) =>
      buildFlowStep(context, currentUserFlowState.steps.last);
}
