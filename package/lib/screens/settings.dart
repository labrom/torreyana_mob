import 'package:flutter/material.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/widgets/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.showProfileLink = false, this.showThemeSettings = true, this.pushSubPages = true, this.children});

  final bool showProfileLink;
  final bool showThemeSettings;
  final bool pushSubPages;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (children != null)
              ...children!,
              SettingsSection(
                title: 'Profile',
                children: [
                  if (showProfileLink)
                    SettingsPageLink(
                      title: 'Manage your profile',
                      route: '/$profilePathSegment',
                      push: pushSubPages,
                    ),
                  const ConnectedToggleSetting(
                    settingKey: 'visible',
                    title: 'Public profile',
                    subtitle: 'Profile information can be seen by everybody.',
                  ),
                ],
              ),
              if (showThemeSettings)
              SettingsPageLink(
                title: 'Theme',
                route: '/$settingsPathSegment/theme',
                push: pushSubPages,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
