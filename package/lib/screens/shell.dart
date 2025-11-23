import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/providers/navigation.dart';

part 'shell.g.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({
    required this.child,
    required this.destinations,
    this.appBar,
    this.extendBodyBehindAppBar = false,
    super.key,
  });

  final AppBar? appBar;
  final bool extendBodyBehindAppBar;
  final Widget child;
  final List<Destination> destinations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: appBar != null && extendBodyBehindAppBar,
      appBar: appBar,
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: destinations
            .map((dest) => NavigationDestination(icon: dest.icon, label: dest.label))
            .toList(),
        selectedIndex: ref.watch(selectedNavTabProvider),
        onDestinationSelected: (value) {
          ref.read(selectedNavTabProvider.notifier).tabIndex = value;
          context.navigate(ref, destinations[value].screen.name);
        },
      ),
    );
  }
}

@riverpod
class SelectedNavTab extends _$SelectedNavTab {
  @override
  int build() => 0;

  // ignore: avoid_setters_without_getters
  set tabIndex(int index) {
    state = index;
  }
}
