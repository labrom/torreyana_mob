import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../my_theme.dart';

part 'theme.g.dart';

@riverpod
class DarkTheme extends _$DarkTheme {
  @override
  bool build() => darkTheme;

  void toggle() {
    state = !state;
  }
}

@riverpod
class PrimaryColor extends _$PrimaryColor {
  @override
  Color build() => seedColor;

  // ignore: avoid_setters_without_getters
  set color(Color color) {
    state = color;
  }
}

@riverpod
ThemeData appThemeData(Ref ref) {
  final darkTheme = ref.watch(darkThemeProvider);
  final baseTextTheme = darkTheme ? ThemeData.dark().textTheme : ThemeData.light().textTheme;
  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ref.watch(primaryColorProvider),
      brightness: darkTheme
          ? Brightness.dark
          : Brightness.light,
    ),
    textTheme: textThemeFunction(baseTextTheme),
    useMaterial3: true,
  );
}
