import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/providers/flows.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/settings.dart';
import 'package:tourbillon/build_context.dart';

class SettingsPageLink extends ConsumerWidget {
  const SettingsPageLink({
    required this.title,
    required this.route,
    super.key,
    this.push = false,
    this.useSectionTitleStyle = false,
  });
  final String title;
  final String route;
  final bool push;
  final bool useSectionTitleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigate() {
      context.navigate(ref, route, push: push);
    }

    return SimpleWidgetSetting(
      title: title,
      useSectionTitleStyle: useSectionTitleStyle,
      actionChild: IconButton(
        onPressed: navigate,
        icon: const Icon(Icons.chevron_right),
      ),
      onTap: navigate,
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 8),
        child: Text(title, style: context.textTheme.titleLarge),
      ),
      ...children,
    ],
  );
}

class SimpleWidgetSetting extends StatelessWidget {
  const SimpleWidgetSetting({
    required this.title,
    required this.actionChild,
    super.key,
    this.subtitle,
    this.onTap,
    this.useSectionTitleStyle = false,
  });
  final String title;
  final String? subtitle;
  final Widget actionChild;
  final VoidCallback? onTap;

  /// Displays the title at the same size as a [SettingsSection] title.
  final bool useSectionTitleStyle;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
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
                        style: useSectionTitleStyle
                            ? context.textTheme.titleLarge
                            : context.textTheme.titleMedium,
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
                    style: useSectionTitleStyle
                        ? context.textTheme.titleLarge
                        : context.textTheme.titleMedium,
                  ),
          ),
          actionChild,
        ],
      ),
    ),
  );
}

class ToggleSetting extends StatelessWidget {
  const ToggleSetting({
    required this.value,
    required this.title,
    super.key,
    this.onChanged,
    this.subtitle,
    this.useSectionTitleStyle = false,
  });
  final String title;
  final String? subtitle;
  final bool value;
  final bool useSectionTitleStyle;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) => SimpleWidgetSetting(
    title: title,
    subtitle: subtitle,
    useSectionTitleStyle: useSectionTitleStyle,
    actionChild: Switch(value: value, onChanged: onChanged),
  );
}

class ConnectedToggleSetting extends ConsumerWidget {
  const ConnectedToggleSetting({
    required this.settingKey,
    required this.title,
    super.key,
    this.subtitle,
    this.useSectionTitleStyle = false,
  });
  final String settingKey;
  final String title;
  final String? subtitle;
  final bool useSectionTitleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ToggleSetting(
    title: title,
    subtitle: subtitle,
    useSectionTitleStyle: useSectionTitleStyle,
    value:
        ref
            .watch(userPreferencesRepositoryProvider)
            .whenData((settings) => settings[settingKey])
            .value ==
        true,
    onChanged: ref.watch(userPreferencesRepositoryProvider).isLoading
        ? null
        : (value) {
            ref
                .read(userPreferencesRepositoryProvider.notifier)
                .write(settingKey, value);
          },
  );
}

class CachedToggleSetting extends ConsumerWidget {
  const CachedToggleSetting({
    required this.settingKey,
    required this.title,
    super.key,
    this.subtitle,
    this.useSectionTitleStyle = false,
  });
  final String settingKey;
  final String title;
  final String? subtitle;
  final bool useSectionTitleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ToggleSetting(
    title: title,
    subtitle: subtitle,
    useSectionTitleStyle: useSectionTitleStyle,
    value: ref.watch(memorySessionDataRepositoryProvider)[settingKey] == true,
    onChanged: (value) {
      ref
          .read(memorySessionDataRepositoryProvider.notifier)
          .write(settingKey, value);
    },
  );
}
