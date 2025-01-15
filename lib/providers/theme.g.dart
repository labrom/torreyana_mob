// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeDataHash() => r'ae069898f37c8b3fc61ba0d8c39198d1f8ed3d30';

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
String _$darkThemeHash() => r'7b5d730c790fa3347a650604421f023612871a84';

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
String _$primaryColorHash() => r'9f3dfcb29208c845480c85f07bee4288c683b63e';

/// See also [PrimaryColor].
@ProviderFor(PrimaryColor)
final primaryColorProvider =
    AutoDisposeNotifierProvider<PrimaryColor, Color>.internal(
  PrimaryColor.new,
  name: r'primaryColorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$primaryColorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PrimaryColor = AutoDisposeNotifier<Color>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
