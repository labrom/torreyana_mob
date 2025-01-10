import 'package:flutter/material.dart';
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

  void setColor(Color color) {
    state = color;
  }
}

@riverpod
ThemeData appThemeData(AppThemeDataRef ref) {
  return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ref.watch(primaryColorProvider),
          brightness: ref.watch(darkThemeProvider)
              ? Brightness.dark
              : Brightness.light),
      useMaterial3: true);
}
