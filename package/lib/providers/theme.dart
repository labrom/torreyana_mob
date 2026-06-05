import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

class ThemeConfig {
  ThemeConfig.initialize({
    required this.darkTheme,
    required this.seedColor,
    this.textThemeFunction,
  }) : themeData = null {
    _default = this;
  }

  ThemeConfig.fromThemeData(this.themeData)
    : darkTheme = themeData!.brightness == Brightness.dark,
      seedColor = themeData.colorScheme.primary,
      textThemeFunction = null {
    _default = this;
  }

  // ignore: prefer_constructors_over_static_methods
  static ThemeConfig get defaultTheme =>
      _default ?? ThemeConfig.initialize(darkTheme: false, seedColor: Colors.blue);

  static ThemeConfig? _default;

  final bool darkTheme;
  final Color seedColor;
  final ThemeData? themeData;
  final TextTheme Function([TextTheme? textTheme])? textThemeFunction;
}

@riverpod
class DarkTheme extends _$DarkTheme {
  @override
  bool build() => ThemeConfig.defaultTheme.darkTheme;

  void toggle() {
    state = !state;
  }
}

@riverpod
class ThemeSeedColor extends _$ThemeSeedColor {
  @override
  Color build() => ThemeConfig.defaultTheme.seedColor;

  // ignore: avoid_setters_without_getters
  set color(Color seed) {
    state = seed;
  }
}

@riverpod
ThemeData appThemeData(Ref ref) {
  final themeConfig = ThemeConfig.defaultTheme;
  final themeData = themeConfig.themeData;
  if (themeData != null) {
    return themeData;
  }

  final darkTheme = ref.watch(darkThemeProvider);
  final baseTextTheme = darkTheme ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(themeSeedColorProvider),
      brightness: darkTheme ? Brightness.dark : Brightness.light,
    ),
    textTheme: themeConfig.textThemeFunction?.call(baseTextTheme),
    useMaterial3: true,
  );
}
