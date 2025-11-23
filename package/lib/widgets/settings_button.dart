import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/localization.dart';
import 'package:torreyana_mob/providers/navigation.dart';

class SettingsButton extends ConsumerWidget {
  const SettingsButton({this.pushNavigation = false, super.key});

  final bool pushNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: torreyanaLoc(context).settingsLabel,
      onPressed: () => context.navigate(
        ref,
        '/$settingsPathSegment?showProfileLink=true',
        push: pushNavigation,
      ),
    );
  }
}
