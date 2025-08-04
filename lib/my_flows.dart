part of 'providers/flows.dart';

final flows = {
  'onboarding1': const Flow1('onboarding1'),
  'intro': Intro(),
};

Widget buildFlowStep(
  BuildContext context,
  WidgetRef ref,
  String stepName,
  Map<String, dynamic> sessionData,
) {
  if (stepName.startsWith('intro')) {
    return Center(child: Text(stepName));
  }
  return CachedToggleSetting(
    title: stepName,
    settingKey: 'key$stepName',
  );
}

class Flow1 extends Flow {
  const Flow1(
    super.name, {
    super.firstStep = '1',
    super.dataStorage = FlowDataStorage.mergedUserSettings,
  });

  @override
  String nextStep(String currentStep, Map<String, dynamic> sessionData) =>
      (int.parse(currentStep) + 1).toString();

  @override
  bool isLast(String currentStep) {
    return currentStep == '5';
  }
}

/// A sample introduction flow.
///
/// This flow has a fixed number of steps and doesn't require to store any data.
class Intro extends Flow {
  static const _steps = ['intro1', 'intro2', 'intro3'];

  Intro()
      : super(
          'intro',
          dataStorage: FlowDataStorage.none,
          firstStep: _steps[0],
          totalSteps: _steps.length,
          forwardNavigationOnly: true,
        );

  @override
  bool isLast(String currentStep) => _steps.last == currentStep;

  @override
  String nextStep(String currentStep, Map<String, dynamic> sessionData) {
    final index = _steps.indexOf(currentStep);
    if (index >= 0 && index < _steps.length - 1) {
      return _steps[index + 1];
    }
    throw ArgumentError('Invalid currentStep value');
  }
}
