import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

class ThemeConfig {
  
  ThemeConfig._({required this.darkTheme, required this.seedColor, this.textThemeFunction});

  static late final ThemeConfig _default;
  static void initialize({required bool darkTheme, required Color seedColor, TextTheme Function([TextTheme? textTheme])? textThemeFunction}) {
    _default = ThemeConfig._(darkTheme: darkTheme, seedColor: seedColor, textThemeFunction: textThemeFunction,);
  }

  final bool darkTheme;
  final Color seedColor;
  final TextTheme Function([TextTheme? textTheme])? textThemeFunction;
}

@riverpod
class DarkTheme extends _$DarkTheme {
  @override
  bool build() => ThemeConfig._default.darkTheme;

  void toggle() {
    state = !state;
  }
}

@riverpod
class ThemeSeedColor extends _$ThemeSeedColor {
  @override
  Color build() => ThemeConfig._default.seedColor;

  // ignore: avoid_setters_without_getters
  set color(Color seed) {
    state = seed;
  }
}

@riverpod
ThemeData appThemeData(Ref ref) {
  final darkTheme = ref.watch(darkThemeProvider);
  final baseTextTheme = darkTheme ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(themeSeedColorProvider),
      brightness: darkTheme ? Brightness.dark : Brightness.light,
    ),
    textTheme: ThemeConfig._default.textThemeFunction?.call(baseTextTheme),
    useMaterial3: true,
  );
}
