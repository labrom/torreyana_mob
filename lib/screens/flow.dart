import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/flows.dart';

/// A screen that displays a flow.
///
/// This screen uses the [currentUserFlowStateProvider] and
/// [stepBuilderProvider] providers.
class FlowScreen extends ConsumerWidget {
  final String flowName;

  const FlowScreen({super.key, required this.flowName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.read(flowProvider(flowName: flowName));
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer(
              builder: ref.watch(stepBuilderProvider(flow: flowName)),
            ),
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
    final flow = ref.read(flowProvider(flowName: flowName));

    if (flow.forwardNavigationOnly || currentUserFlowState.firstStep) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _nextbutton(context, ref),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
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
        ref.read(currentUserFlowStateProvider(flowName: flowName).notifier);
    return TextButton(
      onPressed: () {
        currentUserFlowStateNotifier.previousStep();
      },
      child: const Text('Previous'),
    );
  }

  Widget _nextbutton(BuildContext context, WidgetRef ref) {
    final currentUserFlowState =
        ref.watch(currentUserFlowStateProvider(flowName: flowName));
    final currentUserFlowStateNotifier =
        ref.read(currentUserFlowStateProvider(flowName: flowName).notifier);
    final flow = ref.read(flowProvider(flowName: flowName));
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
                ? () {
                    currentUserFlowStateNotifier.nextStep();
                  }
                : null,
            child: const Text('Next'),
          );
  }

  Widget _progressBar(BuildContext context, WidgetRef ref) => Container();
}
