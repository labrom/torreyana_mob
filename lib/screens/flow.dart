import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:torreyana_mob/providers/flows.dart';

/// A screen that displays a flow.
///
/// This screen uses the [currentUserFlowStateProvider] and
/// [stepBuilderProvider] providers.
class FlowScreen extends ConsumerWidget {

  const FlowScreen({required this.flowName, required this.config, super.key});
  final String flowName;
  final FlowConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = config.flows[flowName]!;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ref.watch(stepBuilderProvider(config: config, flow: flowName)).call(context, ref),
          ),
          if (flow.totalSteps > 0) _progressBar(context, ref),
          _navBar(context, ref),
        ],
      ),
    );
  }

  Widget _navBar(BuildContext context, WidgetRef ref) {
    final currentUserFlowState =
        ref.watch(currentUserFlowStateProvider(config: config, flowName: flowName));
    final flow = config.flows[flowName]!;

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
        ref.watch(currentUserFlowStateProvider(config: config, flowName: flowName).notifier);
    return TextButton(
      onPressed: currentUserFlowStateNotifier.previousStep,
      child: const Text('Previous'),
    );
  }

  Widget _nextbutton(BuildContext context, WidgetRef ref) {
    final currentUserFlowState =
        ref.watch(currentUserFlowStateProvider(config: config, flowName: flowName));
    final currentUserFlowStateNotifier =
        ref.watch(currentUserFlowStateProvider(config: config, flowName: flowName).notifier);
    final flow = config.flows[flowName]!;
    final sessionData = ref.watch(memorySessionDataRepositoryProvider);
    final nextStepAllowed =
        flow.canGoNext(currentUserFlowState.currentStep, sessionData);
    return currentUserFlowState.last
        ? ElevatedButton(
            onPressed: nextStepAllowed
                ? () {
                    ref
                        .read(memorySessionDataRepositoryProvider.notifier)
                        .writeToUserSettings(config: config, flowName: flowName);
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
