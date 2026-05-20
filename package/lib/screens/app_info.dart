import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:torreyana_mob/widgets/settings.dart';
import 'package:tourbillon/build_context.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App info')),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('App information is unavailable.'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final info = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SettingsSection(
                title: 'Application',
                children: [
                  _AppInfoRow(label: 'Name', value: info.appName),
                  _AppInfoRow(label: 'Package', value: info.packageName),
                  _AppInfoRow(label: 'Version', value: info.version),
                  _AppInfoRow(label: 'Build', value: info.buildNumber),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppInfoRow extends StatelessWidget {
  const _AppInfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: context.textTheme.titleMedium)),
        const SizedBox(width: 16),
        Flexible(
          child: SelectableText(
            value,
            textAlign: TextAlign.end,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}
