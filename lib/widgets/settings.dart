import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/flows.dart';
import '../providers/settings.dart';

class SettingsPageLink extends StatelessWidget {
  final String title;
  final String route;

  const SettingsPageLink({super.key, required this.title, required this.route});
  @override
  Widget build(BuildContext context) => SimpleWidgetSetting(
        title: title,
        actionChild: IconButton(
          onPressed: () {
            context.go(route);
          },
          icon: const Icon(Icons.chevron_right),
        ),
      );
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...children,
        ],
      );
}

class SimpleWidgetSetting extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget actionChild;

  const SimpleWidgetSetting({
    super.key,
    required this.title,
    required this.actionChild,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: subtitle != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ),
            actionChild,
          ],
        ),
      );
}

class ToggleSetting extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final void Function(bool)? onChanged;

  const ToggleSetting({
    super.key,
    required this.value,
    required this.title,
    this.onChanged,
    this.subtitle,
  });

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
  final String settingKey;
  final String title;
  final String? subtitle;

  const ConnectedToggleSetting({
    super.key,
    required this.settingKey,
    required this.title,
    this.subtitle,
  });

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
  final String settingKey;
  final String title;
  final String? subtitle;

  const CachedToggleSetting({
    super.key,
    required this.settingKey,
    required this.title,
    this.subtitle,
  });

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
