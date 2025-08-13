// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeDataHash() => r'80c2e09117821d89bbecd4048556faad12f1ed7a';

/// See also [appThemeData].
@ProviderFor(appThemeData)
final appThemeDataProvider = AutoDisposeProvider<ThemeData>.internal(
  appThemeData,
  name: r'appThemeDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appThemeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppThemeDataRef = AutoDisposeProviderRef<ThemeData>;
String _$darkThemeHash() => r'c6c71e997187d4b229368a9404aa62c75ec4802d';

/// See also [DarkTheme].
@ProviderFor(DarkTheme)
final darkThemeProvider = AutoDisposeNotifierProvider<DarkTheme, bool>.internal(
  DarkTheme.new,
  name: r'darkThemeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$darkThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DarkTheme = AutoDisposeNotifier<bool>;
String _$themeSeedColorHash() => r'79d89badccabff04672951ae9c8c2e91b40d6c43';

/// See also [ThemeSeedColor].
@ProviderFor(ThemeSeedColor)
final themeSeedColorProvider =
    AutoDisposeNotifierProvider<ThemeSeedColor, Color>.internal(
  ThemeSeedColor.new,
  name: r'themeSeedColorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeSeedColorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeSeedColor = AutoDisposeNotifier<Color>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
