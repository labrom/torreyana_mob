import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torreyana_mob/providers/settings.dart';

part 'theme.g.dart';

const themeModePreferenceKey = 'themeMode';
const darkThemePreferenceKey = 'darkTheme';
const themeSeedColorPreferenceKey = 'themeSeedColor';

class ThemeConfig {
  ThemeConfig.initialize({
    required this.darkTheme,
    required this.seedColor,
    this.textThemeFunction,
  }) : darkThemeData = null,
       lightThemeData = null,
       themeData = null {
    _default = this;
  }

  ThemeConfig.fromThemeData(ThemeData this.themeData)
    : darkTheme = themeData.brightness == Brightness.dark,
      seedColor = themeData.colorScheme.primary,
      darkThemeData = null,
      lightThemeData = null,
      textThemeFunction = null {
    _default = this;
  }

  ThemeConfig.fromThemeDataPair({
    required ThemeData lightTheme,
    required ThemeData darkTheme,
    bool useDarkTheme = false,
  }) : darkTheme = useDarkTheme,
       seedColor = (useDarkTheme ? darkTheme : lightTheme).colorScheme.primary,
       darkThemeData = darkTheme,
       lightThemeData = lightTheme,
       themeData = null,
       textThemeFunction = null {
    _default = this;
  }

  // ignore: prefer_constructors_over_static_methods
  static ThemeConfig get defaultTheme =>
      _default ??
      ThemeConfig.initialize(darkTheme: false, seedColor: Colors.blue);

  static ThemeConfig? _default;

  final bool darkTheme;
  final Color seedColor;
  final ThemeData? darkThemeData;
  final ThemeData? lightThemeData;
  final ThemeData? themeData;
  final TextTheme Function([TextTheme? textTheme])? textThemeFunction;

  /// Whether the app uses one fixed theme with no user-configurable options.
  bool get hasFixedTheme => themeData != null;

  /// Whether the app uses fixed light and dark themes selected by the user.
  bool get hasFixedThemePair => lightThemeData != null && darkThemeData != null;

  /// Whether users can configure the generated theme on a separate screen.
  bool get isCustomizable => !hasFixedTheme && !hasFixedThemePair;
}

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    ref.listen(userPreferencesRepositoryProvider, (previous, next) {
      next.when(
        data: (preferences) => state = _themeModeFrom(preferences),
        loading: () => state = _defaultThemeMode,
        error: (_, _) => state = _defaultThemeMode,
      );
    });
    return _defaultThemeMode;
  }

  Future<void> setThemeMode(ThemeMode value) async {
    state = value;
    await ref
        .read(userPreferencesRepositoryProvider.notifier)
        .write(themeModePreferenceKey, value.name);
  }
}

@riverpod
class ThemeSeedColor extends _$ThemeSeedColor {
  @override
  Color build() {
    ref.listen(userPreferencesRepositoryProvider, (previous, next) {
      next.when(
        data: (preferences) => state = _seedColorFrom(preferences),
        loading: () => state = ThemeConfig.defaultTheme.seedColor,
        error: (_, _) => state = ThemeConfig.defaultTheme.seedColor,
      );
    });
    return ThemeConfig.defaultTheme.seedColor;
  }

  // ignore: avoid_setters_without_getters
  set color(Color seed) {
    unawaited(setColor(seed));
  }

  Future<void> setColor(Color seed) async {
    state = seed;
    await ref
        .read(userPreferencesRepositoryProvider.notifier)
        .write(themeSeedColorPreferenceKey, seed.toARGB32());
  }
}

ThemeMode get _defaultThemeMode =>
    ThemeConfig.defaultTheme.darkTheme ? ThemeMode.dark : ThemeMode.light;

ThemeMode _themeModeFrom(Map<String, dynamic> preferences) {
  final savedThemeMode = preferences[themeModePreferenceKey];
  if (savedThemeMode is String) {
    for (final themeMode in ThemeMode.values) {
      if (themeMode.name == savedThemeMode) return themeMode;
    }
  }

  // Continue to support preferences written before ThemeMode was used.
  final savedDarkTheme = preferences[darkThemePreferenceKey];
  if (savedDarkTheme is bool) {
    return savedDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }
  return _defaultThemeMode;
}

Color _seedColorFrom(Map<String, dynamic> preferences) {
  final savedSeedColor = preferences[themeSeedColorPreferenceKey];
  return savedSeedColor is int
      ? Color(savedSeedColor)
      : ThemeConfig.defaultTheme.seedColor;
}

@riverpod
ThemeData appLightThemeData(Ref ref) {
  final themeConfig = ThemeConfig.defaultTheme;
  if (themeConfig.lightThemeData case final lightThemeData?) {
    return lightThemeData;
  }
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(themeSeedColorProvider),
      // ignore: avoid_redundant_argument_values
      brightness: Brightness.light,
    ),
    textTheme: themeConfig.textThemeFunction?.call(ThemeData.light().textTheme),
    useMaterial3: true,
  );
}

@riverpod
ThemeData appDarkThemeData(Ref ref) {
  final themeConfig = ThemeConfig.defaultTheme;
  if (themeConfig.darkThemeData case final darkThemeData?) {
    return darkThemeData;
  }
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(themeSeedColorProvider),
      brightness: Brightness.dark,
    ),
    textTheme: themeConfig.textThemeFunction?.call(ThemeData.dark().textTheme),
    useMaterial3: true,
  );
}
