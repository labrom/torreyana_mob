import 'package:flutter/material.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/settings.dart';
import 'package:torreyana_mob/widgets/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    this.showProfileLink = false,
    this.showAppInfo = false,
    this.showThemeSettings = true,
    this.pushSubPages = true,
    this.children,
  });

  final bool showProfileLink;
  final bool showAppInfo;
  final bool showThemeSettings;
  final bool pushSubPages;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    final themeConfig = ThemeConfig.defaultTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (children != null) ...children!,
              SettingsSection(
                title: 'Profile',
                children: [
                  if (showProfileLink)
                    SettingsPageLink(
                      title: 'Manage your profile',
                      route: '/$profilePathSegment',
                      push: pushSubPages,
                    ),
                ],
              ),
              if (showThemeSettings && themeConfig.isCustomizable)
                SettingsPageLink(
                  title: 'Theme',
                  route: '/$settingsPathSegment/theme',
                  push: pushSubPages,
                ),
              if (showThemeSettings && themeConfig.hasFixedThemePair)
                const SettingsSection(
                  title: 'Theme',
                  children: [ThemeModeSetting()],
                ),
              if (showAppInfo)
                SettingsSection(
                  title: 'About',
                  children: [
                    SettingsPageLink(
                      title: 'App info',
                      route: '/$settingsPathSegment/$appInfoPathSegment',
                      push: pushSubPages,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
