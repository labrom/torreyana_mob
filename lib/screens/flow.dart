import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/flows.dart';

/// A screen that displays a flow.
///
/// This screen uses the [currentUserFlowStateProvider] and
/// [stepBuilderProvider] providers.
class FlowScreen extends ConsumerWidget {

  const FlowScreen({required this.flowName, super.key});
  final String flowName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(flowProvider(flowName: flowName));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ref.watch(stepBuilderProvider(flow: flowName)).call(context, ref, null),
          ),
          if (flow.totalSteps > 0) _progressBar(context, ref),
          _navBar(context, ref),
        ],
      ),
    );
  }

  Widget _navBar(BuildContext context, WidgetRef ref) {
    final currentUserFlowState =
        ref.watch(currentUserFlowStateProvider(flowName: flowName));
    final flow = ref.watch(flowProvider(flowName: flowName));

    if (flow.forwardNavigationOnly || currentUserFlowState.firstStep) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _nextbutton(context, ref),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _previousButton(context, ref),
          _nextbutton(context, ref),
        ],
      );
    }
  }

  Widget _previousButton(BuildContext context, WidgetRef ref) {
    final currentUserFlowStateNotifier =
        ref.watch(currentUserFlowStateProvider(flowName: flowName).notifier);
    return TextButton(
      onPressed: currentUserFlowStateNotifier.previousStep,
      child: const Text('Previous'),
    );
  }

  Widget _nextbutton(BuildContext context, WidgetRef ref) {
    final currentUserFlowState =
        ref.watch(currentUserFlowStateProvider(flowName: flowName));
    final currentUserFlowStateNotifier =
        ref.watch(currentUserFlowStateProvider(flowName: flowName).notifier);
    final flow = ref.watch(flowProvider(flowName: flowName));
    final sessionData = ref.watch(memorySessionDataRepositoryProvider);
    final nextStepAllowed =
        flow.canGoNext(currentUserFlowState.currentStep, sessionData);
    return currentUserFlowState.last
        ? ElevatedButton(
            onPressed: nextStepAllowed
                ? () {
                    ref
                        .read(memorySessionDataRepositoryProvider.notifier)
                        .writeToUserSettings(flowName: flowName);
                    // TODO Should we wait til it's done?
                    context.pop();
                  }
                : null,
            child: const Text('Finish'),
          )
        : TextButton(
            onPressed: nextStepAllowed
                ? currentUserFlowStateNotifier.nextStep
                : null,
            child: const Text('Next'),
          );
  }

  Widget _progressBar(BuildContext context, WidgetRef ref) => Container();
}
