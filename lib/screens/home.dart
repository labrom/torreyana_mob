import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torreyana_mob/layouts/hero.dart';
import 'package:torreyana_mob/localization.dart';
import 'package:torreyana_mob/providers/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          Consumer(
            builder: (context, ref, child) => IconButton(
              icon: const Icon(Icons.settings),
              tooltip: apploc(context).settingsLabel,
              onPressed: () => context.navigate(ref, '/$settingsPathSegment'),
            ),
          ),
          Consumer(
            builder: (context, ref, child) => IconButton(
              icon: const Icon(Icons.person),
              tooltip: apploc(context).userProfileLabel,
              onPressed: () => context.navigate(ref, '/$profilePathSegment'),
            ),
          ),
        ],
      ),
      body: HeroLayout2.fromTheme(
        context,
        title: 'Peaceful earth',
        subtitle: 'Discover places where the grass is greener.',
        centeredText: true,
        primaryCta: 'Get started',
        primaryRoutePath: '/_flow/intro',
        heroImage: Image.asset(
          'assets/hills.jpg',
        ),
      ),
    );
  }
}
