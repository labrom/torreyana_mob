import 'package:flutter/material.dart';

import '../providers/navigation.dart';
import '../widgets/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SettingsSection(
                title: 'Profile',
                children: [
                  ConnectedToggleSetting(
                      settingKey: 'visible',
                      title: 'Public profile',
                      subtitle:
                          'Profile information can be seen by everybody.'),
                ],
              ),
              SettingsPageLink(
                  title: 'Theme', route: '/$settingsPathSegment/theme'),
            ],
          ),
        ),
      ),
    );
  }
}
