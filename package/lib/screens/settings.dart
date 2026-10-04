import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/providers/theme.dart';
import 'package:torreyana_mob/widgets/settings.dart';
import 'package:torreyana_mob/widgets/theme.dart';
import 'package:tourbillauth/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    this.showProfileLink = false,
    this.showAppInfo = false,
    this.showThemeSettings = true,
    this.pushSubPages = true,
    this.termsOfServiceUrl,
    this.privacyPolicyUrl,
    this.copyrightMention,
    this.children,
  });

  final bool showProfileLink;
  final bool showAppInfo;
  final bool showThemeSettings;
  final bool pushSubPages;
  final String? termsOfServiceUrl;
  final String? privacyPolicyUrl;
  final String? copyrightMention;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    final themeConfig = ThemeConfig.defaultTheme;
    final showFooter = showAppInfo || copyrightMention != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, showFooter ? 0 : 16),
            sliver: SliverList.list(
              children: [
                if (showProfileLink) _ProfileSettingsLink(push: pushSubPages),
                if (children != null) ...children!,
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
                if (termsOfServiceUrl != null || privacyPolicyUrl != null)
                  SettingsSection(
                    title: 'About',
                    children: [
                      if (termsOfServiceUrl != null)
                        _ExternalSettingsLink(
                          title: 'Terms of Service',
                          url: termsOfServiceUrl!,
                        ),
                      if (privacyPolicyUrl != null)
                        _ExternalSettingsLink(
                          title: 'Privacy Policy',
                          url: privacyPolicyUrl!,
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (showFooter)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _AppFooter(
                    showVersion: showAppInfo,
                    copyrightMention: copyrightMention,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileSettingsLink extends ConsumerWidget {
  const _ProfileSettingsLink({required this.push});

  final bool push;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final name = user?.displayName?.trim() ?? '';
    final photoUrl = user?.photoURL?.trim() ?? '';

    return SettingsPageLink(
      title: name.isEmpty ? 'Profile' : name,
      titleStyle: Theme.of(context).textTheme.headlineSmall,
      subtitle: 'Manage your profile',
      leading: CircleAvatar(
        radius: 28,
        foregroundImage: photoUrl.isEmpty ? null : NetworkImage(photoUrl),
        onForegroundImageError: photoUrl.isEmpty ? null : (_, _) {},
        child: const Icon(Icons.person),
      ),
      route: '/$profilePathSegment',
      push: push,
    );
  }
}

class _AppFooter extends StatelessWidget {
  const _AppFooter({required this.showVersion, required this.copyrightMention});

  final bool showVersion;
  final String? copyrightMention;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    final copyright = copyrightMention;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          if (showVersion)
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final info = snapshot.data;
                if (info == null) return const SizedBox.shrink();

                return Text(
                  'Version ${info.version} (${info.buildNumber})',
                  textAlign: TextAlign.center,
                  style: style,
                );
              },
            ),
          if (copyright != null)
            Text(copyright, textAlign: TextAlign.center, style: style),
        ],
      ),
    );
  }
}

class _ExternalSettingsLink extends StatelessWidget {
  const _ExternalSettingsLink({required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(url);
    Future<void> openUrl() async {
      await launchUrl(uri);
    }

    return SimpleWidgetSetting(
      title: title,
      actionChild: IconButton(
        onPressed: openUrl,
        icon: const Icon(Icons.open_in_new),
      ),
      onTap: openUrl,
    );
  }
}
