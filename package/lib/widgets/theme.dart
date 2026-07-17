import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/settings.dart';
import 'package:torreyana_mob/widgets/theme_buttons.dart';

import 'package:tourbillon/build_context.dart';

/// A widget that allows to view and set the app's theme.
///
/// This widget uses [appThemeModeProvider] and [themeSeedColorProvider].
class ThemeBuilder extends ConsumerWidget {
  const ThemeBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => SettingsSection(
        title: 'Theme',
        children: [
          const ThemeModeSetting(),
          SimpleWidgetSetting(
            title: 'Theme seed color',
            subtitle: 'Pick a color to generate a color palette',
            actionChild: ThemePrimaryColorButton(
              initialColor: ref.watch(themeSeedColorProvider),
              pickerAlignment: PickerAlignment.rightBelow,
              onColor: (color) async {
                await ref
                    .read(themeSeedColorProvider.notifier)
                    .setColor(color);
              },
            ),
          ),
          const ThemeColorsView(),
        ],
      );
}

/// A setting that selects the system, light, or dark appearance.
class ThemeModeSetting extends ConsumerWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(value: ThemeMode.system, label: Text('System')),
        ButtonSegment(value: ThemeMode.light, label: Text('Light')),
        ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
      ],
      selected: {ref.watch(appThemeModeProvider)},
      showSelectedIcon: false,
      onSelectionChanged: (selection) async {
        await ref
            .read(appThemeModeProvider.notifier)
            .setThemeMode(selection.single);
      },
    ),
  );
}

/// A widget that shows the Material 3 colors currently used.
///
/// This widget shows the colors inherited from the active app theme.
class ThemeColorsView extends ConsumerWidget {

  const ThemeColorsView({super.key});

  EdgeInsets get _padding => const EdgeInsets.all(6);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = context.colorScheme;
    return Column(
      children: [
        Row(
          children: [
            _accentColorCell(
                context, 'Primary', scheme.primary, scheme.onPrimary),
            _containerColorCell('Primary container', scheme.primaryContainer,
                scheme.onPrimaryContainer),
          ],
        ),
        Row(
          children: [
            _accentColorCell(
                context, 'Secondary', scheme.secondary, scheme.onSecondary),
            _containerColorCell('Secondary container',
                scheme.secondaryContainer, scheme.onSecondaryContainer),
          ],
        ),
        Row(
          children: [
            _accentColorCell(
                context, 'Tertiary', scheme.tertiary, scheme.onTertiary),
            _containerColorCell('Tertiary container', scheme.tertiaryContainer,
                scheme.onTertiaryContainer),
          ],
        ),
        Row(
          children: [
            _accentColorCell(context, 'Error', scheme.error, scheme.onError),
            _containerColorCell('Error container', scheme.errorContainer,
                scheme.onErrorContainer),
          ],
        ),
        Row(
          children: [
            _colorCell('Surface', scheme.surface, scheme.onSurface),
            _colorCell('Surface variant', scheme.surfaceVariant,
                scheme.onSurfaceVariant),
          ],
        ),
        Row(
          children: [
            _colorCell('Outline', scheme.outline, scheme.onSurface),
            _colorCell('Outline variant', scheme.outlineVariant,
                scheme.onSurfaceVariant),
          ],
        ),
      ],
    );
  }

  Widget _colorCell(String text, Color color, Color onColor) => Expanded(
        child: Padding(
          padding: _padding,
          child: Container(
            height: 80,
            color: color,
            child: Padding(
              padding: _padding,
              child: Text(
                text,
                style: TextStyle(color: onColor),
              ),
            ),
          ),
        ),
      );

  Widget _accentColorCell(
          BuildContext context, String text, Color color, Color onColor) =>
      Expanded(
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: context.textTheme.titleLarge!.copyWith(
                      color: color,
                    ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(onColor),
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                ),
                child: Text(text),
              ),
            ],
          ),
        ),
      );

  Widget _containerColorCell(String text, Color color, Color onColor) =>
      Expanded(
        child: Padding(
          padding: _padding,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: color,
            ),
            child: Padding(
              padding: _padding,
              child: Text(
                text,
                style: TextStyle(color: onColor),
              ),
            ),
          ),
        ),
      );
}
