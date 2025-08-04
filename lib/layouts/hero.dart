import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/providers/navigation.dart';
import 'package:tourbillon/build_context.dart';

class HeroLayout1 extends StatelessWidget {

  const HeroLayout1({
    required this.titleText, required this.primaryCta, required this.heroImage, super.key,
    this.subtitleText,
    this.secondaryCta,
  });

  HeroLayout1.fromTheme(
    BuildContext context, {
    required String title, required String primaryCta, required String primaryRoutePath, required Image heroImage, Key? key,
    String? subtitle,
    bool centeredText = false,
    String? secondaryCta,
    String? secondaryRoutePath,
  }) : this(
          key: key,
          titleText: _titleText(title, context.textTheme, centeredText),
          subtitleText: subtitle != null
              ? _subtitleText(subtitle, context.textTheme, centeredText)
              : null,
          primaryCta: _primaryCta(context, primaryRoutePath, primaryCta),
          secondaryCta: secondaryCta != null && secondaryRoutePath != null
              ? _secondaryCta(context, secondaryRoutePath, secondaryCta)
              : null,
          heroImage: heroImage,
        );
  final Text titleText;
  final Text? subtitleText;
  final Widget primaryCta;
  final Widget? secondaryCta;
  final Widget heroImage;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: titleText,
          ),
          if (subtitleText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: subtitleText,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: primaryCta,
          ),
          if (secondaryCta != null) secondaryCta!,
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: heroImage,
          ),
        ],
      );
}

class HeroLayout2 extends StatelessWidget {

  const HeroLayout2({
    required this.titleText, required this.primaryCta, required this.heroImage, super.key,
    this.subtitleText,
    this.secondaryCta,
  });

  HeroLayout2.fromTheme(
    BuildContext context, {
    required String title, required String primaryCta, required String primaryRoutePath, required Image heroImage, Key? key,
    String? subtitle,
    bool centeredText = false,
    String? secondaryCta,
    String? secondaryRoutePath,
  }) : this(
          key: key,
          titleText: _titleText(title, context.textTheme, centeredText),
          subtitleText: subtitle != null
              ? _subtitleText(subtitle, context.textTheme, centeredText)
              : null,
          primaryCta: _primaryCta(context, primaryRoutePath, primaryCta),
          secondaryCta: secondaryCta != null && secondaryRoutePath != null
              ? _secondaryCta(context, secondaryRoutePath, secondaryCta)
              : null,
          heroImage: heroImage,
        );
  final Text titleText;
  final Text? subtitleText;
  final Widget primaryCta;
  final Widget? secondaryCta;
  final Widget heroImage;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              heroImage,
              SizedBox(
                height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: titleText,
                    ),
                    if (subtitleText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: subtitleText,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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

Text _titleText(String title, TextTheme textTheme, bool centeredText) => Text(
      title,
      style: textTheme.displayLarge,
      textAlign: centeredText ? TextAlign.center : TextAlign.start,
    );

Text _subtitleText(String subtitle, TextTheme textTheme, bool centeredText) =>
    Text(
      subtitle,
      style: textTheme.headlineSmall,
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
