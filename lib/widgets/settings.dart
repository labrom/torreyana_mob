import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/settings.dart';

class SettingsPageLink extends ConsumerWidget {

  const SettingsPageLink({required this.title, required this.route, super.key, this.push = false});
  final String title;
  final String route;
  final bool push;
  @override
  Widget build(BuildContext context, WidgetRef ref) => SimpleWidgetSetting(
        title: title,
        actionChild: IconButton(
          onPressed: () {
            context.navigate(ref, route, push: push);
          },
          icon: const Icon(Icons.chevron_right),
        ),
      );
}

class SettingsSection extends StatelessWidget {

  const SettingsSection({
    required this.title, required this.children, super.key,
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              title,
              style: context.textTheme.titleLarge,
            ),
          ),
          ...children,
        ],
      );
}

extension on BuildContext {
  get textTheme => null;
}

class SimpleWidgetSetting extends StatelessWidget {

  const SimpleWidgetSetting({
    required this.title, required this.actionChild, super.key,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final Widget actionChild;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: subtitle != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            subtitle!,
                            style: context.textTheme.titleSmall,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: context.textTheme.titleMedium,
                    ),
            ),
            actionChild,
          ],
        ),
      );
}

class ToggleSetting extends StatelessWidget {

  const ToggleSetting({
    required this.value, required this.title, super.key,
    this.onChanged,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final bool value;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) => SimpleWidgetSetting(
        title: title,
        subtitle: subtitle,
        actionChild: Switch(
          value: value,
          onChanged: onChanged,
        ),
      );
}

class ConnectedToggleSetting extends ConsumerWidget {

  const ConnectedToggleSetting({
    required this.settingKey, required this.title, super.key,
    this.subtitle,
  });
  final String settingKey;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ToggleSetting(
        title: title,
        subtitle: subtitle,
        value: ref
                .watch(firestoreUserSettingsRepositoryProvider)
                .whenData((settings) => settings[settingKey])
                .valueOrNull ==
            true,
        onChanged: ref.watch(firestoreUserSettingsRepositoryProvider).isLoading
            ? null
            : (value) {
                ref
                    .read(firestoreUserSettingsRepositoryProvider.notifier)
                    .write(settingKey, value);
              },
      );
}

class CachedToggleSetting extends ConsumerWidget {

  const CachedToggleSetting({
    required this.settingKey, required this.title, super.key,
    this.subtitle,
  });
  final String settingKey;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ToggleSetting(
        title: title,
        subtitle: subtitle,
        value:
            ref.watch(memorySessionDataRepositoryProvider)[settingKey] == true,
        onChanged: (value) {
          ref
              .read(memorySessionDataRepositoryProvider.notifier)
              .write(settingKey, value);
        },
      );
}
