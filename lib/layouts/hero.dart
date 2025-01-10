import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation.dart';

class HeroLayout1 extends StatelessWidget {
  final Text titleText;
  final Text? subtitleText;
  final Widget primaryCta;
  final Widget? secondaryCta;
  final Widget heroImage;

  HeroLayout1.fromTheme(
    BuildContext context, {
    Key? key,
    required String title,
    String? subtitle,
    bool centeredText = false,
    required String primaryCta,
    required String primaryRoutePath,
    String? secondaryCta,
    String? secondaryRoutePath,
    required Image heroImage,
  }) : this(
          key: key,
          titleText: _titleText(title, Theme.of(context), centeredText),
          subtitleText: subtitle != null
              ? _subtitleText(subtitle, Theme.of(context), centeredText)
              : null,
          primaryCta: _primaryCta(context, primaryRoutePath, primaryCta),
          secondaryCta: secondaryCta != null && secondaryRoutePath != null
              ? _secondaryCta(context, secondaryRoutePath, secondaryCta)
              : null,
          heroImage: heroImage,
        );

  const HeroLayout1({
    super.key,
    required this.titleText,
    this.subtitleText,
    required this.primaryCta,
    this.secondaryCta,
    required this.heroImage,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: titleText,
          ),
          if (subtitleText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: subtitleText!,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: primaryCta,
          ),
          if (secondaryCta != null) secondaryCta!,
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: heroImage,
          ),
        ],
      );
}

class HeroLayout2 extends StatelessWidget {
  final Text titleText;
  final Text? subtitleText;
  final Widget primaryCta;
  final Widget? secondaryCta;
  final Widget heroImage;

  HeroLayout2.fromTheme(
    BuildContext context, {
    Key? key,
    required String title,
    String? subtitle,
    bool centeredText = false,
    required String primaryCta,
    required String primaryRoutePath,
    String? secondaryCta,
    String? secondaryRoutePath,
    required Image heroImage,
  }) : this(
          key: key,
          titleText: _titleText(title, Theme.of(context), centeredText),
          subtitleText: subtitle != null
              ? _subtitleText(subtitle, Theme.of(context), centeredText)
              : null,
          primaryCta: _primaryCta(context, primaryRoutePath, primaryCta),
          secondaryCta: secondaryCta != null && secondaryRoutePath != null
              ? _secondaryCta(context, secondaryRoutePath, secondaryCta)
              : null,
          heroImage: heroImage,
        );

  const HeroLayout2({
    super.key,
    required this.titleText,
    this.subtitleText,
    required this.primaryCta,
    this.secondaryCta,
    required this.heroImage,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              heroImage,
              SizedBox(
                height: 24.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: titleText,
                    ),
                    if (subtitleText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: subtitleText!,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: primaryCta,
                    ),
                    if (secondaryCta != null) secondaryCta!,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

Text _titleText(String title, ThemeData themeData, bool centeredText) => Text(
      title,
      style: themeData.textTheme.displayLarge,
      textAlign: centeredText ? TextAlign.center : TextAlign.start,
    );

Text _subtitleText(String subtitle, ThemeData themeData, bool centeredText) =>
    Text(
      subtitle,
      style: themeData.textTheme.headlineSmall,
      textAlign: centeredText ? TextAlign.center : TextAlign.start,
    );

Widget _primaryCta(
        BuildContext context, String primaryRoutePath, String primaryCta) =>
    Consumer(
      builder: (context, ref, child) => ElevatedButton(
        onPressed: () {
          context.navigate(ref, primaryRoutePath);
        },
        child: child,
      ),
      child: Text(primaryCta),
    );

Widget _secondaryCta(
        BuildContext context, String secondaryRoutePath, String secondaryCta) =>
    Consumer(
      builder: (context, ref, child) => TextButton(
        onPressed: () {
          context.navigate(ref, secondaryRoutePath);
        },
        child: child!,
      ),
      child: Text(secondaryCta),
    );
